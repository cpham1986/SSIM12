function BDW3Matrix = BDW3Function(stationConstant)
   
    BDW3Matrix = zeros(3100, 8);
    
    if(stationConstant == 0)
        %Enable Transmitter on for the entire duration of the function
        BDW3Matrix(1:3100, 1) = 1;
    
        %Send an Antenna Select Read signal on the start of the data
        %transmission
        BDW3Matrix(1:64, 8) = 1;
    
        BDW3Matrix(832:1023,2) = 1; % Transmit 1 for I1, I2, and I3 bits of PREAMBLE
        BDW3Matrix(1088:1215,2) = 1; % Transmit 1 for I5 and I6 bit of PREAMBLE
        BDW3Matrix(1280:1343, 2) = 1; % Transmit 1 for I8 bit of PREAMBLE
    
        %Send function data given for BDW3
        BDW3Matrix(1600:1791, 2) = 1;
        BDW3Matrix(1920:1983, 2) = 1;
        BDW3Matrix(2048:2175, 2) = 1;
        BDW3Matrix(2240:2304, 2) = 1;
        BDW3Matrix(2368:2495, 2) = 1;
        BDW3Matrix(2560:2687, 2) = 1;
    end
end
