function affiche_erreur(Xcor)
V=zeros(1,length(Xcor));
for k=1:length(Xcor)-1
    [a,sigma2]=Yule_Walker_solver(Xcor,k);
    V(k)=sigma2/Xcor(1);
end
figure();
plot(V);
xlabel("Ordre M");
ylabel("Erreur relative")
title("Erreur de prédiction en fonction de l'ordre M")
end
