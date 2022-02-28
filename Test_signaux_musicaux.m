%%implémentation complète pour un morceau de musique donné
%En première étape on charge les datas sonores, puis on fait les calculs
%nécessaires au découpage en tronçon de 256 échantillons.
[sig_musique,fe_musique]=audioread("Italobrothers - Moonlight Shadow (HBz Remix).wav");
sig_musique1=(sig_musique(:,1))';
nbre_troncon_musique=round(length(sig_musique1)/256);
sig_recons=zeros(1,length(sig_musique1));%On exécute sur chaque tronçons l'analyse et la synthèse avec
for k=1:1:nbre_troncon_musique-1%comme paramètre N=100(100 coefficients Aopt) et la fréquence d'échantillonage 
    if(sig_musique1((k-1)*256+1:(k-1)*256+256)==zeros(1,256))%du morceau d'origine
        sig_recons((k-1)*256+1:(k-1)*256+256)=zeros(1,256);
    else
        [pitch,sigma2,Aopt]=BlockAnalysis(sig_musique1((k-1)*256+1:(k-1)*256+256),100,fe_musique);
        sig_recons((k-1)*256+1:(k-1)*256+256)=BlockSynthesis(pitch,sigma2,Aopt,256,fe_musique);
    end
end
%on écoute le résultat(attention les morceaux choisis sont
%assez long et ne plaisent pas à toutes les oreilles !)
audiowrite("moon.wav",sig_recons,fe_musique)




