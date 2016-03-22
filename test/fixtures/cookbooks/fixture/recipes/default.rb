include_recipe 'rubyzip::default'

zipfile 'consul_0.6.4_web_ui.zip' do
  path '/opt/consul-webui'
  overwrite true
  source 'https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_web_ui.zip'
  checksum '5f8841b51e0e3e2eb1f1dc66a47310ae42b0448e77df14c83bb49e0e0d5fa4b7'
end
