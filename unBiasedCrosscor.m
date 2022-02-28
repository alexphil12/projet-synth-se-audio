
%PHILIPPON Alexandre et ALBERTELLI Benjamin, 2G1TD1TP1

%%
% 3 Estimateur non biaisé d'autocorrélation (fonction TP1)

function [Cx, p]= unBiasedCrosscor(X, pmax)

    N = length(X);

    if ~exist('pmax', 'var')
        pmax = N-1;
    end

    p = 0:pmax;
    coef = N./(N-p);
    Cx = BiasedCrosscor(X, pmax);
    Cx = Cx.*coef;

end 