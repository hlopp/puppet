package { 'nginx':
ensure=>'installed'
}
notify { 'Nginx is installed.':
}
service { 'nginx':
ensure=>'running'
}
notify { 'Nginx is running.':
}
