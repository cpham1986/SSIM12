function BDW6Matrix = BDW6Function(stationConstant)
    
    BDW6Matrix = zeros(3100, 8);
    
    if(stationConstant == 0)
        %Enable Transmitter on for the entire duration of the function
        BDW6Matrix(1:3100, 1) = 1;
    
        %Send an Antenna Select Read signal on the start of the data
        %transmission
        BDW6Matrix(1:64, 8) = 1;
    
        BDW6Matrix(832:1023,2) = 1; % Transmit 1 for I1, I2, and I3 bits of PREAMBLE
        BDW6Matrix(1088:1151,2) = 1; % Transmit 1 for I5 bit of PREAMBLE
        BDW6Matrix(1344:1471, 2) = 1; % Transmit 1 for I9 and I10 bits of PREAMBLE
        BDW6Matrix(1536:1599, 2) = 1; % Transmit 1 for I11bit of PREAMBLE
    
        %Send function data given for BDW1
        BDW6Matrix(1600:1663, 2) = 1;
        BDW6Matrix(2240:2303, 2) = 1;
        BDW6Matrix(2368:2431, 2) = 1;
        BDW6Matrix(2688:2815, 2) = 1;
    end
end
