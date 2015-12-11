
set name foo
set body { puts hello }

proc $name { } $body
proc bar { } { 5 }

set names { a b c }

foreach name $names {
    proc $name { } { foo }
}

proc hi { } { puts [info level 0] }

puts [regexp {.*([bc])\1.*} adsfbccadsf]
