function v = modAntenna(data,v)
%MODANTENNA Summary of this function goes here
%   Modified amplitude depending on amplitude
for i =  1:length(data)
    if(data(:,8) == 1)
        A = 1;
        antArray = [0 0 0];
        antBit1;
        antBit2;
        antBit3;
        
        antArray(1) = signal(antBit1, 5);
        antArray(2) = signal(antBit2, 6);
        antArray(3) = signal(antBit3, 7);
        validateattributes(antArray, {'numeric'}, {'integer', 'nonnegative', '<', 10});
        ANT = polyval(antArray, 10);
        
        switch ANT
            case 000
                A = 1;
            case 001
                A = 0.5;
            case 010
                A = 0.25;
            case 011
                A = 0.125;
            case 100
                A = -1; %supposed to be unused
            case 101
                A = 10;
            case 110
                A = 0;
            case 111
                A = 0;
        end
        v(i) = v(i)*A;
    end
end

