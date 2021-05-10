function BDW2Matrix = BDW2Function(stationConstant)
     BDW2Matrix = zeros(3100, 8);
    
    if(stationConstant == 0 || stationConstant == 1)
        %Enable Transmitter on for the entire duration of the function
        BDW2Matrix(1:3100, 1) = 1;
    
        %Send an Antenna Select Read signal on the start of the data
        %transmission
        BDW2Matrix(1:64, 8) = 1;
    
        BDW2Matrix(832:1023,2) = 1; % Transmit 1 for I1, I2, and I3 bits of PREAMBLE
        BDW2Matrix(1088:1151,2) = 1; % Trasmit 1 for I5 bit of PREAMBLE
        BDW2Matrix(1216:1471, 2) = 1; % Transmit 1 for I7-I9 bit of PREAMBLE
    
        %Send function data given for BDW2
        BDW2Matrix(1600:1663, 2) = 1;
        BDW2Matrix(1920:2047, 2) = 1;
        BDW2Matrix(2176:2239, 2) = 1;
        BDW2Matrix(2368:2431, 2) = 1;
        BDW2Matrix(2496:2559, 2) = 1;
        BDW2Matrix(2688:2751, 2) = 1;
    end
end
