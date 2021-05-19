function elevationMatrix = elevationFunction(stationConstant)
    elevationMatrix = zeros(5600, 8);

    if(stationConstant == 2)
        %Enables transmitter for the entirety of the Elevation function
        elevationMatrix(1:3405,1) = 1; % Transmitter is on for the entire duration of the function
        elevationMatrix(3806:5355,1) = 1; % Transmitter is on for the entire duration of the function
    
        % The following 4 lines transmits the Preamble function by using 
        %the BPSK line as the data line for the Preamble bits. For all 
        %functions bits I1-I5 of the Preamble are 11101, and for this function 
        %bits I6-I12 are 1100001
    
        elevationMatrix(832:1023,2) = 1; % Transmit 1 for I1, I2, and I3 bits of PREAMBLE
        elevationMatrix(1088:1151,2) = 1; % Transmit 1 for I5 bit of PREAMBLE
        elevationMatrix(1152:1279,2) = 1; %Transmit 1 for I6 and I7 bits of PREAMBLE
        elevationMatrix(1536:1599, 2) = 1; % Transmit 1 for I12 bit of PREAMBLE
    
        %These next 3 lines set the scan direction (TO and FRO), and manage
        %the transmitter disable for the pause time between scan direction
        %switching
        elevationMatrix(1856:3405,3) = 1; % Set scan direction to TO for to scan
        elevationMatrix(3406:3805,3) = 0;
        elevationMatrix(3806:5355,3) = 0; % Set scan direction to FRO for fro scan
    
        %These next 2 lines set scanning beam start to 1 when the TO and FRO
        %scans start
        elevationMatrix(1856:3405, 4) = 1; % Set scanning beam start to 1 for the TO scan
        elevationMatrix(3806:5355, 4) = 1; % Set scanning beam start to 1 for the FRO scan
    
        %The following 9 lines set the antenna select for rear OCI scan and the
        %scanning beam
        elevationMatrix(1728:1855,5) = 0; % Set antenna select to 2 for the REAR OCI scan
        elevationMatrix(1728:1855,6) = 1; % Set antenna select to 2 for the REAR OCI scan
        elevationMatrix(1728:1855,7) = 0; % Set antenna select to 2 for the REAR OCI scan

        elevationMatrix(1856:5355,5) = 1; % Set antenna select to 5 for the normal scanning beam antenna
        elevationMatrix(1856:5355,6) = 0; % Set antenna select to 5 for the normal scanning beam antenna
        elevationMatrix(1856:5355,7) = 1; % Set antenna select to 5 for the normal scanning beam antenna
    
        elevationMatrix(5356:5600, 5) = 0; % Set antenna select to 0 for the default antenna
        elevationMatrix(5356:5600, 6) = 0; % Set antenna select to 0 for the default antenna
        elevationMatrix(5356:5600, 7) = 0; % Set antenna select to 0 for the default antenna
    
        %The following 6 lines set the antenna select read to 1 for 1 cycle
        %after each time the antenna select is changed
        elevationMatrix(1:64,8) = 1; % Set antenna select read to 1 to set antenna to the default Antenna
        elevationMatrix(1728:1791,8) = 1; % Set antenna select read to 1 to set antenna to the REAR OCI Antenna
        elevationMatrix(1856:1919,8) = 1; % Set antenna select read to 1 to set the antenna to the scanning beam antenna
        elevationMatrix(5356:5419,8) = 1; % Set antenna select read to 1 to set the antenna back to the default antenna
    end
end