function [] = Problem_1()

%%%
% Plots the Clenshaw-Curtis grids from which an A(q=4,d=2) Smolyak sparse grid is
% constructed via the Smolyak formula.
%%%

Set_Default_Plot_Properties();

d = 2;
q = 4;

ell = {[0,3], [1,2],        [2,1], [3,0], ...
       [0,4], [1,3], [2,2], [3,1], [4,0]};
iplot = [ 1, 2,    4,  5, ...
         6, 7, 8, 9, 10];
   
figure();
for iell = 1:length(ell)
    l1 = ell{iell}(1);
    l2 = ell{iell}(2);
    I1 = spquad(1,l1);
    I2 = spquad(1,l2);
    norm = l1 + l2;
    coeff = (-1)^(q-norm) * nchoosek(d-1, q-norm);
    
    subplot(2,5,iplot(iell));
    hold on;
    for i1 = 1:length(I1)
        plot(I1(i1),I2,'r.','MarkerSize',15);
    end
    title(sprintf('(%i,%i) [%+i]',l1,l2,coeff));
    bound = 1.2;
    xlim(bound*[-1,1]);
    ylim(bound*[-1,1]);
    box on;
    axis square;
end

end

