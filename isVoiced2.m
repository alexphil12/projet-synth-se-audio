function bool=isVoiced2(Cx)
   if(Cx(1)>=Cx(2)*1.5)
       bool=0;         
   else                
       bool=1;         
   end                
   end                 
% En théorie, l'autocorrélation d'un signal voisé,(somme de sinus),
% périodique et donc la valeur en p=1 est proche de la valeur en P=0.

% Celle d'un signal non voisé(apparenté à un bruit ) à en revanche une
% valeur en P=0 de sigma² et est nul partout ailleurs. Il doit donc y avoir

% un grand écart(en proportion) entre gamma(0) et gamma(1).
% D'où le critère évaluant l'écart en gamma(0) et gamma(1).