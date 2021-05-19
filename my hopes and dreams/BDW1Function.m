function BDW1Matrix = BDW1Function(stationConstant)
    BDW1Matrix = zeros(3100, 8);
    
    if(stationConstant == 0)
        %Enable Transmitter on for the entire duration of the function
        BDW1Matrix(1:3100, 1) = 1;
    
        %Send an Antenna Select Read signal on the start of the data
        %transmission
        BDW1Matrix(1:64, 8) = 1;
    
        BDW1Matrix(832:1023,2) = 1; % Transmit 1 for I1, I2, and I3 bits of PREAMBLE
        BDW1Matrix(1088:1151,2) = 1; % Trasmit 1 for I5 bit of PREAMBLE
        BDW1Matrix(1216:1279, 2) = 1; % Transmit 1 for I7 bit of PREAMBLE
        BDW1Matrix(1344:1407, 2) = 1; % Transmit 1 for I9 bit of PREAMBLE
    
        %Send function data given for BDW1
        BDW1Matrix(1600:1663, 2) = 1;
        BDW1Matrix(1728:1983, 2) = 1;
        BDW1Matrix(2112:2303, 2) = 1;
        BDW1Matrix(2432:2495, 2) = 1;
        BDW1Matrix(2560:2879, 2) = 1; 
    end
end