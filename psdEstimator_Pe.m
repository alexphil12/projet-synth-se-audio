function[PSD,nu]=psdEstimator_Pe(X,Nfft,K)
if ~exist('Nfft', 'var')
        Nfft=2*length(X);
end
if ~exist('K', 'var')
        K=1;
end
assert(Nfft>=length(X));
PSD_ent=zeros(K,round(Nfft/K));
X_calc=[X zeros(1,Nfft-length(X))];%même principe que PSD estimator Co seulement ici
for j=1:K%l'oppération calculant la PSD est 1/N*abs(fft)^2.
    PSD_ent(j,:)=(1/length(X_calc))*abs(fft(X_calc(round(Nfft/K)*(j-1)+1:round(Nfft/K)*j))).^2;
end    
PSD_ent_1=mean(PSD_ent,1);
nu=0:K/Nfft:0.5-K/Nfft;
PSD=PSD_ent_1(1:round((Nfft/K)/2));
end