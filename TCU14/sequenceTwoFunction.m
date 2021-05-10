function sequenceTwoMatrix = sequenceTwoFunction(stationConstant)

    sequenceTwoMatrix = elevationFunction(stationConstant); % 5.6 ms
    sequenceTwoMatrix = cat(1, sequenceTwoMatrix, BDW5Function(stationConstant)); % 3.1 ms
    sequenceTwoMatrix = cat(1, sequenceTwoMatrix, zeros(2200, 8)); % 2.2 ms
    sequenceTwoMatrix = cat(1, sequenceTwoMatrix, azimuthFunction(stationConstant)); % 15.9 ms
    sequenceTwoMatrix = cat(1, sequenceTwoMatrix, BDW6Function(stationConstant)); % 3.1 ms
    sequenceTwoMatrix = cat(1, sequenceTwoMatrix, zeros(2200, 8)); % 2.2 ms
    sequenceTwoMatrix = cat(1, sequenceTwoMatrix, elevationFunction(stationConstant)); % 5.6 ms
    sequenceTwoMatrix = cat(1, sequenceTwoMatrix, ADW1Function(stationConstant)); % 5.9 ms
    sequenceTwoMatrix = cat(1, sequenceTwoMatrix, zeros(12300, 8)); % 12.3
    sequenceTwoMatrix = cat(1, sequenceTwoMatrix, elevationFunction(stationConstant)); % 5.6 ms
    sequenceTwoMatrix = cat(1, sequenceTwoMatrix, BDW4Function(stationConstant)); % 3.1 ms
    sequenceTwoMatrix = cat(1, sequenceTwoMatrix, zeros(2400, 8)); % 2.4 ms
end