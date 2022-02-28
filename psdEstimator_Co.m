function[PSD,nu]=psdEstimator_Co(Xc,Nfft,K)
if ~exist('Nfft', 'var')
        Nfft=2*length(Xc);
end
if ~exist('K', 'var')
        K=1;
end
assert(Nfft>=length(Xc));%on evite ainsi de tronquer le signal plutôt que de le zero padder
PSD_ent=zeros(K,round(Nfft/K));%par ailleurs ça évite des erreurs quand à la taille du tableau
X_calc=[Xc zeros(1,Nfft-length(Xc))];
for j=1:K
    PSD_ent(j,:)=abs(fft(X_calc(round(Nfft/K)*(j-1)+1:round(Nfft/K)*j)));%ici on calcul 
end    %la PSD corrélogramme sur chaque tronçon donc la taille est induite par K
PSD_ent_1=mean(PSD_ent,1);%on en fait ensuite la moyenne
nu=0:K/Nfft:0.5-K/Nfft;
PSD=PSD_ent_1(1:round((Nfft/K)/2));%On affiche unique la partie sur [O,O,5] le reste est redondant.
end