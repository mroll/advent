proc getoperand { x } {
    if { [string is integer $x] } {
        set command $x
    } else {
        set command \[advent::$x\]
    }

    set command
}

proc transform0 { expr } {
    if { [string is integer [lindex $expr 0]] } {
        set script "return [concat $expr]"
    } else {
        set script [concat advent::$expr]
    }

    set script
}

proc transform1 { expr } {
    set arg [getoperand [lindex $expr 1]]
    set op  [dict get $::ops [lindex $expr 0]]

    if { [string equal $op ~] } {
        set script "expr { 65536 + ($op $arg) }"
    } else {
        set script "expr { $op $arg }"
    }

    set script
}

proc transform2 { expr } {
    set arg1 [getoperand [lindex $expr 0]]
    set arg2 [getoperand [lindex $expr 2]]
    set op   [dict get $::ops [lindex $expr 1]]

    set script "expr { $arg1 $op $arg2 }"
}

proc transform { expr } {
    if { [llength $expr] == 1 } {
        set script [transform0 $expr]
    } elseif { [llength $expr] == 2 } {
        set script [transform1 $expr]
    } else {
        set script [transform2 $expr]
    }

    set script
}

proc parse { fname } {
    set data [fread $fname]

    foreach item [lrange [split $data \n] 0 end-1] {
        set fields [split $item ->]
        
        set name [concat [lindex $fields 2]]
        set body {*}[subst { { memoize::memoize; [transform [lindex $fields 0]] } }]

        proc advent::$name { } $body
        # puts "proc advent::$name { } { $body }"
    }
}

namespace eval advent { }
set ops [dict create NOT ~ RSHIFT >> LSHIFT << AND & XOR ^ OR |]

parse seven.data
puts [advent::a]
