
%PHILIPPON Alexandre et ALBERTELLI Benjamin, 2G1TD1TP1

% fonction annexe TP1

function [Ar] = generationAR(a, Sigma, N)

% Génère une occurence d'un processus aléatoire auto-regressif 1 ayant pour
% paramètre a et sigma

    Ar = zeros(1, N);
    Ar(1) = randn.*Sigma;

    for k = 2:N
        Ar(k) = a*Ar(k-1) + randn()*Sigma;
    end

end