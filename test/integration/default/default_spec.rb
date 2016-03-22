describe directory('/opt/consul-webui') do
  it { should be_directory }
end

describe file('/opt/consul-webui/index.html') do
  it { should exist }
  it { should be_file }
  it { should be_readable }
  it { should be_owned_by 'root' }
end
