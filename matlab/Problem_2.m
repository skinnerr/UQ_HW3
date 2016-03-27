function [] = Problem_2()

Set_Default_Plot_Properties();

%%%
% Latin Hypercube Sampling (LHS)
%%%

N = 2.^(0:5);

m =   nan(1,length(N));
v =   nan(1,length(N));
mxp5 = nan(1,length(N));

for i = 1:length(N)
    fprintf('Sampling LHS: %2i points\n', N(i)^2);
    [m(i), v(i), mxp5(i)] = Sample_LHS(N(i));
end

N = N.^2;

% Plots.

figure();

subplot(2,1,1);
plot(N,m,'b-o');
set(gca,'XScale','log');
ylabel('Mean');
xlabel('N');

subplot(2,1,2);
plot(N,v,'r-o');
set(gca,'XScale','log');
ylabel('Variance');
xlabel('N');

%%%
% Clenshaw-Curtis (CC) tensor-product grid
%%%

level = 0:5;

m =   nan(1,length(level));
v =   nan(1,length(level));
mxp5 = nan(1,length(level));
N =   nan(1,length(level));

for i = 1:length(level)
    fprintf('Sampling CC (dense): level %1i\n', level(i));
    [m(i), v(i), mxp5(i), N(i)] = Sample_CC_dense(level(i));
end

% Plots.

figure();

subplot(2,1,1);
plot(N,m,'b-o');
set(gca,'XScale','log');
ylabel('Mean');
xlabel('N');

subplot(2,1,2);
plot(N,v,'r-o');
set(gca,'XScale','log');
ylabel('Variance');
xlabel('N');

%%%
% Clenshaw-Curtis (CC) Smolyak sparse grid
%%%

level = 0:5;

m =   nan(1,length(level));
v =   nan(1,length(level));
mxp5 = nan(1,length(level));
N =   nan(1,length(level));

for i = 1:length(level)
    fprintf('Sampling CC (sparse): level %1i\n', level(i));
    [m(i), v(i), mxp5(i), N(i)] = Sample_CC_sparse(level(i));
end

% Plots.

figure();

subplot(2,1,1);
plot(N,m,'b-o');
set(gca,'XScale','log');
ylabel('Mean');
xlabel('N');

subplot(2,1,2);
plot(N,v,'r-o');
set(gca,'XScale','log');
ylabel('Variance');
xlabel('N');

%%%
% Monte Carlo
%%%

N = 2.^(2:10);

m =   nan(1,length(N));
v =   nan(1,length(N));
mxp5 = nan(1,length(N));

for i = 1:length(N)
    fprintf('Sampling MC: %2i points\n', N(i));
    [m(i), v(i), mxp5(i)] = Sample_MC(N(i));
end

% Plots.

figure();

subplot(2,1,1);
plot(N,m,'b-o');
set(gca,'XScale','log');
ylabel('Mean');
xlabel('N');

subplot(2,1,2);
plot(N,v,'r-o');
set(gca,'XScale','log');
ylabel('Variance');
xlabel('N');

end

