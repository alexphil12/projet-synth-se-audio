function Y=BlockSynthesis(pitch,sigma2,Aopt,N,fe)
  if(pitch==-1)
     E=rand([1,N]);
     Y=-filter(1,cat(2,eye(1,1),-transpose(Aopt)),E);%si le signal est non voisé on fait
  else% passé un bruit blanc dans le filtre
     E=zeros([1,N]);
     for j=1:floor(fe/pitch):N%sinon on fait passer une impultion à la fréquence pitch
       E(j)=1;
     end
     Ce=BiasedCrosscor(E);
     Si2=Ce(1);
     coef=sigma2/Si2;
     E=E*coef;%et donc la variance est la variance sigma2.
     Y=-filter(1,cat(2,eye(1,1),-transpose(Aopt)),E);%le filtre n'est pas tout à fait 1/Aopt
  end%mais plut 1/(1-Aopt) d'où la forme dans la fonction filter.
end