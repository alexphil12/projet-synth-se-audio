
% TP Modélisation des signaux aléatoires, PHILIPPON Alexandre et ALBERTELLI Benjamin, 2G1TD1TP1

%%
% Séance 1 le vendredi 10 décembre.

longueur_X = 200;
fe = 10000;
X = 0:1/fe:(longueur_X-1)/fe;

% Génération du sinus à phase aléatoire
mu = 300;
SIN = generationSin(mu, X);
SIN_biased_crosscor = BiasedCrosscor(SIN);
SIN_unbiased_crosscor = unBiasedCrosscor(SIN);
SIN_th = 0.5*cos(2*pi*mu.*X);
% Génération du bruit blanc
sigma = 4;
BRUIT_BLANC = generationBruitBlanc(longueur_X, sigma);

BRUIT_BLANC_biased_crosscor = BiasedCrosscor(BRUIT_BLANC);
BRUIT_BLANC_unbiased_crosscor = unBiasedCrosscor(BRUIT_BLANC);
BRUIT_BLANC_th = zeros(1, longueur_X);
BRUIT_BLANC_th(1) = sigma^2;


% Génération du filtre AR
a = 0.7;
N = length(X);
Sigma=2;
AR = generationAR(a, Sigma, N);
N_affiche = 0:length(X) - 1;

AR_biased_crosscor = BiasedCrosscor(AR);
AR_unbiased_crosscor = unBiasedCrosscor(AR);
AR_th = (Sigma^2)*(a.^N_affiche)/(1-a^2);

%%
% Affichage de l'autoccorélation biaisée et non biaisée du sinus à phase aléatoire

figure(1)
plot(N_affiche, SIN_biased_crosscor,'+');
hold on
plot(N_affiche, SIN_unbiased_crosscor,'+')
plot(N_affiche, SIN_th)
hold off
legend("autocorrélation biaisée","autocorrélation non biaisée", "autoccorélation théorique")
title("Autocorrélation biaisée et non biaisée d'un sinus à phase aléatoire")
xlabel("Décalage p")
ylabel("\gamma(p,w)")

% Affichage de l'autoccorélation biaisée et non biaisée du bruit blanc

figure(2)
plot(N_affiche, BRUIT_BLANC_biased_crosscor,'+');
hold on
plot(N_affiche, BRUIT_BLANC_unbiased_crosscor,'+')
plot(N_affiche, BRUIT_BLANC_th)
hold off
legend("autocorrélation biaisée","autocorrélation non biaisée", "autoccorélation théorique")
title("Autocorrélation biaisée et non biasée d'un bruit blanc")
xlabel("Décalage p")
ylabel("\gamma(p,w)")

% Affichage de l'autoccorélation biaisée et non biaisée du bfiltre AR

figure(3)
plot(N_affiche, AR_biased_crosscor,'+');
hold on
plot(N_affiche, AR_unbiased_crosscor,'+')
plot(N_affiche, AR_th)
hold off
legend("autocorrélation biaisée","autocorrélation non biaisée", "autoccorélation théorique")
title("Autocorrélation biaisée et non biasée d'un filtre AR")
xlabel("Décalage p")
ylabel("\gamma(p,w)")

%%
% Test de la fonction isVoiced qui détermine si un son est voisé ou non 

[voice1, fe1]=audioread("voise_nng.flac");
[voice2, fe2]=audioread("voise_oo.flac");
[voice3, fe3]=audioread("voise_ooo.flac");

[non_voice1, fe_1]=audioread("nonvoise_ch.flac");
[non_voice2, fe_2]=audioread("nonvoise_hw.flac");
[non_voice3, fe_3]=audioread ("nonvoise_kss.flac");
[non_voice4, fe_4]=audioread("nonvoise_th.flac");

voice1=voice1';
voice2=voice2';
voice3=voice3';

non_voice1=non_voice1';
non_voice2=non_voice2';
non_voice3=non_voice3';
non_voice4=non_voice4'; 


bool_voice1=isVoiced2(unBiasedCrosscor(voice1));
bool_voice2=isVoiced2(unBiasedCrosscor(voice2));
bool_voice3=isVoiced2(unBiasedCrosscor(voice3));

bool_non_voice1=isVoiced2(BiasedCrosscor(non_voice1));
boo1_non_voice2=isVoiced2(BiasedCrosscor(non_voice2));
boo1_non_voice3=isVoiced2(BiasedCrosscor(non_voice3));
bool_non_voice4=isVoiced2(BiasedCrosscor(non_voice4));

