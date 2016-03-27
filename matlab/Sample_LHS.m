function [ m, v ] = Sample_LHS( N )

%%%
% Use Latin Hypercube Sampling (LHS) in 2-D, with each dimension containing N intervals.
%%%

starts = linspace(-1, 1, N+1);
h = starts(2) - starts(1);

m = zeros(101,1);
v = zeros(101,1);

for i = 1:N
    for j = 1:N
        Y1 = starts(i) + h*rand();
        Y2 = starts(j) + h*rand();
        u = Heat_Solution(Y1, Y2);
        m = m + u / N^2;
        v = v + u.^2 / N^2;
    end
end

v = v - m.^2; % Use the fact that Var(X) = E[X^2] - (E[X])^2

end

