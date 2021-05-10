function BDW5Matrix = BDW5Function(stationConstant)
   
        BDW5Matrix = zeros(3100, 8);
    
    if(stationConstant == 0)
        %Enable Transmitter on for the entire duration of the function
        BDW5Matrix(1:3100, 1) = 1;
    
        %Send an Antenna Select Read signal on the start of the data
        %transmission
        BDW5Matrix(1:64, 8) = 1;
    
        BDW5Matrix(832:1023,2) = 1; % Transmit 1 for I1, I2, and I3 bits of PREAMBLE
        BDW5Matrix(1088:1279,2) = 1; % Transmit 1 for I5, I6, and I7 bits of PREAMBLE
        BDW5Matrix(1344:1471, 2) = 1; % Transmit 1 for I9 and I10 bits of PREAMBLE
    
        %Send function data given for BDW1
        BDW5Matrix(1664:1855, 2) = 1;
        BDW5Matrix(1984:2111, 2) = 1;
        BDW5Matrix(2176:2303, 2) = 1;
        BDW5Matrix(2368:2431, 2) = 1;
        BDW5Matrix(2560:2687, 2) = 1; 
        BDW5Matrix(2752:2816, 2) = 1;
    end
end
