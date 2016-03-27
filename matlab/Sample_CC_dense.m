function [ m, v, xp5, N ] = Sample_CC_dense( level )

%%%
% Use tensor-product Clenshaw-Curtis sampling, with each dimension at the same level.
%%%

[pts, weights] = spquad(1,level);
N = length(pts)^2;

m = 0;
v = 0;
xp5 = 0;

wsum = 0;

for i = 1:length(pts)
    for j = 1:length(pts)
        Y1 = pts(i);
        Y2 = pts(j);
        [mi, vi, xp5i] = Heat_Stats(Y1, Y2);
        m = m + mi * weights(i) * weights(j);
        v = v + vi * weights(i) * weights(j);
        xp5 = xp5 + xp5i * weights(i) * weights(j);
        wsum = wsum + weights(i) * weights(j);
    end
end

m = m / wsum;
v = v / wsum;
xp5 = xp5 / wsum;

end

