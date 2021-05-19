clear
close all
clc

Azimuth_Transmission = AZ();
Elevation_Transmission = EL();
Baz_Transmission = BAZ();
BDW1 = DW1();
BDW2 = DW2();
BDW3 = DW3();
BDW4 = DW4();
BDW5 = DW5();
BDW6 = DW6();
AUX1 = ADW1();

% writematrix(Azimuth_Transmission,'AZ_Trans_G15.txt')
% writematrix(Elevation_Transmission,'EL_Trans_G15.txt')
% writematrix(Baz_Transmission, 'BAZ_Trans_G15.txt')
% writematrix(BDW1, 'BDW1_G15.txt')
% writematrix(BDW2, 'BDW2_G15.txt')
% writematrix(BDW3, 'BDW3_G15.txt')
% writematrix(BDW4, 'BDW4_G15.txt')
% writematrix(BDW5, 'BDW5_G15.txt')
% writematrix(BDW6, 'BDW6_G15.txt')
% writematrix(AUX1, 'AUX1_G15.txt')
%% Entire Transmission
totalMatrix = [Seq1();zeros(1000,8);Seq2();zeros(13000,8);Seq1();zeros(19000,8);Seq2();zeros(2000,8);Seq1();zeros(20000,8);Seq2();zeros(6000,8);Seq1();Seq2();zeros(20000,8)];
SSIM(totalMatrix)
%% Sequence 1
function Sequence = Seq1()
    % EL EL2 AZ EL2 EL (space) BAZ note EL EL2
    Sequence = [EL();DW1();zeros(2200,8);AZ();DW2();zeros(2200,8);EL();DW3();BAZ();DW4();EL();DW5;zeros(2200,8)];
end
%% Sequence 2
function Sequence = Seq2()
    % EL EL2 AZ EL2 EL GrowthNote(2) EL EL2
    Sequence = [EL();DW6();zeros(2200,8);AZ();DW1();zeros(2200,8);EL();ADW1();zeros(12300,8);EL();DW5;zeros(2200,8)];
end
%% Azimuth
% This function sends an 8 bit word every microsecond (AZ)
function Transmission = AZ()
    %BPSK
    BPSK = [];
    % Carrier Acq
    for i = 1:13
        BPSK = [BPSK clock_pulse(0)];
    end
    % Barker 11101
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    % Function ID 0011001
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    % Now the BPSK is done transmitting for the AZ function fill the rest
    % with zeros
    for i = 1:(15900-1600)
        BPSK = [BPSK 0];
    end
    
    % TxEn
    TxEn = ones(1, 15900);
    % Pause Duration 
    for i = 8760:9359
        TxEn(i) = 0;
    end
    
    % AntSelRd
    AntSelRd = zeros(1, 15900);
    
    % Bits for Antenna Selection
    MSB_A = zeros(1, 15900);
    A = zeros(1, 15900);
    LSB_A = zeros(1,15900);
    
    % DATA At the Beginning 000
    for i = 1:64
        AntSelRd(i) = 1;
    end
    
    % Rear 2048 2176 010 
    for i = 2048:2112
        AntSelRd(i) = 1;
    end
    for i = 2048:2176
        A(i) = 1;
    end
    
    % Left 2176 2304 001
    for i = 2176:2240
        AntSelRd(i) = 1;
    end
    for i = 2176:2304
        LSB_A(i) = 1;
    end
    
    % Right 2304 2432 011
    for i = 2304:2368
        AntSelRd(i) = 1;
    end
    for i = 2304:2432
        A(i) = 1;
    end
    for i = 2304:2432
        LSB_A(i) = 1;
    end
    
    % Scan 2560 15560 101
    for i = 2560:2624
        AntSelRd(i) = 1;
    end
    for i = 2560:15560
        MSB_A(i) = 1;
    end
    for i = 2560:15560
        LSB_A(i) = 1;
    end
    
    % To/Fro Function
    To_Fro = zeros(1,15900);
    for i = 2560:8760
        To_Fro(i) = 1;
    end
    
    % Scanning Beam Function
    SB_Start = zeros(1,15900);
    % To
    for i = 2560:8760
        SB_Start(i) = 1;
    end
    % Fro
    for i = 9360:15560
        SB_Start(i) = 1;
    end
    
    % Set Transmission to low for the end function
    for i = 15560:15900
        TxEn(i)=0;
        %MSB_A(i) = 0;
    end
    
    Transmission = [TxEn' BPSK' To_Fro' SB_Start' MSB_A' A' LSB_A' AntSelRd'];
