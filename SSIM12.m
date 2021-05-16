





AZ  = 0010001; % BPSK - 0011001
BAZ = 1110001; % BPSK - 1001001
EL  = 1000001; % BPSK - 1100001
BD1 = 0110000;
BD2 = 0101000;
BD3 = 1100000;
BD4 = 1111000;
BD5 = 1001000;
BD6 = 0001001;
AD1 = 1011100;
AD2 = 1100101;
AD3 = 1010000;

functArray(1) = signal(1170,2);
functArray(2) = signal(1250,2);
functArray(3) = signal(1310,2);
functArray(4) = signal(1390,2);
functArray(5) = signal(1440,2);
functArray(6) = signal(1500,2);
functArray(7) = signal(1570,2);

validateattributes(functArray, {'numeric'}, {'integer', 'nonnegative', '<', 10});
funct = polyval(functArray, 10);
funct = bpskdpsk(funct);


a = [1, 1, 0, 1, 1, 0, 1, 1; 1, 0, 1, 0, 0, 0, 1, 0];


outArray = zeros(length(a(:, 1)), 1);

omega = 156000;

prevSBS = 0;

preamble = zeros(1, 25);
preambleItr = 0;

BPSK = a(:, 2);
DPSK = bpskdpsk(BPSK);
for i = 1: length(a)  % file hasn't ended yet (400,000+ iterations)
    TX_enable = a(i, 1);
    DPSKitr = DPSK(i);
    TO_FRO = a(i, 3);
    SBS = a(i, 4);
    ANT_pos = a(i, 5:7);
    ANTread = a(i, 8);
    
    
    if ANTread == 1
        ANT = num2str(ANT_pos);
        % Only check if antenna read is enabl
        
        switch ANT
            case '0 0 0'
                A = 1;
            case '0 0 1'
                A = 0.5;
            case '0 1 0'
                A = 0.25;
            case '0 1 1'
                A = 0.125;
            case '1 0 0'
                A = -1; %supposed to be unused
            case '1 0 1'
                A = 10;
            case '1 1 0'
                A = 0;
            case '1 1 1'
                A = 0;
        end
    end
    
    
    
    if TX_enable == 1
        
        if SBS == 1 && prevSBS == 0
            
            
            
            
            while TX_enable ~= 0
                TX_enable = a(i, 1);
                TO_FRO = a(i, 3);
                
                % output scanning beacon
                
                i = i + 1;
            end
        else
            
            outArray(i) = A * sin(i * omega + DPSKitr * pi);
            if A == 1 % if a preamble is currently being outpted, need to cature the function ID
                preamble(preambleItr) = DPSKitr;
                preambleItr = preambleItr + 1;
            end
            
            % if a data word is currently being outputed, 
        end
        
        
        
        
        
    else
        outArray(i) = 0;
        
    end
    
    prevSBS = SBS;
    
    % if the complete function ID is conveyed reset preamble iterator
    if preambleItr == 25
        preambleItr = 0;
        preambelIndex = 0;
    end
    
    
end
    