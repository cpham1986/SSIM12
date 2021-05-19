function sequenceOneMatrix = sequenceOneFunction(stationConstant)
    
    sequenceOneMatrix = elevationFunction(stationConstant); % 5.6 ms
    sequenceOneMatrix = cat(1, sequenceOneMatrix, BDW1Function(stationConstant)); % 3.1 ms
    sequenceOneMatrix = cat(1, sequenceOneMatrix, zeros(2200, 8)); % 2.2 ms
    sequenceOneMatrix = cat(1, sequenceOneMatrix, azimuthFunction(stationConstant)); % 15.9 ms
    sequenceOneMatrix = cat(1, sequenceOneMatrix, BDW3Function(stationConstant)); % 3.1 ms
    sequenceOneMatrix = cat(1, sequenceOneMatrix, zeros(2200, 8)); % 2.2 ms
    sequenceOneMatrix = cat(1, sequenceOneMatrix, elevationFunction(stationConstant)); % 5.6 ms
    sequenceOneMatrix = cat(1, sequenceOneMatrix, zeros(3100, 8)); % 3.1 ms
    sequenceOneMatrix = cat(1, sequenceOneMatrix, backAzimuthFunction(stationConstant)); % 11.9 ms
    sequenceOneMatrix = cat(1, sequenceOneMatrix, BDW2Function(stationConstant)); % 3.1 ms
    sequenceOneMatrix = cat(1, sequenceOneMatrix, elevationFunction(stationConstant)); % 5.6 ms
    sequenceOneMatrix = cat(1, sequenceOneMatrix, BDW4Function(stationConstant)); % 3.1 ms
    sequenceOneMatrix = cat(1, sequenceOneMatrix, zeros(2500, 8)); % 2.5 ms
end