end

%% Elevation
function Transmission = EL()
    %BPSK
    BPSK = [];
    % Carrier Acq
    for i = 1:13
        BPSK = [BPSK clock_pulse(0)];
    end
    % Barker 11101
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    % Function ID 1100001
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    % Now the BPSK is done transmitting for the EL function fill the rest
    % with zeros
    for i = 1:(5600-1600)
        BPSK = [BPSK 0];
    end
    
    % TxEn
    TxEn = ones(1, 5600);
    % Pause Duration 
    for i = 3406:3805
        TxEn(i) = 0;
    end
    
    % AntSelRd
    AntSelRd = zeros(1, 5600);
    
    % Bits for Antenna Selection
    MSB_A = zeros(1, 5600);
    A = zeros(1, 5600);
    LSB_A = zeros(1,5600);
    
    % DATA At the Beginning 000
    for i = 1:64
        AntSelRd(i) = 1;
    end
    
    % Rear 1728 1856 010 
    for i = 1728:1856
        AntSelRd(i) = 1;
    end
    for i = 1728:1856
        A(i) = 1;
    end
    
    % Scan 1856 5356  101
    for i = 1856:5356
        AntSelRd(i) = 1;
    end
    for i = 1856:5356
        MSB_A(i) = 1;
    end
    for i = 1856:5356
        LSB_A(i) = 1;
    end
    
    % To/Fro Function
    To_Fro = zeros(1,5600);
    for i = 1856:3406
        To_Fro(i) = 1;
    end
    
    % Scanning Beam Function
    SB_Start = zeros(1,5600);
    % To
    for i = 1856:3406
        SB_Start(i) = 1;
    end
    % Fro
    for i = 3806:5356
        SB_Start(i) = 1;
    end
    
    % Set Transmission to low for the end function
    for i = 5356:5600
        TxEn(i)=0;
    end
    
    Transmission = [TxEn' BPSK' To_Fro' SB_Start' MSB_A' A' LSB_A' AntSelRd'];
end
%% Back Azimuth
function Transmission = BAZ()
    %BPSK
    BPSK = [];
    % Carrier Acq
    for i = 1:13
        BPSK = [BPSK clock_pulse(0)];
    end
    % Barker 11101
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    % Function ID 1001001
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    
    % Now the BPSK is done transmitting for the BAZ function fill the rest
    % with zeros
    for i = 1:(11900-1600)
        BPSK = [BPSK 0];
    end
    
    % TxEn
    TxEn = ones(1, 11900);
    % Pause Duration 
    for i = 6760:7359
        TxEn(i) = 0;
    end
    
    % AntSelRd
    AntSelRd = zeros(1, 11900);
    
    % Bits for Antenna Selection
    MSB_A = zeros(1, 11900);
    A = zeros(1, 11900);
    LSB_A = zeros(1,11900);
    
    % DATA At the Beginning 000
    for i = 1:64
        AntSelRd(i) = 1;
    end
    
    % Rear 2048 2176 010 
    for i = 2048:2112
        AntSelRd(i) = 1;
    end
    for i = 2048:2176
        A(i) = 1;
    end
    
    % Left 2176 2304 001
    for i = 2176:2240
        AntSelRd(i) = 1;
    end
    for i = 2176:2304
        LSB_A(i) = 1;
    end
    
    % Right 2304 2432 011
    for i = 2304:2368
        AntSelRd(i) = 1;
    end
    for i = 2304:2432
        A(i) = 1;
    end
    for i = 2304:2432
        LSB_A(i) = 1;
    end
    
    % Scan 2560 6760  101
    for i = 2560:2624
        AntSelRd(i) = 1;
    end
    for i = 2560:11688
        MSB_A(i) = 1;
    end
    for i = 2560:11688
        LSB_A(i) = 1;
    end
    
    % To/Fro Function
    To_Fro = zeros(1,11900);
    for i = 2560:6760
        To_Fro(i) = 1;
    end
    
    % Scanning Beam Function
    SB_Start = zeros(1,11900);
    % To
    for i = 2560:6760
        SB_Start(i) = 1;
    end
    % Fro
    for i = 7360:11560
        SB_Start(i) = 1;
    end
    
    % Set Transmission to low for the end function
    for i = 11560:11900
        TxEn(i)=0;
    end
    
    Transmission = [TxEn' BPSK' To_Fro' SB_Start' MSB_A' A' LSB_A' AntSelRd'];
