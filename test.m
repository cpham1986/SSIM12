% % %a = [0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 1 0 0 1 1 0 0 1];
% % %a = [1 1 1 1 0 0 0 0 1];
% % %bpskdpsk(a)
% % %[thetaR, thetaBW, thetaMIN, thetaMax, A] = modVar(0010001, 0)
% %
% % % testArr = [0 0 0 1 0 0 1 0 1 0 0 0 1 0 0 0 0 1 0 0 1 0 1 0 0 0 0 0];
% % % d = 0;
% % % index = 0;
% % % for i = 1:length(testArr)
% % %     if d == 5
% % %         index = i-1;
% % %         break;
% % %     elseif testArr(i) ~= testArr(i+1)
% % %         d = d + 1;
% % %     end
% % % end
% % %
% % % arr = testArr(1:index)
% % % testArr = testArr(index+1:end)
% %
% % % arr1 = [1 0 0 1]
% % % arr2 = [0 0 1 1]
% % % arr3 = and(arr1,arr2)
% %
% % signal = [1,0,0,0,1,1,0,1];
% %
% % antBit = find(signal(:,8)==1, 1,'last');
% %
% % antArray = [0 0 0];
% % antArray(1) = signal(antBit, 5);
% % antArray(2) = signal(antBit, 6);
% % antArray(3) = signal(antBit, 7);
% % validateattributes(antArray, {'numeric'}, {'integer', 'nonnegative', '<', 10});
% % antenna = polyval(antArray, 10)
% %-------------------------------------------------------------------------
% outArray = zeros(length(a(:, 1)), 1);
% 
% preamble = zeros(1, 25);
% preambleItr = 1;
% preambleIndex = -1;
% 
% BPSK = a(:, 2);
% DPSK = bpskdpsk(BPSK);
% 
% for i = 1: length(a)
%     
%     TX_enable = a(i, 1);
%     DPSKitr = DPSK(i);
%     TO_FRO = a(i, 3);
%     SBS = a(i, 4);
%     ANT_pos = a(i, 5:7);
%     ANTread = a(i, 8);
%     
%     
%     if ANTread == 1
%         ANT = num2str(ANT_pos);
%         % Only check if antenna read is enabl
%         
%         switch ANT
%             case '0  0  0'
%                 A = 1;
%             case '0  0  1'
%                 A = 0.5;
%             case '0  1  0'
%                 A = 0.25;
%             case '0  1  1'
%                 A = 0.125;
%             case '1  0  0'
%                 A = -1; %supposed to be unused
%             case '1  0  1'
%                 A = 10;
%             case '1  1  0'
%                 A = 0;
%             case '1  1  1'
%                 A = 0;
%         end
%     end
%     
%     if TX_EN == 1
%         
%         
%         outArray(i) = A * sin(i * omega + DPSKitr * pi);
%         if A == 1 && mod(i,64) == mod(preambleIndex,64) % if a preamble is currently being outpted, need to cature the function ID
%             preamble(preambleItr) = DPSKitr
%             preambleItr = preambleItr + 1;
%             
%         end
%     else
%         outArray(i) = 0;
%         preambleIndex = -1;
%         
%     end
%     
%     
%     if preambleItr == 25
%         preambleItr = 1;
%         preambleIndex = -1;
%     end
% end
% 
in1 = [0,1,0,1];
in2 = cat(1,zeros(64,1),ones(64,1),zeros(64,1),ones(64,1));
out1 = bpskdpsk64(out);
out2 = [];
for i = 1:length(out1)
    if mod(i,64)==0
        out2 = cat(1,out2, out1(i));
    end
end
bpskdpsk(in1)
out2
