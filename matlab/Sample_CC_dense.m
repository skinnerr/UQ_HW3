function [ m, v, N ] = Sample_CC_dense( level )

%%%
% Use tensor-product Clenshaw-Curtis sampling, with each dimension at the same level.
%%%

[pts, weights] = spquad(1,level);
N = length(pts)^2;

m = 0;
v = 0;

wsum = 0;

for i = 1:length(pts)
    for j = 1:length(pts)
        Y1 = pts(i);
        Y2 = pts(j);
        u = Heat_Solution(Y1, Y2);
        m = m + u * weights(i) * weights(j);
        v = v + u.^2 * weights(i) * weights(j);
        wsum = wsum + weights(i) * weights(j);
    end
end

m = m / wsum;
v = v / wsum;

v = v - m.^2; % Use the fact that Var(X) = E[X^2] - (E[X])^2

end