end
%% Data Words
function Transmission = DW1()
    %BPSK
    BPSK = [];
    % Carrier Acq
    for i = 1:13
        BPSK = [BPSK clock_pulse(0)];
    end
    % Barker 11101
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    % Function ID 0101000
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    % Data
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    
    for i = 2881:3100
        BPSK = [BPSK 0];
    end
    
    TxEn = ones(1,3100);
   
    for i = 2880:3100
        TxEn(i) = 0;
    end
    
    AntSelRd = zeros(1,3100);
    for i = 1:64
        AntSelRd(i) = 1;
    end
    To_Fro = zeros(1,3100);
    SB_Start = zeros(1,3100);
    MSB_A = zeros(1,3100);
    A = zeros(1,3100);
    LSB_A = zeros(1, 3100);
    
    Transmission = [TxEn' BPSK' To_Fro' SB_Start' MSB_A' A' LSB_A' AntSelRd'];
end

function Transmission = DW2()
    %BPSK
    BPSK = [];
    % Carrier Acq
    for i = 1:13
        BPSK = [BPSK clock_pulse(0)];
    end
    % Barker 11101
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    % Function ID 0111100
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    % Data
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    
    for i = 2881:3100
        BPSK = [BPSK 0];
    end
    
    TxEn = ones(1,3100);
    for i =2880:3100
        TxEn(i) = 0;
    end
    
    AntSelRd = zeros(1,3100);
    for i = 1:64
        AntSelRd(i) = 1;
    end
    To_Fro = zeros(1,3100);
    SB_Start = zeros(1,3100);
    MSB_A = zeros(1,3100);
    A = zeros(1,3100);
    LSB_A = zeros(1, 3100);
    
    Transmission = [TxEn' BPSK' To_Fro' SB_Start' MSB_A' A' LSB_A' AntSelRd'];
end

function Transmission = DW3()
    %BPSK
    BPSK = [];
    % Carrier Acq
    for i = 1:13
        BPSK = [BPSK clock_pulse(0)];
    end
    % Barker 11101
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    % Function ID 1010000
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    % Data 11100 10110 10110 11000
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    
    for i = 2881:3100
        BPSK = [BPSK 0];
    end
    
    TxEn = ones(1,3100);
    for i =2880:3100
        TxEn(i) = 0;
    end
    
    AntSelRd = zeros(1,3100);
    for i = 1:64
        AntSelRd(i) = 1;
    end
    To_Fro = zeros(1,3100);
    SB_Start = zeros(1,3100);
    MSB_A = zeros(1,3100);
    A = zeros(1,3100);
    LSB_A = zeros(1, 3100);
    
    Transmission = [TxEn' BPSK' To_Fro' SB_Start' MSB_A' A' LSB_A' AntSelRd'];
end

