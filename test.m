%a = [0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 1 0 0 1 1 0 0 1];
a = [1 1 1 1 0 0 0 0 1];
bpskdpsk(a)
[thetaR, thetaBW, thetaMIN, thetaMax, A] = modVar(0010001, 0)