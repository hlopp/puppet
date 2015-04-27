node 'node_centos'{
include 'java'
class { 'jboss':
install => 'source',
version => '7',
bindaddr => '192.168.33.10',
}
include 'jboss'
include 'testweb'
class {testweb:}
}
