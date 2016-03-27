function [ u ] = Heat_Stats( Y1, Y2 )

%%%
% Returns the mean and variance of the heat equation solution.
%%%

% Solution domain.
N = 101;
x0 = 0;
xf = 1;
x = linspace(x0, xf, N)';
h = x(2) - x(1);

% Boundary conditions (0 = initial, f = final).
u0  = 0;
uf  = 0;

% Solve heat equation with sampled inputs.
Y = [Y1,Y2];
K = Generate_K(N, Y);
u = Solve_u(h, u0, uf, K);

end

