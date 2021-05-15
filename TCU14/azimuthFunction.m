function azimuthMatrix = azimuthFunction(stationConstant)
    azimuthMatrix = zeros(15900, 8);
    
    if(stationConstant == 0)
        %Enables transmitter for the entirety of the Azimuth function
        azimuthMatrix(1:8759,1) = 1; % Transmitter is on for the entire duration of the function
        azimuthMatrix(9360:15687,1) = 1; % Transmitter is on for the entire duration of the function
    
        % The following 4 lines transmits the Preamble function by using 
        %the BPSK line as the data line for the Preamble bits. For all 
        %functions bits I1-I5 of the Preamble are 11101, and for this function 
        %bits I6-I12 are 0011001
        azimuthMatrix(832:1023,2) = 1; % Transmit 1 for I1, I2, and I3 bits of PREAMBLE
        azimuthMatrix(1088:1151,2) = 1; % Trasmit 1 for I5 bit of PREAMBLE
        azimuthMatrix(1280:1407,2) = 1; % Transmit 1 for bits I8 and I9 of PREAMBLE
        azimuthMatrix(1536:1600,2) = 1; % Transmit 1 for bit I12 of PREAMBLE

        %These next 3 lines set the scan direction (TO and FRO), and manage
        %the transmitter disable for the pause time between scan direction
        %switching
        azimuthMatrix(2560:8759,3) = 1; % Set scan direction to TO for to scan
        azimuthMatrix(8760:9359,3) = 0;
        azimuthMatrix(9360:15560,3) = 0; % Set scan direction to FRO for fro scan
    
        %The following 2 lines set the scanning beam start bit to 1 for the
        %entirety of the TO and FRO scans
        azimuthMatrix(2560:8759,4) = 1; % Set scanning beam start to 1 to start the TO scan
        azimuthMatrix(9360:15560,4) = 1; % Set scanning beam start to 1 to start the FRO scan
    
        %The following 15 lines set the antenna select for the Rear, Left,
        %and Right OCI scans, as well as switching back to zero for the two
        %seconds before the scanning beam starts.
        azimuthMatrix(2048:2175,5) = 0; % Set antenna select to 2 for the REAR OCI scan
        azimuthMatrix(2048:2175,6) = 1; % Set antenna select to 2 for the REAR OCI scan
        azimuthMatrix(2048:2175,7) = 0; % Set antenna select to 2 for the REAR OCI scan

        azimuthMatrix(2176:2303,5) = 0; % Set antenna select to 1 for the LEFT OCI scan
        azimuthMatrix(2176:2303,6) = 0; % Set antenna select to 1 for the LEFT OCI scan
        azimuthMatrix(2176:2303,7) = 1; % Set antenna select to 1 for the LEFT OCI scan

        azimuthMatrix(2304:2431,5) = 0; % Set antenna select to 3 for the RIGHT OCI scan
        azimuthMatrix(2304:2431,6) = 1; % Set antenna select to 3 for the RIGHT OCI scan
        azimuthMatrix(2304:2431,7) = 1; % Set antenna select to 3 for the RIGHT OCI scan

        azimuthMatrix(2432:2559,5) = 0; % Set antenna select to 0 for the default scanner
        azimuthMatrix(2432:2559,6) = 0; % Set antenna select to 0 for the default scanner
        azimuthMatrix(2432:2559,7) = 0; % Set antenna select to 0 for the default scanner

        azimuthMatrix(2560:15559,5) = 1; % Set antenna select to 5 for the normal scanning beam (AZ, BAZ, EL)
        azimuthMatrix(2560:15559,6) = 0; % Set antenna select to 5 for the normal scanning beam (AZ, BAZ, EL)
        azimuthMatrix(2560:15559,7) = 1; % Set antenna select to 5 for the normal scanning beam (AZ, BAZ, EL)
    
        azimuthMatrix(15560:15900,5) = 0; % Set antenna select to 0 for the default scanner
        azimuthMatrix(15560:15900,6) = 0; % Set antenna select to 0 for the default scanner
        azimuthMatrix(15560:15900,7) = 0; % Set antenna select to 0 for the default scanner
    
        %The following 6 lines set the antenna select read to 1 for 1 cycle
        %after each time the antenna select is changed
        azimuthMatrix(1:64,8) = 1; % Set antenna select read to 1 to set antenna to the default Antenna
        azimuthMatrix(2048:2112,8) = 1; % Set antenna select read to 1 to set antenna to the REAR OCI Antenna
        azimuthMatrix(2176:2240,8) = 1; % Set antenna select read to 1 to set antenna to the LEFT OCI Antenna
        azimuthMatrix(2304:2368,8) = 1; % Set antenna select read to 1 to set antenna to the RIGHT OCI Antenna
        azimuthMatrix(2432:2496,8) = 1; % Set antenna select read to 1 to set antenna to the default Antenna
        azimuthMatrix(2560:2624,8) = 1; % Set antenna select read to 1 to set antenna to the scanning beam Antenna
        azimuthMatrix(15560:15624,8) = 1; % Set antenna select read to 1 to set antenna to the default antenna
    end
end