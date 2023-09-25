# Puppet manifest to configure SSH client
file_line { 'ssh_identityfile':
  path    => '/etc/ssh/ssh_config',
  line    => 'IdentityFile ~/.ssh/school',
  ensure  => present,
  match   => '^IdentityFile.*',
}

file_line { 'ssh_password_authentication':
  path    => '/etc/ssh/ssh_config',
  line    => 'PasswordAuthentication no',
  ensure  => present,
  match   => '^PasswordAuthentication.*',
}
