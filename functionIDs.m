% Preliminary go through to get functionIDs
a = totalMatrix;
BPSK = a(:, 2);
% DPSK = bpskdpsk64(BPSK);
DPSK = BPSK;
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
    if (TX_enable_prev == 0 && TX_enable == 1) &&  ~(SBS == 1 && SBSprev == 0)
        FID_flag = 1;
    end
    if (FID_flag == 1 &&FID_bit <= 25)  % We hit leading edge of TX_enable
        FunctionIDs(FID_count, FID_bit) = DPSKitr;
        FID_bit = FID_bit + 1;
    end
    
    
    if FID_bit > 25
        FID_flag = 0;
    end
    
    if SBS == 1 && SBSprev == 0 && ~(TX_enable_prev == 0 && TX_enable == 1)
        FID_count = FID_count + 1; % writes the most recent functionID.
        FID_bit = 1;
    end
    TX_enable_prev = TX_enable;
    SBSprev = SBS;
end




