bAZ = '0  0  1  1  0  0  1';
bBAZ = '1  0  0  1  0  0  1';
bEL = '1  1  0  0  0  0  1';

AZ  = '0  0  1  0  0  0  1'; % BPSK - 0011001
BAZ = '1  1  1  0  0  0  1'; % BPSK - 1001001
EL  = '1  0  0  0  0  0  1'; % BPSK - 1100001

a = totalMatrix;

BPSK = a(:, 2);
DPSK = BPSK;

TX_enable_prev = 0;
FID_flag = 0;
FunctionIDs = zeros(50 , 25);
FunctionIDs2 = zeros(50,1);

FID_count = 1;
FID_bit = 1;
SBS_prev = 0;

for i = 1:64:length(a)
    TX_enable = a(i, 1);
    DPSKitr = DPSK(i);
    SBS = a(i, 4);

%     start of the preamble; assumes we are on the leading edge of a
%     Transmit enable but not the leading edge of Scan Beam Start
    if (TX_enable_prev == 0 && TX_enable == 1) &&  ~(SBS == 1 && SBSprev == 0)
        FID_flag = 1;
    end

    
    if (FID_flag == 1 && FID_bit <= 25)  % We hit leading edge of TX_enable
        FunctionIDs(FID_count, FID_bit) = DPSKitr;
        FID_bit = FID_bit + 1;
    end

    if FID_bit > 25
        FID_flag = 0;
        functionID = num2str(FunctionIDs(FID_count,19:end));
        if strcmp(functionID, bAZ) || strcmp(functionID, bEL) || strcmp(functionID, bBAZ)
            
            switch(num2str(functionID))
                case bAZ
                    FunctionIDs2(FID_count) = 0010001;
                case bBAZ
                    FunctionIDs2(FID_count) = 1110001;
                case bEL
                    FunctionIDs2(FID_count) = 1000001;
            end
            FID_count = FID_count + 1; % writes the most recent functionID.
        else
            FunctionIDs(FID_count,:) = zeros(1,25);
        end
        FID_bit = 1;
    end

%     if SBS == 1 && SBSprev == 0 && ~(TX_enable_prev == 0 && TX_enable == 1)
%         FID_count = FID_count + 1; % writes the most recent functionID.
%             FID_bit = 1;
%     end
    TX_enable_prev = TX_enable;
    SBSprev = SBS;
end
