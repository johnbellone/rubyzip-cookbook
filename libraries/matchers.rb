if defined?(ChefSpec)
  def zip_zipfile(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:zipfile, :zip, resource_name)
  end

  def unzip_zipfile(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:zipfile, :unzip, resource_name)
  end
end
