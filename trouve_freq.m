function freq=trouve_freq(X,fe)
N=length(X);
nu_f=-fe/2:fe/N:(fe/2)-(fe/N);%cette fonction suit la même logique que Isvoiced
spec_X=Spectrogramme(X);%on calcul le Spectrogramme du signal en ayant au préalable créer le vecteur nu
indice=find(spec_X==max(spec_X),1);%On cherche l'indice de son max et on regarde la valeur nu(négative au
freq=abs(nu_f(indice));%de sa construction d'où le abs)correspondant à l'indice pour retrouver la fréquence 
end%fondamentale
