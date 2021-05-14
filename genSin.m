% function:
% input: bpsk - the input from TCU
% output: the sinc output for SSIM (may be arbitrary)
function genSin(data)
%GENSIN Summary of this function goes here
%   Detailed explanation goes here
% CMPE 349 - Project
% Team 12
% 4/19/21
prevIndex = 1;

for i = 1:length(testArr)
    %code for 1 signal
    if mod(d, 5) == 0
        index = i-1;
        %should grab all columns
        data2 = data(prevIndex:index, :);
        time = prevIndex:index;
        plotOutput(time, data2);
        prevIndex = index;
        
    elseif data(i,1) ~= data(i+1,1)
        d = d + 1;
    end
end

if(index < testArr)
%add code to plot last thing if there is one
end

% AZ  = [0 0 1 0 0 0 1]; % BPSK - 0011001 DPSK - 0010001
% BAZ = [1 1 1 0 0 0 1]; % BPSK - 1001001 DPSK - 1110001
% EL  = [1 0 0 0 0 0 1]; % BPSK - 1100001 DPSK - 1000001

% [funct, antenna] = ident(data);
% 
% 
% [thetaR, thetaBW, thetaMIN, thetaMAX, AmpT] = modVar(funct, antenna)

% figure out how to get T
% T = 0:1/20:1;

% Sinc function
%v(t) = AmpT * ((sin(pi*((thetaT-thetaR)/(1.15*thetaBW))))./(pi*((thetaT-thetaR)/(1.15*thetaBW)))).*sin(omega*T+phaseShift);

%mod theta T accordingly
t = [];
% thetaT = time/ + thetaMax;
% x = ((thetaT-thetaR)/(1.15*thetaBW))./(pi*((thetaT-thetaR)/(1.15*thetaBW)));
% v = AmpT * sinc(x).*sin(omega*T+phaseShift);
% plot(t, v);

end

