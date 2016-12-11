#!/usr/bin/expect -f

set host 139.196.55.120

set user [lindex $argv 0]
set passwd [lindex $argv 1]

spawn /usr/bin/ssh $user@$host
expect "*assword:"
send "$passwd\r"
interact


