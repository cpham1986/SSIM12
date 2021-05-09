% function: identifies the function and antenna of the bpsk
% input: bpsk - the data array from TCU
% output: [funct, antenna] - kind of up in the air right now, might be an
% array with all functions and antennas for the whole 815ms signal or just
% 1 at a time
function [funct, antenna] = ident(signal)
%IDENT Summary of this function goes here
%   Detailed explanation goes here

funct1 = 0;
funct2 = 7;
ant1 = 20;
ant2 = 30;

%https://www.mathworks.com/matlabcentral/answers/181168-how-to-convert-integer-array-to-one-value

%antenna is bits 5,6, and 7 when SBStart (4) is high and AntSelRd was high
%in the beginning

  
%turns an array into an integer
% bpsk(funct1:funct2);
% validateattributes(bpsk, {'numeric'}, {'integer', 'nonnegative', '<', 10});
% funct = polyval(bpsk, 10);           
%         
end