function Transmission = DW4()
    %BPSK
    BPSK = [];
    % Carrier Acq
    for i = 1:13
        BPSK = [BPSK clock_pulse(0)];
    end
    % Barker 11101
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    % Function ID 1000100
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    % Data 11110 01011 10010 10101
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    
    for i = 2881:3100
        BPSK = [BPSK 0];
    end
    
    TxEn = ones(1,3100);
    for i =2880:3100
        TxEn(i) = 0;
    end
    
    AntSelRd = zeros(1,3100);
    for i = 1:64
        AntSelRd(i) = 1;
    end
    To_Fro = zeros(1,3100);
    SB_Start = zeros(1,3100);
    MSB_A = zeros(1,3100);
    A = zeros(1,3100);
    LSB_A = zeros(1, 3100);
    
    Transmission = [TxEn' BPSK' To_Fro' SB_Start' MSB_A' A' LSB_A' AntSelRd'];
end

function Transmission = DW5()
    %BPSK
    BPSK = [];
    % Carrier Acq
    for i = 1:13
        BPSK = [BPSK clock_pulse(0)];
    end
    % Barker 11101
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    % Function ID 1101100
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    % Data 01110 01101 10100 11010
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    
    for i = 2881:3100
        BPSK = [BPSK 0];
    end
    
    TxEn = ones(1,3100);
    for i =2880:3100
        TxEn(i) = 0;
    end
    
    AntSelRd = zeros(1,3100);
    for i = 1:64
        AntSelRd(i) = 1;
    end
    To_Fro = zeros(1,3100);
    SB_Start = zeros(1,3100);
    MSB_A = zeros(1,3100);
    A = zeros(1,3100);
    LSB_A = zeros(1, 3100);
    
    Transmission = [TxEn' BPSK' To_Fro' SB_Start' MSB_A' A' LSB_A' AntSelRd'];
end

function Transmission = DW6()
    %BPSK
    BPSK = [];
    % Carrier Acq
    for i = 1:13
        BPSK = [BPSK clock_pulse(0)];
    end
    % Barker 11101
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    % Function ID 0001101
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    % Data 10000 00000 10100 00110
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    
    for i = 2881:3100
        BPSK = [BPSK 0];
    end
    
    TxEn = ones(1,3100);
    for i =2880:3100
        TxEn(i) = 0;
    end
    
    AntSelRd = zeros(1,3100);
    for i = 1:64
        AntSelRd(i) = 1;
    end
    To_Fro = zeros(1,3100);
    SB_Start = zeros(1,3100);
    MSB_A = zeros(1,3100);
    A = zeros(1,3100);
    LSB_A = zeros(1, 3100);
    
    Transmission = [TxEn' BPSK' To_Fro' SB_Start' MSB_A' A' LSB_A' AntSelRd'];
end

function Transmission = ADW1
    %BPSK
    BPSK = [];
    % Carrier Acq
    for i = 1:13
        BPSK = [BPSK clock_pulse(0)];
    end
    % Barker 11101
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    % Function ID 1110010
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    % Data 00001 11110 01101 00000|00111 00111 11111 11001|00010 11000 11001 11100|0000
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
  
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(1)];
    
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(1)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    BPSK = [BPSK clock_pulse(0)];
    
    for i = 5697:5900
        BPSK = [BPSK 0];
    end
    
    TxEn = ones(1,5900);
    for i = 5696:5900
        TxEn(i) = 0;
    end
    AntSelRd = zeros(1,5900);
    for i = 1:64
        AntSelRd(i) = 1;
    end
    To_Fro = zeros(1,5900);
    SB_Start = zeros(1,5900);
    MSB_A = zeros(1,5900);
    A = zeros(1,5900);
    LSB_A = zeros(1,5900);
    Transmission = [TxEn' BPSK' To_Fro' SB_Start' MSB_A' A' LSB_A' AntSelRd'];
end

% Each Clock Pulse is 64 microseconds
function bit64 = clock_pulse(bin)
    bit64 = zeros(1,64);
    for i = 1:64
        bit64(i)= bin;
    end
end
