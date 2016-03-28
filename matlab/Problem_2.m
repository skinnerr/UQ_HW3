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

mxp5_LHS = m(51,:);
vxp5_LHS = v(51,:);
n_LHS = Ncoll.^2;

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
title('LHS');
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

mxp5_CCd = m(51,:);
vxp5_CCd = v(51,:);
n_CCd = Ncoll;

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
title('CC (dense)');
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

level = 0:7;

Ncoll = nan(1,length(level));
m = nan(Nx,length(Ncoll));
v = nan(Nx,length(Ncoll));

for i = 1:length(level)
    fprintf('Sampling CC (sparse): level %1i\n', level(i));
    [m(:,i), v(:,i), Ncoll(i)] = Sample_CC_sparse(level(i));
end

mxp5_CCs = m(51,:);
vxp5_CCs = v(51,:);
n_CCs = Ncoll;

true_m = m(51,end);
true_v = v(51,end);

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
title('CC (sparse)');
hleg = legend('show');
set(hleg,'Location','EastOutside');

subplot(2,1,2);
ylabel('Variance');
xlabel('x');
hleg = legend('show');
set(hleg,'Location','EastOutside');

%%%
% Monte Carlo
%%%

Ncoll = 2.^(4:10);

m = nan(Nx,length(Ncoll));
v = nan(Nx,length(Ncoll));

for i = 1:length(Ncoll)
    fprintf('Sampling MC: %2i points\n', Ncoll(i));
    [m(:,i), v(:,i)] = Sample_MC(Ncoll(i));
end

mxp5_MCS = m(51,:);
vxp5_MCS = v(51,:);
n_MCS = Ncoll;

% Plots.

figure();

for i = 1:length(Ncoll)

    dn = sprintf('%i',Ncoll(i));

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
title('MC');
hleg = legend('show');
set(hleg,'Location','EastOutside');

subplot(2,1,2);
ylabel('Variance');
xlabel('x');
hleg = legend('show');
set(hleg,'Location','EastOutside');

%%%
% Plot comparisons of convergence in the mean and variance at x = 0.5.
%%%

mc_bound_x = logspace(0, log10(1024), 100);
mc_bound_y = 1 ./ sqrt(mc_bound_x);

figure();

subplot(2,1,1);
hold on;
plot(n_LHS, abs(mxp5_LHS - true_m) / abs(true_m), '-o', 'DisplayName', 'LHS');
plot(n_CCd, abs(mxp5_CCd - true_m) / abs(true_m), '-o', 'DisplayName', 'CC (dense)');
plot(n_CCs, abs(mxp5_CCs - true_m) / abs(true_m), '-o', 'DisplayName', 'CC (sparse)');
plot(n_MCS, abs(mxp5_MCS - true_m) / abs(true_m), '-o', 'DisplayName', 'MC');
plot(mc_bound_x,mc_bound_y, 'DisplayName', '1/sqrt(N)');
xlim([1,1500]);
xlabel('N');
ylabel('Rel. Err. in Mean');
set(gca,'XScale','log');
set(gca,'YScale','log');
hleg = legend('show');
set(hleg,'Location','EastOutside');

subplot(2,1,2);
hold on;
plot(n_LHS, abs(vxp5_LHS - true_v) / abs(true_v), '-o', 'DisplayName', 'LHS');
plot(n_CCd, abs(vxp5_CCd - true_v) / abs(true_v), '-o', 'DisplayName', 'CC (dense)');
plot(n_CCs, abs(vxp5_CCs - true_v) / abs(true_v), '-o', 'DisplayName', 'CC (sparse)');
plot(n_MCS, abs(vxp5_MCS - true_v) / abs(true_v), '-o', 'DisplayName', 'MC');
xlim([1,1500]);
xlabel('N');
ylabel('Rel. Err. in Variance');
set(gca,'XScale','log');
set(gca,'YScale','log');
hleg = legend('show');
set(hleg,'Location','EastOutside');

end

