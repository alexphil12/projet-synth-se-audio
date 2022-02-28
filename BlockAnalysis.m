function[pitch,sigma2,Aopt]=BlockAnalysis(X,M,Fe)
Cx=BiasedCrosscor(X);
[Aopt,sigma2]=Yule_Walker_solver(Cx,M);
pitch=trouve_freq(X,Fe);%récupération et utilisation des fonctions susnomée
cv=isVoiced2(Cx);
if cv==0
    pitch=-1;
end
end
