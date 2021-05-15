
% function: converts an array from BPSK to DPSK
% input: bpsk - array of BPSK data from TCU
% output: dpsk - converted BPSK array to DPSK
function dpsk = bpskdpsk(bpsk)

dpsk = zeros(1,length(bpsk)); % allocates memory for the new array
prevVal = 0; % holds value of previous bit

% iterates through the entire array
for i = 1:length(bpsk)
    if bpsk(i) == 1
        dpsk(i) = ~(prevVal); % shifts value 180 degrees
    else
        dpsk(i) = prevVal; % retains value of previous bit
    end
    prevVal = dpsk(i); % holds value of previous bit
end

end

