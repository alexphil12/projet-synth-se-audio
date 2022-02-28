
%PHILIPPON Alexandre et ALBERTELLI Benjamin, 2G1TD1TP1

% fonction annexe TP1

function spectro = Spectrogramme(signal)
    
    N = length(signal);
    spectro = (1/N)*(abs(fftshift(fft(signal))).^2);

end 