function [ m, v, xp5 ] = Sample_MC( N )

%%%
% Use Monte Carlo sampling on the heat equation solution, with N samples.
%%%

m = 0;
v = 0;
xp5 = 0;

for i = 1:N
    Y1 = -1 + 2*rand();
    Y2 = -1 + 2*rand();
    [mi, vi, xp5i] = Heat_Stats(Y1, Y2);
    m = m + mi / N;
    v = v + vi / N;
    xp5 = xp5 + xp5i / N;
end

end

