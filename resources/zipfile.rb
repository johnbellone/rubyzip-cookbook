#
# Cookbook: rubyzip
# License: Apache 2.0
#
# Copyright 2010, VMware, Inc.
# Copyright 2011-2015, Chef Software, Inc.
# Copyright 2016, Bloomberg Finance L.P.
#
require 'find'

property :path, String, name_property: true
property :source, String
property :overwrite, [TrueClass, FalseClass], default: false
property :checksum, String

action :unzip do
  include_recipe 'rubyzip::default'

  Chef::Log.debug("unzip #{new_resource.source} => #{new_resource.path} (overwrite=#{new_resource.overwrite})")

  Zip::File.open(cached_file(new_resource.source, new_resource.checksum)) do |zip|
    zip.each do |entry|
      path = ::File.join(new_resource.path, entry.name)
      FileUtils.mkdir_p(::File.dirname(path))
      if new_resource.overwrite && ::File.exist?(path) && !::File.directory?(path)
        FileUtils.rm(path)
      end
      zip.extract(entry, path)
    end
  end
  new_resource.updated_by_last_action(true)
end

action :zip do
  include_recipe 'rubyzip::default'

  new_resource.source.downcase.gsub!(::File::SEPARATOR, ::File::ALT_SEPARATOR)
  new_resource.path.downcase.gsub!(::File::SEPARATOR, ::File::ALT_SEPARATOR)
  Chef::Log.debug("zip #{new_resource.source} => #{new_resource.path} (overwrite=#{new_resource.overwrite})")

  if new_resource.overwrite == false && ::File.exist?(new_resource.path)
    Chef::Log.info("file #{new_resource.path} already exists and overwrite is set to false, exiting")
  else
    # delete the archive if it already exists, because we are recreating it.
    ::File.unlink(new_resource.path) if ::File.exist?(new_resource.path)
    # only supporting compression of a single directory (recursively).
    if ::File.directory?(new_resource.source)
      z = Zip::File.new(new_resource.path, true)
      unless new_resource.source =~ /::File::ALT_SEPARATOR$/
        new_resource.source << ::File::ALT_SEPARATOR
      end
      Find.find(new_resource.source) do |f|
        f.downcase.gsub!(::File::SEPARATOR, ::File::ALT_SEPARATOR)
        # don't add root directory to the zipfile.
        next if f == new_resource.source
        # strip the root directory from the filename before adding it to the zipfile.
        zip_fname = f.sub(new_resource.source, '')
        Chef::Log.debug("adding #{zip_fname} to archive, sourcefile is: #{f}")
        z.add(zip_fname, f)
      end
      z.close
      new_resource.updated_by_last_action(true)
    else
      Chef::Log.info("Single directory must be specified for compression, and #{new_resource.source} does not meet that criteria.")
    end
  end
end
