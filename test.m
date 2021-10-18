
% make the data zero mean
trial1 = detrend(xRRI1,0);
trial2 = detrend(xRRI2,0);
trial3 = detrend(xRRI3,0);

% autocorrelation functions
acorr1 = xcorr(trial1, 'unbiased');
acorr2 = xcorr(trial2, 'unbiased');
acorr3 = xcorr(trial3, 'unbiased');

% time vectors to plot the autocorrelation functions against
temp1 = -995:1:995;
temp2 = -969:1:969;
temp3 = -897:1:897;

% plots
figure(1)
plot(temp1, acorr1)

figure(2)
plot(temp2, acorr2)

figure(3)
plot(temp3, acorr3)