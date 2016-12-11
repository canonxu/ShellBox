#!/usr/bin/expect

host=139.196.55.120

user=$1
psaawrd=$2

spawn /usr/bin/ssh $user@$host
expect "*assword:"
send $2"\r"
interact


