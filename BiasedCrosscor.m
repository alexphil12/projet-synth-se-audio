
%PHILIPPON Alexandre et ALBERTELLI Benjamin, 2G1TD1TP1

%%
% 2 Estimateur biaisé d'autocorrélation (fonction TP1)

function [Cx, p] = BiasedCrosscor(X, pmax)

    N = length(X);

    if ~exist('pmax', 'var')
        pmax = N-1;
    end

    Cx = zeros(1, N);
    p = 0:pmax;
    for l = 0:pmax
        Cx(l+1) = (1/N)*X(l+1:N)*X(1:N-l).';
    end 
end 



