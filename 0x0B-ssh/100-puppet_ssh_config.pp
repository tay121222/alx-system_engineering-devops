# Puppet manifest to configure SSH client
file { '/home/tay121222/.ssh/config':
  ensure  => 'file',
  content => "IdentityFile ~/.ssh/school\nPasswordAuthentication no\n",
  replace => 'no',
  owner   => 'tay121222',
  mode    => '0600',
}
