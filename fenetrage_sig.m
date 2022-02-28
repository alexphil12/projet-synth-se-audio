function Y=fenetrage_sig(X,nom)
if ~exist('nom', 'var')
        nom="rectangulaire";
end
N=length(X);
if(nom=="rectangulaire")
    Y=X;
end  
if(nom=="triangulaire")
        fenetre=zeros(1,N);
        for k=1:round(N/2)
            fenetre(k)=2*k/N;
            fenetre(N-k)=-2*(N-(N+k)+1)/N;
        end
        Y=X.*fenetre;
end        
 if(nom=="hann")
        nu=1:length(X);
        fenetre=0.5-0.5*cos(2*pi*nu./N);
        Y=X.*fenetre;
 end
if(nom=="hamming")
        nu=1:length(X);
        fenetre=0.54-0.46*cos(2*pi*nu./N);
        Y=X.*fenetre;
end
 if(nom=="blackman")
         nu=1:length(X);
         fenetre=0.42-0.5*cos(2*pi*nu./N)+0.08*cos(4*pi*nu./N);
         Y=X.*fenetre;
end
end

     