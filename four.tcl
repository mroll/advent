package require md5


set secret bgvyzdsv

proc prefix { string n } { string range $string 0 $n-1 }

proc hasprefix { string pref } {
    string equal [string range $string 0 [string length $pref]-1] $pref
}

proc goodhash { hash } { hasprefix $hash 00000 }

# set i 1
# while 1 {
#     set input [join [list $secret $i] ""]
#     set hash [md5::md5 -hex [join [list $secret $i] ""]]
#     puts $hash
# 
#     if { [goodhash $hash] } { break }
# 
#     incr i
# }

puts [md5::md5 -hex abcdef609043]
