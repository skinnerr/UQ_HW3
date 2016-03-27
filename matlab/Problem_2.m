function [] = Problem_2()

Set_Default_Plot_Properties();

% Solution domain.
Nx = 101;
x0 = 0;
xf = 1;
x = linspace(x0, xf, Nx)';

%%%
% Latin Hypercube Sampling (LHS)
%%%

Ncoll = 2.^(0:5);

m = nan(Nx,length(Ncoll));
v = nan(Nx,length(Ncoll));

for i = 1:length(Ncoll)
    fprintf('Sampling LHS: %2i points\n', Ncoll(i)^2);
    [m(:,i), v(:,i)] = Sample_LHS(Ncoll(i));
end

% Plots.

figure();

for i = 1:length(Ncoll)

    dn = sprintf('%i',Ncoll(i)^2);

    subplot(2,1,1);
    hold on;
    if i == length(Ncoll)
        plot(x,m(:,i),'k--','DisplayName',dn);
    else
        plot(x,m(:,i),'DisplayName',dn);
    end

    subplot(2,1,2);
    hold on;
    if i == length(Ncoll)
        plot(x,v(:,i),'k--','DisplayName',dn);
    else
        plot(x,v(:,i),'DisplayName',dn);
    end
    
end

subplot(2,1,1);
ylabel('Mean');
xlabel('x');
hleg = legend('show');
set(hleg,'Location','EastOutside');

subplot(2,1,2);
ylabel('Variance');
xlabel('x');
hleg = legend('show');
set(hleg,'Location','EastOutside');

%%%
% Clenshaw-Curtis (CC) tensor-product grid
%%%

level = 0:5;

Ncoll = nan(1,length(level));
m = nan(Nx,length(Ncoll));
v = nan(Nx,length(Ncoll));

for i = 1:length(level)
    fprintf('Sampling CC (dense): level %1i\n', level(i));
    [m(:,i), v(:,i), Ncoll(i)] = Sample_CC_dense(level(i));
end

figure();

for i = 1:length(level)

    dn = sprintf('%i',Ncoll(i));

    subplot(2,1,1);
    hold on;
    if i == length(level)
        plot(x,m(:,i),'k--','DisplayName',dn);
    else
        plot(x,m(:,i),'DisplayName',dn);
    end

    subplot(2,1,2);
    hold on;
    if i == length(level)
        plot(x,v(:,i),'k--','DisplayName',dn);
    else
        plot(x,v(:,i),'DisplayName',dn);
    end
    
end

subplot(2,1,1);
ylabel('Mean');
xlabel('x');
hleg = legend('show');
set(hleg,'Location','EastOutside');

subplot(2,1,2);
ylabel('Variance');
xlabel('x');
hleg = legend('show');
set(hleg,'Location','EastOutside');

%%%
% Clenshaw-Curtis (CC) Smolyak sparse grid
%%%

level = 0:5;

Ncoll = nan(1,length(level));
m = nan(Nx,length(Ncoll));
v = nan(Nx,length(Ncoll));

for i = 1:length(level)
    fprintf('Sampling CC (sparse): level %1i\n', level(i));
    [m(:,i), v(:,i), Ncoll(i)] = Sample_CC_sparse(level(i));
end

% Plots.

figure();

for i = 1:length(level)

    dn = sprintf('%i',Ncoll(i));

    subplot(2,1,1);
    hold on;
    if i == length(level)
        plot(x,m(:,i),'k--','DisplayName',dn);
    else
        plot(x,m(:,i),'DisplayName',dn);
    end

    subplot(2,1,2);
    hold on;
    if i == length(level)
        plot(x,v(:,i),'k--','DisplayName',dn);
    else
        plot(x,v(:,i),'DisplayName',dn);
    end
    
end

subplot(2,1,1);
ylabel('Mean');
xlabel('x');
hleg = legend('show');
set(hleg,'Location','EastOutside');

subplot(2,1,2);
ylabel('Variance');
xlabel('x');
hleg = legend('show');
set(hleg,'Location','EastOutside');

return

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

