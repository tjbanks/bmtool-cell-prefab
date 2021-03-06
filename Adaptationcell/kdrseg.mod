: Ion channel activation segregation -- Generated by BMTools (https://github.com/tjbanks/bmtools)
: based on the paper "Distinct Current Modules Shape Cellular Dynamics in Model Neurons" (2016)

NEURON {
	SUFFIX kdrseg
	USEION k READ ek WRITE ik
	RANGE gbar, g
	RANGE inf, tau
	RANGE ik
	RANGE nvhalf, nk, nseg
} 

UNITS {
    (mA) =  (milliamp)
    (mV) =  (millivolt)
}
PARAMETER {
	gbar (siemens/cm2)
	nvhalf = 12.3
	nk = -11.8
	nseg = -99
}

ASSIGNED {
    v (mV)
    ek (mV)
    ik (mA/cm2)
    g (siemens/cm2)
    inf
    tau (ms)
}
STATE {
    n
}
BREAKPOINT {
    SOLVE states METHOD cnexp
    g = gbar * n * n * n * n
    ik = g * (v - ek)
}
INITIAL {
    rate(v)
    n = inf
}
DERIVATIVE states{
	rate(v)
	nsegment(v)
	n' = (inf - n) / tau
}

PROCEDURE rate(v){
	UNITSOFF
	inf = 1.0 / (1.0 + (exp((v + nvhalf) / (nk))))
	tau = 14.4 - 12.8 / (1.0 + (exp((v + 28.3) / (-19.2))))
	UNITSON
}

: Segmentation functions

PROCEDURE nsegment(v){
	if (v < nseg){
		inf = 0
	}
}
