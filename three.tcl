source utils.tcl

proc addx { pt v } { lreplace $pt 0 0 [expr { [lindex $pt 0] + $v }] }
proc addy { pt v } { lreplace $pt 1 1 [expr { [lindex $pt 1] + $v }] }

proc < { pt } { addx $pt -1 }
proc > { pt } { addx $pt  1 }
proc v { pt } { addy $pt -1 }
proc ^ { pt } { addy $pt  1 }

set data [split [string range [fread three.data] 0 end-1] ""]

set pt {0 0}
set houses [list $pt]

# foreach dir $data { lappend houses [set pt [$dir $pt]] }

# puts [llength [lsort -unique $houses]]
#

set robotsanta {0 0}
set santa {0 0}

forindex i $data {
    set dir [lindex $data $i]
    if { $i % 2 == 0 } {
        lappend houses [set santa [$dir $santa]]
    } else {
        lappend houses [set robotsanta [$dir $robotsanta]]
    }
}

puts [llength [lsort -unique $houses]]
