require 'spec_helper'
 
describe 'testweb', :type => 'class' do

let(:node) { 'node_centos' }

it do
should contain_file('/opt/jboss-as-7.1.1.Final/standalone/deployments/testweb.war').with({
'ensure' => 'present',
'mode' => '0755',
})
end
it do
should contain_service('jboss').with({
'ensure' => 'running',
'enable' => 'true',
'hasrestart' => 'true',
})
end
it { should contain_package('java').with_name('openjdk-7-jdk') }
end