% On lit les valeurs des différents booléens dans l'espace avec les
% variables à droite. On obtient bien un booléen à 1 pour les signaux
% voisés et un booléen à 0 pour les non voisés. Seul le signal voisé
% "voise_oo.flac" (appelé voice 2 dans nos test) n'est pas celui attendu
% mais en s'intéressant de plus près à la BSP du signal on remarque qu'en 
% fait le résultat est cohérent.


%%
% FIN DE LA SEANCE

%%
% DEBUT DE LA SEANCE 2 vendredi 17 décembre

Nfft = 1000;
nu = 0:1/Nfft:0.5-1/Nfft;
fe_test=800;
te=1/fe_test;
nu1=0:te:5-te;
sig=cos(2*pi*nu1*200);
sig=[sig zeros(1,Nfft-length(sig))];
nu_freq=-0.5:1/length(sig):0.5-(1/length(sig));
sig_hann=fenetrage_sig(sig,"hann");
sig_trian=fenetrage_sig(sig,"triangulaire");
sig_haming=fenetrage_sig(sig,"hamming");
sig_blackman=fenetrage_sig(sig,"blackman");
fft_sig=abs(fft(sig))/max(abs(fft(sig)));
fft_trian=abs(fft(sig_trian))/max(abs(fft(sig_trian)));
fft_hann=abs(fft((sig_hann)))/max(abs(fft(sig_hann)));
fft_haming=abs(fft((sig_haming)))/max(abs(fft(sig_haming)));
fft_blackman=abs(fft((sig_blackman)))/max(abs(fft(sig_blackman)));
figure(12)
plot(nu_freq,fft_sig);
hold on
plot(nu_freq,fft_trian);
plot(nu_freq,fft_hann);
plot(nu_freq,fft_haming);
plot(nu_freq,fft_blackman);
hold off
legend("fft rectangulaire","fft triangulaire","fft hann","fft haming","fft blackman");
title("Les différents fenêtrage test sur sinus");
xlabel("\nu");
ylabel("Amplitude");

%%
% méthode par le corrélogramme

[DSP_sin_unbiased, nu_sin1] = psdEstimator_Co(unBiasedCrosscor(SIN), Nfft);
[DSP_sin_biased, nu_sin2] = psdEstimator_Co(BiasedCrosscor(SIN), Nfft);
DSP_sin_th = zeros(1,Nfft/2);
DSP_sin_th(round(mu*Nfft/fe)+1) = longueur_X*0.25; %Nfft*0.5 si méthode périodogramme

[DSP_BB_unbiased, nu_bb1] = psdEstimator_Co(unBiasedCrosscor(BRUIT_BLANC), Nfft);
[DSP_BB_biased, nu_bb2] = psdEstimator_Co(BiasedCrosscor(BRUIT_BLANC), Nfft);
DSP_BB_th = ones(1,Nfft/2).*sigma^2;

[DSP_AR_unbiased, nu_ar1] = psdEstimator_Co(unBiasedCrosscor(AR), Nfft); 
[DSP_AR_biased, nu_ar2] = psdEstimator_Co(BiasedCrosscor(AR), Nfft); 
DSP_AR_th = ((sigma^2)/(1-a^2))*abs(((1-exp(2*1i*pi.*nu-log(a))).^(-1))+((1-exp(-2*1i*pi.*nu + log(a))).^(-1))-1);
DSP_AR_th2=psdEstimator_Co(AR_th,Nfft);
% on trace les DSP en utilisant la méthode du corrélograme (biaisé et non biaisée) et on trace aussi la DSP théorique 

figure(4)
plot(nu, DSP_sin_unbiased, '+')
hold on 
plot(nu, DSP_sin_biased, '+')
plot(nu, DSP_sin_th)
legend("corrélograme non biaisée", "corrélogramme biaisée","DSP théorique")
title("DSP par méthode du corrélogramme du sinus à phase aléatoire")
xlabel("\nu")
ylabel("\gamma(\nu,\omega)")

figure(5)
plot(nu, DSP_BB_unbiased, '+')
hold on 
plot(nu, DSP_BB_biased, '+')
plot(nu, DSP_BB_th)
legend("corrélograme non biaisée", "corrélogramme biaisée","DSP théorique")
title("DSP par méthode du corrélogramme du bruit blanc")
xlabel("\nu")
ylabel("\gamma(\nu,\omega)")

figure(6)
plot(nu, DSP_AR_unbiased, '+')
hold on 
plot(nu, DSP_AR_biased, '+')
plot(nu, DSP_AR_th2)
legend("corrélograme non biaisée", "corrélogramme biaisée","DSP théorique")
title("DSP par méthode du corrélogramme du filtre AR")
xlabel("\nu")
ylabel("\gamma(\nu,\omega)")

