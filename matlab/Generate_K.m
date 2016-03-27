function [ X ] = Generate_K( Nx, Y )

Set_Default_Plot_Properties();

sigma = 0.1;
ell = 2.0;
a = 1/2;
b = 2;
mean = 1.0;

if length(Y) ~= b
    error('Must provide Y-vector of same dimension as b.');
end

x = linspace(-a,a,Nx);
[l, phi] = Analytical_Eigs(sigma, ell, a, b, x);

X = mean * ones(1,Nx);
for i = 1:b
    X = X + sqrt(l(i)) * phi(:,i)' * Y(i);
end

end