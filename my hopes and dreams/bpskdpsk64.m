% function: converts an array from BPSK to DPSK
% input: bpsk - array of BPSK data from TCU
% output: dpsk - converted BPSK array to DPSK
function dpsk = bpskdpsk64(bpsk)

dpsk = zeros(1,length(bpsk)); % allocates memory for the new array
prevVal = 0; % holds value of previous bit

% iterates through the entire array
for i = 1:64:length(bpsk)
    if bpsk(i) == 1
        dpsk(i:i+63) = ~(prevVal); % shifts value 180 degrees
    else
        dpsk(i:i+63) = prevVal; % retains value of previous bit
    end
    prevVal = dpsk(i); % holds value of previous bit
end
end
