function BDW4Matrix = BDW4Function(stationConstant)
    
    BDW4Matrix = zeros(3100, 8);
    
    if(stationConstant == 0)
        %Enable Transmitter on for the entire duration of the function
        BDW4Matrix(1:3100, 1) = 1;
    
        %Send an Antenna Select Read signal on the start of the data
        %transmission
        BDW4Matrix(1:64, 8) = 1;
    
        BDW4Matrix(832:1023,2) = 1; % Transmit 1 for I1, I2, and I3 bits of PREAMBLE
        BDW4Matrix(1088:1215,2) = 1; % Transmit 1 for I5 and I6 bits of PREAMBLE
        BDW4Matrix(1408:1471, 2) = 1; % Transmit 1 for I10 bit of PREAMBLE
    
        %Send function data given for BDW1
        BDW4Matrix(1600:1855, 2) = 1;
        BDW4Matrix(1984:2047, 2) = 1;
        BDW4Matrix(2112:2303, 2) = 1;
        BDW4Matrix(2432:2495, 2) = 1; 
        BDW4Matrix(2560:2623, 2) = 1;
        BDW4Matrix(2688:2751, 2) = 1;
        BDW4Matrix(2816:2879, 2) = 1;
    end
end
