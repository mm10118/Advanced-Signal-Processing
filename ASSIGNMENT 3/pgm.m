% Function to calculate periodograms
function [P,f] = pgm(x,N)
    % frequency vector
    f = (0:1:(N-1))/N;
    %calculate periodogram
    P = abs((fft(x,N)).^2/N);
end





