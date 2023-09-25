# Puppet manifest to configure SSH client
file_line { 'ssh_identityfile':
  path    => '/home/tay121222/.ssh/config',
  line    => 'IdentityFile ~/.ssh/school',
  ensure  => present,
  match   => '^IdentityFile.*',
}

file_line { 'ssh_password_authentication':
  path    => '/home/tay121222/.ssh/config',
  line    => 'PasswordAuthentication no',
  ensure  => present,
  match   => '^PasswordAuthentication.*',
}
