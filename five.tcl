source utils.tcl

proc 2pairs? { string } { regexp {.*(\w{2}).*\1.*} $string }
proc hasdouble { string } { regexp {.*(\w)\1.*} $string }
proc hassandwich { string } { regexp {.*(\w)\w\1.*} $string }
proc nvowels? { n string } { expr { [regexp -all {[aeiou]} $string] >= $n } }

proc nice1 { string } {
    expr { [nvowels? 3 $string] & [hasdouble $string] & ! [regexp {.*ab|cd|pq|xy.*} $string] }
}

proc nice2 { string } {
    expr { [hassandwich $string] & [2pairs? $string] }
}

set data [getlines five.data]

# set numnice1 0
# foreach line $data {
#     if { [nice1 $line] } { incr numnice }
# }

# puts $numnice
#

set numnice2 0
foreach line $data {
    if { [nice2 $line] } { incr numnice }
}

puts $numnice
