source utils.tcl

proc surface_area { dims } {
    lassign $dims l w h
    expr { (2*$l*$w) + (2*$w*$h) + (2*$h*$l) }
}

proc extra { dims } {
    reduce [lrange [lsort -real $dims] 0 1] *
}

proc paper { dims } {
    expr { [surface_area $dims] + [extra $dims] }
}

set sqrft 0

set data [string range [fread two.data] 0 end-1]
foreach present [split $data "\n"] {
    incr sqrft [paper [split $present x]]
}

# puts $sqrft
#

proc perimeter { dims } {
    set perim 0
    foreach d [lmins 2 -real $dims] {
        incr perim [expr { 2 * $d }]
    }

    set perim
}

proc bow { dims } { reduce $dims * }

proc ribbonlength { dims } {
    expr { [perimeter $dims] + [bow $dims] }
}

set ribbonlen 0
foreach present [split $data \n] {
    incr ribbonlen [ribbonlength [split $present x]]
}

puts $ribbonlen
