
stationNumber = 2; % 0 = Azimuth Station, 1 = Back Azimuth Station, 2 = Elevation Station
totalMatrix = sequenceOneFunction(stationNumber);
totalMatrix = cat(1, totalMatrix, zeros(1000, 8));
totalMatrix = cat(1, totalMatrix, sequenceTwoFunction(stationNumber));
totalMatrix = cat(1, totalMatrix, zeros(13000, 8));
totalMatrix = cat(1, totalMatrix, sequenceOneFunction(stationNumber));
totalMatrix = cat(1, totalMatrix, zeros(19000, 8));
totalMatrix = cat(1, totalMatrix, sequenceTwoFunction(stationNumber));
totalMatrix = cat(1, totalMatrix, zeros(2000, 8));
totalMatrix = cat(1, totalMatrix, sequenceOneFunction(stationNumber));
totalMatrix = cat(1, totalMatrix, zeros(20000, 8));
totalMatrix = cat(1, totalMatrix, sequenceTwoFunction(stationNumber));
totalMatrix = cat(1, totalMatrix, zeros(6000, 8));
totalMatrix = cat(1, totalMatrix, sequenceOneFunction(stationNumber));
totalMatrix = cat(1, totalMatrix, sequenceTwoFunction(stationNumber));
totalMatrix = cat(1, totalMatrix, zeros(18000, 8));