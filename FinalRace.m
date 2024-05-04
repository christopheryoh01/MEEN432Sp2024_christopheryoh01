gentrack;
P4init;
simout = sim("P4_Combined_Electric_Vehicle.slx","StopTime","3600");
carX = simout.X.Data;
carY = simout.Y.Data;
tout = simout.tout;

race = raceStat(carX, carY, tout, path, simout)
disp(race)