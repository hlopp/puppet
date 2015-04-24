
node 'default' {
include '::mysql::server'


mysql::db { 'test_db':
  user     => 'test_user',
  password => 'mypass',
  host     => 'localhost',
  grant    => ['ALL'],
}

}


