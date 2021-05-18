% Preliminary go through to get functionIDs

AZ  = '0  0  1  0  0  0  1'; % BPSK - 0011001
BAZ = '1  1  1  0  0  0  1'; % BPSK - 1001001
EL  = '1  0  0  0  0  0  1'; % BPSK - 1100001

a = totalMatrix;
BPSK = a(:, 2);
DPSK = bpskdpsk64(BPSK);
% DPSK = BPSK;
TX_enable_prev = 0;
FID_flag = 0;
FunctionIDs = zeros(50 , 25);
FID_count = 1;
FID_bit = 1;
SBS_prev = 0;

for i = 1:64:length(a)
    TX_enable = a(i, 1);
    DPSKitr = DPSK(i);
    SBS = a(i, 4);
    
    %start of the preamble; assumes we are on the leading edge of a
    %Transmit enable but not the leading edge of Scan Beam Start
    if (TX_enable_prev == 0 && TX_enable == 1) &&  ~(SBS == 1 && SBSprev == 0)
        FID_flag = 1;
    end
    
    %
    if (FID_flag == 1 && FID_bit <= 25)  % We hit leading edge of TX_enable
        FunctionIDs(FID_count, FID_bit) = DPSKitr;
        FID_bit = FID_bit + 1;
    end
    
    if FID_bit > 25
        FID_flag = 0;
        functionID = num2str(FunctionIDs(FID_count,19:end));
        if strcmp(num2str(functionID), AZ) || strcmp(num2str(functionID), EL) || strcmp(num2str(functionID), BAZ)
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

%for the actual amount of IDs
FID_count = FID_count-1;



