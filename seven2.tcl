# K combinator
proc K { x y } { set x }

# simple file reader
proc fread { fname } {
    K [read [set fp [open $fname]]] [close $fp]
}

proc getcommand { x } {
    if { [string is integer $x] } {
        set command $x
    } else {
        set command "\[advent::$x\]"
    }

    set command
}

proc transform0 { expr } {
    if { [string is integer [lindex $expr 0]] } {
        set script [concat $expr]
    } else {
        set script [concat advent::$expr]
    }

    set script
}

proc transform1 { expr } {
    set arg [getcommand [lindex $expr 1]]
    set op  [dict get $::ops [lindex $expr 0]]

    if { [string equal $op ~] } {
        set script "( 65536 + ($op $arg) )"
        # set script "expr { 65536 + ($op $arg) }"
    } else {
        set script "( $op $arg )"
        # set script "expr { $op $arg }"
    }

    set script
}

proc transform2 { expr } {
    set arg1 [getcommand [lindex $expr 0]]
    set arg2 [getcommand [lindex $expr 2]]
    set op   [dict get $::ops [lindex $expr 1]]

    set script "( $arg1 $op $arg2 )"
    # set script "expr { $arg1 $op $arg2 }"
}

proc transform { expr } {
    if { [llength $expr] < 2 } {
        set script [transform0 $expr]
    } elseif { [llength $expr] == 2 } {
        set script [transform1 $expr]
    } else {
        set script [transform2 $expr]
    }

    # set script [subst -nocommands { puts "in [info level 0]"; $script }]
    set script "set x \"$script\"; set x"
}

proc parse { fname } {
    set data [fread $fname]

    foreach item [lrange [split $data "\n"] 0 end-1] {
        set fields [split $item "->"]
        
        set name [concat [lindex $fields 2]]
        set body [subst { { [transform [lindex $fields 0]] } }]

        #puts $body
        proc advent::$name { } {*}$body
    }
}

namespace eval advent { }

dict create ops {}

dict set ops NOT ~
dict set ops RSHIFT >>
dict set ops LSHIFT <<
dict set ops AND &
dict set ops XOR ^
dict set ops OR |

parse input

# puts [info body advent::i]
# puts [info body advent::h]
puts [advent::cz]