%%
%test pour un des signaux audio du moyennage pour améliorer la précision
%de la DSP
[sigArmand, fe_armand] = audioread("193305__margo-heston__ch.flac");

[DSP_Armand_biased, nu_armand] = psdEstimator_Co(BiasedCrosscor(sigArmand),69632,1);
[DSP_Armand_unbiased,nu_armand2]= psdEstimator_Co(unBiasedCrosscor(sigArmand),69632,1);

figure(7)
plot(nu_armand, DSP_Armand_biased, '+')
hold on
plot(nu_armand2,DSP_Armand_unbiased,'+')
hold off
legend("corrélograme biaisée","corrélogramme non biaisée")
title("DSP par méthode du corrélogramme d'Armand")
xlabel("\nu")
ylabel("\gamma(\nu,\omega)")


%%
% FIN DE LA SEANCE

%%
% DEBUT DE LA SEANCE 3 jeudi 6 janvier
N_affiche1=0:999;
a2=0.8;
a1=[0.8,0.1,0.2];
sigma=2;
AR_th1 = (sigma^2)*(a2.^N_affiche1)/(1-a2^2);
AR_3=generationAR_P(a1,1,200);
[a_AR,v_AR]=Yule_Walker_solver(AR_th1);
[a_AR1,v_AR1]=aryule(AR_th1,999);
[a_AR_P,v_AP]=Yule_Walker_solver(BiasedCrosscor(AR_3),3);
[a_Bruit_blanc,v_Bruit_blanc]=Yule_Walker_solver(BRUIT_BLANC_th);
[a_sinus,v_sinus]=Yule_Walker_solver(SIN_th);
affiche_erreur(BiasedCrosscor(AR_3));
%mise en oeuvre des calcul par Yule-walker des coefficiants, on lits
%ensuiste ceux ci et on les compares à leurs valeurs attendues.
%%
% DEBUT DE LA SEANCE 4 jeudi 13 janvier
%implémentation du projets 'complet' sur les échantillons précédemment
%étudié et observation de l'un d'entre eux pour estimer la perfomance des
%reconstitutions
[pitch_voice1,sigma2_voice1,Aopt_voice1]=BlockAnalysis(voice1,50,fe1);
[pitch_voice2,sigma2_voice2,Aopt_voice2]=BlockAnalysis(voice2,50,fe2);
[pitch_voice3,sigma2_voice3,Aopt_voice3]=BlockAnalysis(voice3,50,fe3);

[pitch_non_voice1,sigma2_non_voice1,Aopt_non_voice1]=BlockAnalysis(non_voice1,50,fe_1);
[pitch_non_voice2,sigma2_non_voice2,Aopt_non_voice2]=BlockAnalysis(non_voice2,50,fe_2);
[pitch_non_voice3,sigma2_non_voice3,Aopt_non_voice3]=BlockAnalysis(non_voice3,50,fe_3);
[pitch_non_voice4,sigma2_non_voice4,Aopt_non_voice4]=BlockAnalysis(non_voice4,50,fe_4);

Y_voice_1=BlockSynthesis(pitch_voice1,sigma2_voice1,Aopt_voice1,1024,fe1);
Y_voice_2=BlockSynthesis(pitch_voice2,sigma2_voice2,Aopt_voice2,1024,fe1);
Y_voice_3=BlockSynthesis(pitch_voice3,sigma2_voice3,Aopt_voice3,1024,fe1);

Y_non_voice_1=BlockSynthesis(pitch_non_voice1,sigma2_non_voice1,Aopt_non_voice1,1024,fe1);
Y_non_voice_2=BlockSynthesis(pitch_non_voice2,sigma2_non_voice2,Aopt_non_voice2,1024,fe1);
Y_non_voice_3=BlockSynthesis(pitch_non_voice3,sigma2_non_voice3,Aopt_non_voice3,1024,fe1);
Y_non_voice_4=BlockSynthesis(pitch_non_voice4,sigma2_non_voice4,Aopt_non_voice4,1024,fe1);

sound(voice1)
sound(Y_voice_1)
sound(non_voice1)
sound(Y_non_voice_1)

figure()
plot(voice1)
hold on
plot(Y_voice_1)
hold off
legend("signal de base","signal reconstitué");
figure()
plot(non_voice1)
hold on
plot(Y_non_voice_1)
hold off
+legend("signal de base","signal reconstitué");