





AZ  = '0  0  1  0  0  0  1'; % BPSK - 0011001
BAZ = '1  1  1  0  0  0  1'; % BPSK - 1001001
EL  = '1  0  0  0  0  0  1'; % BPSK - 1100001




%a = [1, 1, 0, 1, 1, 0, 1, 1; 1, 0, 1, 0, 0, 0, 1, 0];
a = totalMatrix;

outArray = zeros(length(a(:, 1)), 1);

thetaR = 0;
thetaBW = 0;
thetaMIN = 0;
thetMax = 0;
functionID = zeros(7, 1);

omega = 1000;

prevSBS = 0;

preamble = zeros(1, 25);
preambleItr = 1;
preambleIndex = -1;

scanning = false;

y = 0;

BPSK = a(:, 2);
% DPSK = bpskdpsk(BPSK);
DPSK = BPSK;
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
            case '0  0  0'
                A = 1;
            case '0  0  1'
                A = 0.5;
            case '0  1  0'
                A = 0.25;
            case '0  1  1'
                A = 0.125;
            case '1  0  0'
                A = -1; %supposed to be unused
            case '1  0  1'
                A = 10;
            case '1  1  0'
                A = 0;
            case '1  1  1'
                A = 0;
        end
    end
    
    
    
    if TX_enable == 1
        
        %marks start of preamble
        if preambleIndex == -1
            preambleIndex = i;
        end
        
        if SBS == 1 && prevSBS == 0
            
            functionID = preamble(19:end); %the function ID is the last seven bits of the preamble
            
            % Check funciton ID. Change angles based on function ID.
            
            if strcmp(num2str(functionID), AZ)
                thetaR = -12;
                thetaBW = 2;
                thetaMIN = -62;
                thetaMAX = 62;
               
            elseif strcmp(num2str(functionID), BAZ)
                thetaR = 12;
                thetaBW = 2;
                thetaMIN = -2;
                thetaMAX = 30;
            elseif strcmp(num2str(functionID), EL)
                thetaR = 3;
                thetaBW = 1.5;
                thetaMIN = -42;
                thetaMAX = 42;
            else
                thetaR = 0;
                thetaBW = 0;
                thetaMIN = 0;
                thetMax = 0;
            end
                   
            while TX_enable ~= 0
                TX_enable = a(i, 1);
                TO_FRO = a(i, 3);
                SBS = a(i, 4);
                
                if TO_FRO == 1 % Scanning TO thetaMIN + t/50
                    thetaT = thetaMIN + i/50;
                end
                if TO_FRO == 0 % Scanning FRO thetaMIN - t/50
                    thetaT = thetaMIN - i/50;
                    
                end
                
                outArray(i) = A * (sin(pi*(thetaT - thetaR)/(1.15*thetaBW)) / (pi * (thetaT - thetaR) / (1.15 * thetaBW)) * sin(omega * i));
                i = i + 1;
            end
            i = i - 1;
        else
            
            outArray(i) = A * sin(i * omega + DPSKitr * pi);
            if A == 1 && mod(i,64) == mod(preambleIndex,64) % if a preamble is currently being outpted, need to cature the function ID
                preamble(preambleItr) = DPSKitr
                preambleItr = preambleItr + 1;
                
            end
        end
                
        
    else
        outArray(i) = 0;
        preambleIndex = -1;
        
    end
    
    prevSBS = SBS;
    
    % if the complete function ID is conveyed reset preamble iterator
    if preambleItr == 25
        preambleItr = 1;
        preambleIndex = -1;
    end
    
    
end
    

plot(1:length(outArray), outArray)
