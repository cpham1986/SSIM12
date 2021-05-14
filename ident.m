% function: identifies the function and antenna of the bpsk
% input: bpsk - the data array from TCU
% output: [funct, antenna] - kind of up in the air right now, might be an
% array with all functions and antennas for the whole 815ms signal or just
% 1 at a time
function [funct, antenna] = ident(signal)
%IDENT Summary of this function goes here
%   Detailed explanation goes here

functStart = 19;
functEnd = 25;

%https://www.mathworks.com/matlabcentral/answers/181168-how-to-convert-integer-array-to-one-value

%function is in the preamble at 19-25
functArray = signal(functStart:functEnd, 2);
validateattributes(functArray, {'numeric'}, {'integer', 'nonnegative', '<', 10});
funct = polyval(bpsk, 10);

%antenna is bits 5,6, and 7 when SBStart (4) is high and AntSelRd was high
%in the beginning

%finds the last antenna bit
antBit = find(signal(:,8)==1, 1,'last');
%makes sure it is the second to last one since it goes high for a sec at
%the end
if antBit == length(signal)
    signal = signal(0:length(signal)-1);
    antBit = find(signal(:,8)==1, 1,'last');
end

antArray = [0 0 0];
antArray(1) = signal(antBit, 5);
antArray(2) = signal(antBit, 6);
antArray(3) = signal(antBit, 7);
validateattributes(antArray, {'numeric'}, {'integer', 'nonnegative', '<', 10});
antenna = polyval(antArray, 10) 
  
%turns an array into an integer
% bpsk(funct1:funct2);
% validateattributes(bpsk, {'numeric'}, {'integer', 'nonnegative', '<', 10});
% funct = polyval(bpsk, 10);           
%         
end

