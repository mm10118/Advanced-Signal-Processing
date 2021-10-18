clear all;
%%
x = randn(1,1024);
y = filter(1,[1,0.9],x); % filter the WGN signal
y = y(41:length(y)); % remove the first 40 values

% time vectors to plot the signal against
temp = 1:1:1024;
temp1 = 41:1:1024;

figure(1)
plot(temp1, y);
hold on
plot(temp,x);
xlim([0,1024])
xlabel('Time','FontSize',14)
ylabel('Magnitude','FontSize',14)
title('Comparison between filtered and unfiltered WGN','FontSize',14)
legend('Filtered WGN','original WGN','FontSize',14)

% theoretical value of the psd
[h,w]=freqz([1],[1 0.9],512); % frequency response
y1 = 3.01; %position of the cut off frequency
x1 = 0.405;

figure(2)
plot(w/(2*pi),abs(h).^2)
hold on
yline(y1, 'r--') 
hold on
xline(x1, 'r--')
title('Theoretical PSD','FontSize',14)
ylabel('Magnitude (db)','FontSize',14)
xlabel('Frequency f (Hz)','FontSize',14)
legend('Theoretical PSD','cut-off frequency position','FontSize',14)

% calculate periodogram using pgm.m

[P, f] = pgm(y,984);

figure(3)
plot(w/(2*pi),abs(h).^2, 'LineWidth', 1.5)
hold on
plot(f,P,'r')
xlim([0,0.5])
title('Periodogram and the theoretical PSD','FontSize',14)
xlabel('Frequency f (Hz)','FontSize',14)
ylabel('Magnitude (db)','FontSize',14)
legend('Theoretical PSD','Periodogram','FontSize',14)
zoom on

% calculate parameters
r = xcorr(y,'unbiased');
temp = -983:1:983;
% values of the autocorrelation for certain correlation lags
r0 = r(temp == 0);
r1 = r(temp == 1);

%calculate values of parameters 
a = -r1/r0;
sigma = r0 + (a*r1);

% calculate Model based PSD
[h1,w1]=freqz([sigma],[1 a],512);

% plots
figure(4)
plot(w1/(2*pi),abs(h1).^2, 'LineWidth', 1.5)
hold on
plot(f,P,'r')
xlim([0, 0.5])
xlabel('Frequency f (Hz)','FontSize',14)
ylabel('Magnitude (db)','FontSize',14)
legend('Model based PSD','Periodogram','FontSize',14)
title('Model based PSD and periodogram','FontSize',14)

figure(5)
plot(w1/(2*pi),abs(h1).^2);
hold on
plot(w/(2*pi),abs(h).^2);
xlabel('Frequency f (Hz)','FontSize',14)
ylabel('Magnitude (db)','FontSize',14)
legend('Model based PSD','Theoretical PSD','FontSize',14)
title('Model based and theoretical PSD','FontSize',14)