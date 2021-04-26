% CMPE 349 - Project
% Team 12
% 4/19/21


AZ  = [0 0 1 0 0 0 1]; % BPSK - 0011001 DPSK - 0010001
BAZ = [1 1 1 0 0 0 1]; % BPSK - 1001001 DPSK - 1110001
EL  = [1 0 0 0 0 0 1]; % BPSK - 1100001 DPSK - 1000001


omega

phaseShift

T 
       
% Receiver position, -(12*pi)/180 <= thetaR <= (12*pi)/180 degrees for AZ and BAZ
% thetaR (3*pi)/180 degrees for EL
thetaR 

% BW is 2 degrees for AZ and BAZ
% 1.5 for EL
thetaBW

% thetaT min +t/50
% max -t/50
thetaMIN 

thetaMAX

thetaT

% AmpT is the amplitude constant from the TCU
AmpT

% Sinc function
v(t) = AmpT * ((sin(pi*((thetaT-thetaR)/(1.15*thetaBW))))./(pi*((thetaT-thetaR)/(1.15*thetaBW)))).*sin(omega*T+phaseShift);

