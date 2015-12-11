proc K { x y } { set x }

proc fread { fname } {
    K [read [set fp [open $fname]]] [close $fp]
}

proc lmins { n cmp list } {
    lrange [lsort $cmp $list] 0 $n-1
}

proc lmin { list } {
    set min [lindex $list 0]
    foreach x $list { if { $x < $min } { set min $x } }

    set min
}

proc reduce { list agg } {
    set res [lindex $list 0]

    foreach x [lrange $list 1 end] {
        set res [$agg $res $x]
    }
    set res
}


proc * { x y } { expr { $x * $y } }

proc forindex { i list body } {
    set len [llength $list]
    set script [subst { for {set $i 0} {$$i < $len} {incr $i} { $body } }]

    uplevel $script
}

proc getlines { fname } { lrange [split [fread $fname] \n] 0 end-1 }

namespace eval ::memoize {
    variable Memo
}

proc ::memoize::memoize {} {
    variable Memo
    set cmd [info level -1]
    if {[info level] > 2 && [lindex [info level -2] 0] eq "memoize::memoize"} return
    if { ! [info exists Memo($cmd)]} {set Memo($cmd) [eval $cmd]}
    return -code return $Memo($cmd)
}

