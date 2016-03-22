name 'rubyzip-default'
default_source :community
cookbook 'fixture', path: File.expand_path('../../cookbooks/fixture', __FILE__)
cookbook 'rubyzip', path: File.expand_path('../../../..', __FILE__)
run_list 'fixture::default'
