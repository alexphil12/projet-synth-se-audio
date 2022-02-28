
%PHILIPPON Alexandre et ALBERTELLI Benjamin, 2G1TD1TP1

% fonction annexe TP1

function [SIN] = generationSin(mu, X)

% Génère un sinus à phase aléatoire

    phase = rand(1)*2*pi;
    SIN = sin(mu*2*pi.*X + phase);

end