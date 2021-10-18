clear all
%%

%load data
load RRI-DATA.mat
% make the data zero mean
data1 = detrend(xRRI1);
data2 = detrend(xRRI2);
data3 = detrend(xRRI3);

N1 = length(data1)/2;
N2 = length(data2)/2;
N3 = length(data3)/2;

% calculate standard periodogram
[P1,F1] = pgm(data1, N1);
[P2,F2] = pgm(data2, N2);
[P3,F3] = pgm(data3, N3);

figure(1)
subplot(1,3,1)
plot(F1, P1);
title('Standard Priodogram for Trial 1','FontSize',14)
xlim([0,0.2])
xlabel('Frequency f (Hz)','FontSize',14)
ylabel('Magnitude','FontSize',14)
subplot(1,3,2)
plot(F2, P2);
title('Standard Priodogram for Trial 2','FontSize',14)
xlim([0,0.2])
xlabel('Frequency f (Hz)','FontSize',14)
ylabel('Magnitude','FontSize',14)
subplot(1,3,3)
plot(F3, P3);
title('Standard Priodogram for Trial 3','FontSize',14)
xlim([0,0.2])
xlabel('Frequency f (Hz)','FontSize',14)
ylabel('Magnitude','FontSize',14)

% average priodograms

% subdivide x in 50 equal parts

winlen = [50, 100, 150];
figure(2)
subplot(1,3,1)
for i = 1:length(winlen)
    avg = zeros(1, winlen(i)+1);
    for j = 1:floor(N1/winlen(i))
        start = (j-1).*winlen(i)+1;
        stop = j.*winlen(i)+1;
        [avg1,F1] = pgm(detrend(data1(start:stop)),length(data1(start:stop)));
        avg = avg1 + avg;
    end
    f = 0:1/winlen(i):(((winlen(i))/2)-1)/winlen(i);
    avg = avg/floor(N1/winlen(i));
    plot(f, avg(1:winlen(i)/2),'LineWidth',1)
    xlim([0 0.2])
    title('PSD for averaged windows for T1', 'FontSize',15)
    xlabel('Frequency f (Hz)', 'FontSize',15)
    ylabel('Magnitude', 'FontSize',15)
    legend('Window of 50s','Window of 100s','Window of 150s', 'FontSize',12)
    hold on;
end


% trial 2

subplot(1,3,2)
for i = 1:length(winlen)
    avg = zeros(1, winlen(i)+1);
    for j = 1:floor(N2/winlen(i))
        start = (j-1).*winlen(i)+1;
        stop = j.*winlen(i)+1;
        [avg1,F1] = pgm(detrend(data2(start:stop)),length(data2(start:stop)));
        avg = avg1 + avg;
    end
    f = 0:1/winlen(i):(((winlen(i))/2)-1)/winlen(i);
    avg = avg/floor(N2/winlen(i));
    plot(f, avg(1:winlen(i)/2),'LineWidth',1)
    xlim([0 0.2])
    title('PSD for averaged windows for T2', 'FontSize',15)
    xlabel('Frequency f (Hz)', 'FontSize',15)
    ylabel('Magnitude', 'FontSize',15)
    legend('Window of 50s','Window of 100s','Window of 150s', 'FontSize',15)
    hold on;
end


% trial 3

subplot(1,3,3)
for i = 1:length(winlen)
    avg = zeros(1, winlen(i)+1);
    for j = 1:floor(N3/winlen(i))
        start = (j-1).*winlen(i)+1;
        stop = j.*winlen(i)+1;
        [avg1,F1] = pgm(detrend(data3(start:stop)),length(data3(start:stop)));
        avg = avg1 + avg;
    end
    f = 0:1/winlen(i):(((winlen(i))/2)-1)/winlen(i);
    avg = avg/floor(N3/winlen(i));
    plot(f, avg(1:winlen(i)/2),'LineWidth',1)
    xlim([0 0.2])
    title('PSD for averaged windows for T3', 'FontSize',15)
    xlabel('Frequency f (Hz)', 'FontSize',15)
    ylabel('Magnitude', 'FontSize',15)
    legend('Window of 50s','Window of 100s','Window of 150s', 'FontSize',15)
    hold on;
end




