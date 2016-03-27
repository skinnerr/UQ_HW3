function [ m, v, xp5, N ] = Sample_CC_sparse( level )

%%%
% Use Smolyak sparse Clenshaw-Curtis sampling, with each dimension at the same level.
%%%

[pts, weights] = spquad(2,level);
N = length(pts);

m = 0;
v = 0;
xp5 = 0;

wsum = sum(weights);

for i = 1:size(pts,1);
    Y1 = pts(i,1);
    Y2 = pts(i,2);
    [mi, vi, xp5i] = Heat_Stats(Y1, Y2);
    m = m + mi * weights(i);
    v = v + vi * weights(i);
    xp5 = xp5 + xp5i * weights(i);
end

m = m / wsum;
v = v / wsum;
xp5 = xp5 / wsum;

end

