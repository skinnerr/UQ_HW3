function [ m, v, xp5 ] = Sample_LHS( N )

%%%
% Use Latin Hypercube Sampling (LHS) in 2-D, with each dimension containing N intervals.
%%%

starts = linspace(-1, 1, N+1);
h = starts(2) - starts(1);

m = 0;
v = 0;
xp5 = 0;

for i = 1:N
    for j = 1:N
        Y1 = starts(i) + h*rand();
        Y2 = starts(j) + h*rand();
        [mi, vi, xp5i] = Heat_Stats(Y1, Y2);
        m = m + mi / N^2;
        v = v + vi / N^2;
        xp5 = xp5 + xp5i / N^2;
    end
end

end

