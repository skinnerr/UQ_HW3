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
    u = Heat_Solution(Y1, Y2);
    m = m + u / N;
    v = v + u.^2 / N;
end

v = v - m.^2; % Use the fact that Var(X) = E[X^2] - (E[X])^2

end

