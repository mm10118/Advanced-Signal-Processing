clear all
%%
x = randn(1000,1); % 1000 sample WGN vector
v = randn(1000,1); % 1000 sample WGN vector
y = filter(ones(9,1),[1],x); % filter it using a moving avarage filter
c = xcorr(x, y,'unbiased');
temp = -999:1:999;
stem(temp,c);
axis([-20  20, -2 2])
ylabel('CCF','FontSize',14)
xlabel('\tau','FontSize',14)
title('plot of the cross correlation function for x and y','FontSize',14)