function [ m, v, N ] = Sample_CC_sparse( level )

%%%
% Use Smolyak sparse Clenshaw-Curtis sampling, with each dimension at the same level.
%%%

[pts, weights] = spquad(2,level);
N = length(pts);

m = 0;
v = 0;

wsum = sum(weights);

for i = 1:size(pts,1);
    Y1 = pts(i,1);
    Y2 = pts(i,2);
    u = Heat_Solution(Y1, Y2);
    m = m + u * weights(i);
    v = v + u.^2 * weights(i);
end

m = m / wsum;
v = v / wsum;

v = v - m.^2; % Use the fact that Var(X) = E[X^2] - (E[X])^2

end

