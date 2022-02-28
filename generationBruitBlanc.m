
%PHILIPPON Alexandre et ALBERTELLI Benjamin, 2G1TD1TP1

% fonction annexe TP1

function [bruit_blanc] = generationBruitBlanc(N, sigma)

% génère un bruit blanc à partir du loi de densité de probabilité
% gaussienne. La loi gaussienne est centrée.

    bruit_blanc = randn(1, N)*sigma;

end 
    