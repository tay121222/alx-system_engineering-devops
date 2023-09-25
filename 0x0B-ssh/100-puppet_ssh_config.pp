# Puppet manifest to configure SSH client
exec { 'ssh_identityfile':
  command    => "grep -q '^IdentityFile ~/.ssh/school' ~/.ssh/config || echo 'IdentityFile ~/.ssh/school' >> ~/.ssh/config",
  path    => '/bin:/usr/bin:/usr/local/bin',
  creates     => '/home/tay121222/.ssh/config',
  refreshonly => true,
}

exec { 'ssh_passwordauthentication':
  command => "grep -q '^PasswordAuthentication no' ~/.ssh/config || echo 'PasswordAuthentication no' >> ~/.ssh/config"
  path    => '/bin:/usr/bin:/usr/local/bin',
  creates     => '/home/tay121222/.ssh/config',
  refreshonly => true,
}
