set ns [new Simulator]
set nf [open out.nam w]
$ns namtrace-all $nf
$ns rtproto DV
proc finish {} {
        global ns nf
        $ns flush-trace
        close $nf
        exec nam out.nam &
        exit 0
}

for { set i 0 } { $i < 7 } { incr i } {
	set n($i) [$ns node]
}

for { set i 0 } { $i < 7 } { incr i } {
	$ns duplex-link $n($i) $n([expr ($i + 1) % 7 ]) 1Mb 10ms DropTail
	
}

set udp [new Agent/UDP]
$ns attach-agent $n(0) $udp

set cbr [ new Application/Traffic/CBR ]
$cbr set packetsize_ 500
$cbr set interval_ 0.005
$cbr attach-agent $udp

set null [new Agent/Null]
$ns attach-agent $n(2) $null

$ns connect $udp $null

$udp set class_ 1
$ns color 1 Blue

$ns at 0.1 "$cbr start"
$ns at 4.9 "$cbr stop"
$ns rtmodel-at 1.0 down $n(1) $n(2)
$ns rtmodel-at 2.0 up $n(1) $n(2)
$ns at 5.0 "finish"
$ns run

