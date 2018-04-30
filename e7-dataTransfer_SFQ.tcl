set ns [new Simulator]
set nf [open out.nam w]
$ns namtrace-all $nf

proc finish {} {
        global ns nf
        $ns flush-trace
        close $nf
        exec nam out.nam &
        exit 0
}
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]


$ns duplex-link $n0 $n2 1Mb 10ms SFQ
$ns duplex-link $n1 $n2 1Mb 10ms SFQ
$ns duplex-link $n3 $n2 1Mb 10ms SFQ

$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient right

set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0

set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1

set cbr0 [ new Application/Traffic/CBR ]
$cbr0 set packetsize_ 500
$cbr0 set interval_ 0.003
$cbr0 attach-agent $udp0


set cbr1 [ new Application/Traffic/CBR ]
$cbr1 set packetsize_ 500
$cbr1 set interval_ 0.003
$cbr1 attach-agent $udp1

set null0 [new Agent/Null]
$ns attach-agent $n3 $null0

$ns connect $udp0 $null0
$ns connect $udp1 $null0

$udp0 set class_ 1
$udp1 set class_ 2

$ns color 1 Blue
$ns color 2 Red

$ns at 0.1 "$cbr0 start"
$ns at 0.1 "$cbr1 start"
$ns at 4.5 "$cbr0 stop"
$ns at 4.5 "$cbr1 stop"
$ns at 5.0 "finish"
$ns run

