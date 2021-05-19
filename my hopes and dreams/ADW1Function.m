function ADW1Matrix = ADW1Function(stationConstant)
    ADW1Matrix = zeros(5900, 8);
    
    if(stationConstant == 0)
        %Enable Transmitter on for the entire duration of the function
        ADW1Matrix(1:5900, 1) = 1;
    
        %Send an Antenna Select Read signal on the start of the data
        %transmission
        ADW1Matrix(1:64, 8) = 1;
    
        %Sends the PREAMBLE data for ADW1
        ADW1Matrix(832:1023,2) = 1; % Transmit 1 for I1, I2, and I3 bits of PREAMBLE
        ADW1Matrix(1088:1151,2) = 1; % Trasmit 1 for I5 bit of PREAMBLE
        ADW1Matrix(1152:1343, 2) = 1; % Transmit 1 for I6 I7 and I8 bits of PREAMBLE
        ADW1Matrix(1472:1535, 2) = 1; % Transmit 1 for I11 bit of PREAMBLE
    
        %Send function data given for ADW1
        ADW1Matrix(1856:2175, 2) = 1;
        ADW1Matrix(2304:2431, 2) = 1;
        ADW1Matrix(2496:2559, 2) = 1;
        ADW1Matrix(3008:3199, 2) = 1;
        ADW1Matrix(3328:3967, 2) = 1;
        ADW1Matrix(4096:4159, 2) = 1;
        ADW1Matrix(4352:4415, 2) = 1;
        ADW1Matrix(4480:4607, 2) = 1;
        ADW1Matrix(4800:4927, 2) = 1;
        ADW1Matrix(5056:5311, 2) = 1;
    end
end