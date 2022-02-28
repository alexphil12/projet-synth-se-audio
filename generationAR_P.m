%PHILIPPON Alexandre et ALBERTELLI Benjamin, 2G1TD1TP1

% fonction annexe TP1

function [Ar_P] = generationAR_P(a, Sigma, N)

    P=length(a);
    assert(N>=P);
    Ar_P = zeros(1, N);
    Ar_P(1:P) = randn(1,P).*Sigma;
    for k = P+1:N
        Ar_P(k) = Ar_P(k-P:k-1)*a' + randn()*Sigma;
    end

end