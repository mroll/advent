source utils.tcl

set floor 0

set lefts  {}
set rights {}

set data [string range [fread one.data] 0 end-1]
set parenlist [split $data ""]

foreach p $parenlist {
    if { [string equal $p )] } {
        lappend rights $p
    } else {
        lappend lefts $p
    }
}

# puts [expr { [llength $lefts] - [llength $rights] }]
#

set i 0
foreach p $parenlist {
    incr i
    if { [string equal $p (] } {
        incr floor
    } else {
        incr floor -1
    }
    if { $floor == -1 } { break }
}

puts $i
