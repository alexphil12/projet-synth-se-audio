function bool=isVoiced(Cx,fe)
N=length(Cx);
nu_f=-fe/2:fe/N:(fe/2)-(fe/N); 
spec_Cx=Spectrogramme(Cx);

% la méthode de détermination est la suivante, on calcule le spectrogramme de la DSP du signal X

indice=find(spec_Cx==max(spec_Cx),1);

% On cherche ensuite la fréquence correspondant au max de ce spectrogramme
% car c'est en fait la fréquence du fondamentale que l'on calcule.
% (l'autocorrelation à la  période/pseudo-période que le signal d'origine).

freq_max=abs(nu_f(indice));

% si la fréquence max est entre 400 et 100 hz,le signal est voisé
% sinon, il est non_voisé.

if((freq_max<=400)&&(freq_max>=100))
    bool=1;                      
else                             
    bool=0;
end
end



