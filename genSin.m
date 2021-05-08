% function:
% input: bpsk - the input from TCU
% output: the sinc output for SSIM (may be arbitrary)
function v = genSin(bpsk)
%GENSIN Summary of this function goes here
%   Detailed explanation goes here
% CMPE 349 - Project
% Team 12
% 4/19/21

AZ  = [0 0 1 0 0 0 1]; % BPSK - 0011001 DPSK - 0010001
BAZ = [1 1 1 0 0 0 1]; % BPSK - 1001001 DPSK - 1110001
EL  = [1 0 0 0 0 0 1]; % BPSK - 1100001 DPSK - 1000001

[funct, antenna] = ident(bpsk);


[thetaR, thetaBW, thetaMIN, thetaMAX, AmpT] = modVar(funct, antenna)
phaseShift

T = 0:1/20:1;

% Sinc function
%v(t) = AmpT * ((sin(pi*((thetaT-thetaR)/(1.15*thetaBW))))./(pi*((thetaT-thetaR)/(1.15*thetaBW)))).*sin(omega*T+phaseShift);

%mod theta T accordingly
thetaT = time/ + thetaMax;

x = ((thetaT-thetaR)/(1.15*thetaBW))./(pi*((thetaT-thetaR)/(1.15*thetaBW)));
v = AmpT * sinc(x).*sin(omega*T+phaseShift);

plotOutput(T,v);
end

