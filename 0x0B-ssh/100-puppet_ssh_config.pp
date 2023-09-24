# Puppet manifest to configure SSH client
file { '/etc/ssh/ssh_config':
  ensure  => 'file',
  content => "IdentityFile ~/.ssh/school\nPasswordAuthentication no\n",
  replace => 'no',
  owner   => 'tay121222',
  mode    => '0600',
}
