% function: plots the output for the SSIM
% input: index and voltage (the ssim output)

% possibly an arbitrary function
function plotOutput(T, data)
%PLOTOUTPUT Summary of this function goes here
%   Detailed explanation goes here

% and this with the part related to scanning beam
scanBit = find(data(:,4));

data1 = bpskdpsk(data(1:scanBit,2));
plot(T(1:scanBit),sin(omega*T(1:scanBit)+pi*data1));

T = data(scanBit:end);
data = data(scanBit:end);

[funct, antenna] = ident(data);
[thetaR, thetaBW, thetaMIN, thetaMAX, AmpT] = modVar(funct, antenna);

thetaTTO = (data(:,4)==1).*(thetaMIN + T/50);
thetaTFRO = (data(:,4)==0).*(thetaMAX - T/50);
thetaT = OR(thetaTTO, thetaTFRO);

x = ((thetaT-thetaR)/(1.15*thetaBW))./(pi*((thetaT-thetaR)/(1.15*thetaBW)));
v = AmpT * sinc(x).*sin(omega*T+phaseShift);

sBeam = and(data(:,4)==0,v);
plot(T, sBeam);

end

