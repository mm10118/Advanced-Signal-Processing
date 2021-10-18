clear all
%%
v = randn(1000,1); % 1000 sample WGN vector
y = filter(ones(9,1),[1],v); % filter it using a moving avarage filter
autoy = xcorr(y,'unbiased');
temp = -999:1:999;
stem(temp,autoy);
axis([-20  20, -5 13])
title('estimate of the ACF of a WGN signal filtered by a MA filter','FontSize',14)
ylabel('ACF','FontSize',14)
xlabel('\tau','FontSize',14)

