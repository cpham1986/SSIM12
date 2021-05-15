% function: identifies the function and antenna of the bpsk
% input: bpsk - the data array from TCU
% output: [funct, antenna] - kind of up in the air right now, might be an
% array with all functions and antennas for the whole 815ms signal or just
% 1 at a time
function funct = ident(signal)
%IDENT Summary of this function goes here
%   Detailed explanation goes here

%https://www.mathworks.com/matlabcentral/answers/181168-how-to-convert-integer-array-to-one-value

%function is in the preamble at 19-25
functArray = [0 0 0 0 0 0 0];
functArray(1) = signal(1170,2);
functArray(2) = signal(1250,2);
functArray(3) = signal(1310,2);
functArray(4) = signal(1390,2);
functArray(5) = signal(1440,2);
functArray(6) = signal(1500,2);
functArray(7) = signal(1570,2);

validateattributes(functArray, {'numeric'}, {'integer', 'nonnegative', '<', 10});
funct = polyval(functArray, 10);
funct = bpskdpsk(funct);

% %finds the last antenna bit
% antBit = find(signal(:,8)==1, 1,'last');
% %makes sure it is the second to last one since it goes high for a sec at
% %the end
% if antBit == length(signal)
%     signal = signal(0:length(signal)-1);
%     antBit = find(signal(:,8)==1, 1,'last');
% end
% 
% antArray = [0 0 0];
% antArray(1) = signal(antBit, 5);
% antArray(2) = signal(antBit, 6);
% antArray(3) = signal(antBit, 7);
% validateattributes(antArray, {'numeric'}, {'integer', 'nonnegative', '<', 10});
% antenna = polyval(antArray, 10) 
%   
%turns an array into an integer
% bpsk(funct1:funct2);
% validateattributes(bpsk, {'numeric'}, {'integer', 'nonnegative', '<', 10});
% funct = polyval(bpsk, 10);           
%         
end

