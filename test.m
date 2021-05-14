%a = [0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 1 0 0 1 1 0 0 1];
%a = [1 1 1 1 0 0 0 0 1];
%bpskdpsk(a)
%[thetaR, thetaBW, thetaMIN, thetaMax, A] = modVar(0010001, 0)

% testArr = [0 0 0 1 0 0 1 0 1 0 0 0 1 0 0 0 0 1 0 0 1 0 1 0 0 0 0 0];
% d = 0;
% index = 0;
% for i = 1:length(testArr)
%     if d == 5
%         index = i-1;
%         break;
%     elseif testArr(i) ~= testArr(i+1)
%         d = d + 1;
%     end
% end
% 
% arr = testArr(1:index)
% testArr = testArr(index+1:end)

% arr1 = [1 0 0 1]
% arr2 = [0 0 1 1]
% arr3 = and(arr1,arr2)

signal = [1,0,0,0,1,1,0,1];

antBit = find(signal(:,8)==1, 1,'last');

antArray = [0 0 0];
antArray(1) = signal(antBit, 5);
antArray(2) = signal(antBit, 6);
antArray(3) = signal(antBit, 7);
validateattributes(antArray, {'numeric'}, {'integer', 'nonnegative', '<', 10});
antenna = polyval(antArray, 10)
