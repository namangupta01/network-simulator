set ns [new Simulator]
set nf [open o.nam W]
$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]


$ns duplpex-link $n0 $n1 20Mb 10ms DropTail 