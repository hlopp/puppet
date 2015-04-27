class testweb  {

include jboss

package { 'install_unzip':
name	=> 'unzip',
ensure	=> installed,
}

package { 'install_wget':
name    => 'wget',
ensure  => installed,
}

$apps_name = testweb

# $deployment_path = $jboss::real_data_dir 

$deployment_path = '/opt/jboss-as-7.1.1.Final/standalone/deployments'

exec { 'retrieve_application':
  command => "/usr/bin/wget http://www.cumulogic.com/download/Apps/${apps_name}.zip -O /tmp/${apps_name}.zip",
  creates => "/tmp/${apps_name}.zip",
 }
 

 file { 'application_downloaded':
  mode => 0755,
  path => "/tmp/${apps_name}.zip",
  require => Exec["retrieve_application"],
  replace => "true",
 }

exec {"dir_tmp":
  command => "/bin/mkdir -p /tmp/tmp_$apps_name",
  creates => "/tmp/tmp_$apps_name",

}

 exec {   
    "apps_unzip_${apps_name}":
    cwd     => "/tmp/tmp_$apps_name",
    command => "/usr/bin/unzip /tmp/${apps_name}.zip ",
    creates => "/tmp/tmp_$apps_name/${apps_name}/$apps_name.war",
    require =>  [Exec["dir_tmp"],File['application_downloaded']],

 }

file { "deploy_war":
    source =>"/tmp/tmp_$apps_name/$apps_name/$apps_name.war",
    mode => 0755,
    path => "$deployment_path/$apps_name.war",
    replace => true,
    require => Exec["apps_unzip_$apps_name"],
}

file { "deploy_xml":
    source => "puppet:///modules/testweb/testweb.xml",
    mode => 0755,
    path => "$deployment_path/testweb.xml",
    replace => true,
    require => File["deploy_war"],
    notify => Service['jboss'],

}

exec {"delete_old_tmp_$apps_name":
  command => "/bin/rm -rf /tmp/tmp_${apps_name}", 
  require => File ["deploy_xml"],

}

exec {"delete_old_$apps_name.zip":
  command => "/bin/rm -rf /tmp/${apps_name}.zip",
  require => File ["deploy_xml"],

}



}


