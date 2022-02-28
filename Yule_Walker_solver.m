%%
% 1 Résolution des équations de Yule-Walker (fonction TP3)
function[a,v]= Yule_Walker_solver(Cx,K)
N = length(Cx);
    if ~exist('K', 'var')
        K= N-1;
    end
gamma=Cx(1:K);
Px=conj(Cx(2:K+1)');
sys=toeplitz(gamma);%On applique ici les formules du cours ni plus ni moins
sys_inv=inv(sys);
a=sys_inv*Px;
v=Cx(1)-((Px')*a);
