%a = [0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 1 0 0 1 1 0 0 1];
%a = [1 1 1 1 0 0 0 0 1];
%bpskdpsk(a)
%[thetaR, thetaBW, thetaMIN, thetaMax, A] = modVar(0010001, 0)

% testArr = [0 0 0 1 0 0 1 0 1 0 0 0 1 0 0 0 0 1 0 0 1 0 1 0 0 0 0 0];
% d = 0;
% index = 0;
% for i = 1:length(testArr)
%     if d == 7
%         index = i-1;
%         break;
%     elseif testArr(i) ~= testArr(i+1)
%         d = d + 1;
%     end
% end
% 
% arr = testArr(1:index)
% testArr = testArr(index+1:end)

arr1 = [1 0 0 1]
arr2 = [0 0 1 1]
arr3 = and(arr1,arr2)