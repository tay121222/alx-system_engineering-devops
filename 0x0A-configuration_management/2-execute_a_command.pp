# create a manifest that kills a process named killmenow

exec { 'Kill_process_killmenow':
command => '/usr/bin/pkill killmenow',
}
