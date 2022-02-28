function sig=genere_triangle(f,T,fe)
t=0:1/fe:temps-1/fe;
sig_carree=sign(cos(2*pi*t*freq));
N=length(sig_carree);
sig=zeros(1,N);
a=0;
for k=1:N
    a=a+sig_carree(k);
    sig(k)=a;
end
return(sig);
end
