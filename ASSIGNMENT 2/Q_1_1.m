clear all
%%
v = randn(1000,1); % 1000 sample WGN vector
autov = xcorr(v,'unbiased');
temp = -999:1:999;
plot(temp,autov);
axis([-999  999 -1.5 1.5])
ylabel('ACF','FontSize',14)
xlabel('\tau','FontSize',14)
title('Plot of the autocorrelation function of GWN for |\tau|< 50','FontSize',14)
zoom on
% 