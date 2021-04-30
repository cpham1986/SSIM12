function [funct, antenna] = ident(bpsk)
%IDENT Summary of this function goes here
%   Detailed explanation goes here

funct1 = 0;
funct2 = 7;
ant1 = 20;
ant2 = 30;

%https://www.mathworks.com/matlabcentral/answers/181168-how-to-convert-integer-array-to-one-value

bpsk(ant1:ant2);
validateattributes(bpsk, {'numeric'}, {'integer', 'nonnegative', '<', 10});
antenna = polyval(bpsk, 10);    

bpsk(funct1:funct2);
validateattributes(bpsk, {'numeric'}, {'integer', 'nonnegative', '<', 10});
funct = polyval(bpsk, 10);           
        
end

