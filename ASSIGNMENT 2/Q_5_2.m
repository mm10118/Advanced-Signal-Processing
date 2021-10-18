clear all
%%
load RRI-DATA.mat
% make the data zero mean
trial1 = detrend(xRRI1,0);
trial2 = detrend(xRRI2,0);
trial3 = detrend(xRRI3,0);

s1 = std(trial1);
s2 = std(trial2);
s3 = std(trial3);

% autocorrelation functions
acorr1 = xcorr(trial1/s1, 'unbiased');
acorr2 = xcorr(trial2/s2, 'unbiased');
acorr3 = xcorr(trial3/s3, 'unbiased');

% time vectors to plot the autocorrelation functions against
temp1 = -995:1:995;
temp2 = -969:1:969;
temp3 = -897:1:897;

% plots
figure(1)
subplot(1,3,1)
plot(temp1, acorr1)
ylim([-1, 1])
title('ACF for RR1', 'FontSize', 14)
xlabel('Correlation lag', 'FontSize', 14)
ylabel('ACF', 'FontSize', 14)

subplot(1,3,2)
plot(temp2, acorr2)
ylim([-1, 1])
title('ACF for RR2', 'FontSize', 14)
xlabel('Correlation lag', 'FontSize', 14)
ylabel('ACF', 'FontSize', 14)

subplot(1,3,3)
plot(temp3, acorr3)
ylim([-1, 1])
title('ACF for RR3', 'FontSize', 14)
xlabel('Correlation lag', 'FontSize', 14)
ylabel('ACF', 'FontSize', 14)