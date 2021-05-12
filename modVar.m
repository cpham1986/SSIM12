% function: creates variables for the sinc function
% input: function ID and antenna
% output: several different thetas and A(t)
function [thetaR, thetaBW, thetaMIN, thetaMAX, A] = modVar(ID, ANT)
%MODFUNC Summary of this function goes here
%   Detailed explanation goes here
% Find out their function ID and replace for a case function
AZ  = 0010001; % BPSK - 0011001
BAZ = 1110001; % BPSK - 1001001
EL  = 1000001; % BPSK - 1100001
BD1 = 0110000;
BD2 = 0101000;
BD3 = 1100000;
BD4 = 1111000;
BD5 = 1001000; 
BD6 = 0001001;
AD1 = 1011100;
AD2 = 1100101;
AD3 = 1010000;

switch ID
    case BD1
        ID = AZ;
    case BD2
        ID = BAZ;
    case BD3
        ID = AZ;
    case BD4
        ID = AZ;
    case BD5
        ID = AZ;
    case BD6
        ID = AZ;
    case AD1
        ID = AZ;
    case AD2
        ID = AZ;
    case AD3
        ID = AZ;        
    
switch ID
    case AZ
        thetaR = -12;
        thetaBW = 2;
        thetaMIN = -62;
        thetaMAX = 62;
    case BAZ
        thetaR = 12;
        thetaBW = 2;
        thetaMIN = -2;
        thetaMAX = 30;
    case EL
        thetaR = 3;
        thetaBW = 1.5;
        thetaMIN = -42;
        thetaMAX = 42; 
end

if(ID ~= EL)
   switch ANT 
       case 0
           A = 1;
       case 1
           A = 0.5;
       case 2
           A = 0.25;
       case 3
           A = 0.125;
       case 4
           A = -1; %supposed to be unused
       case 5
           A = 10;
       case 6
           A = 0;
       case 7
           A = 0;
   end
end

end


