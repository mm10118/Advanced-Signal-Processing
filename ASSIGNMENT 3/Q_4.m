clear all;
%% 3.4.1
fs =  32768; % sampling frequency
temp = 0:1/fs:5.25-1/fs ; % x axis
% frequencies given
f1 = [1209 1336 1477];
f2 = [697 770 852 941];

seq = zeros(10,length(temp)/21);
empty = zeros(1,length(temp)/21); % empty space in between each digit

for i = 1:(length(temp)/21)
    for j = 1:length(f1)
        for z = 1:length(f1)
            seq(z + 3*(j-1),i)= sin( 2*pi*i*f1(z)/fs)+ sin( 2*pi*i*f2(j)/fs);
        end
    end
    seq(10,i) =  sin( 2*pi*f1(2)*i/fs)+ sin( 2*pi*f2(4)*i/fs);
end

% generate random number
num = zeros(8,1);
for i = 1:8
    num(i) = randi(10); % selects a random number from 1 to 10
end

y = [seq(10,:), empty, seq(2,:), empty, seq(10,:), empty, seq(num(1),:), empty, seq(num(2),:), empty, seq(num(3),:), empty, seq(num(4),:), empty, seq(num(5),:), empty, seq(num(6),:), empty, seq(num(7),:), empty, seq(num(8),:)];
figure(1)
plot(temp,y)
title("Telephone number sequence")
xlabel("Seconds")
ylabel('Magnitude')
zoom on
xlim([0,5.25-1/fs])

% Spectrogram of sequence y
% we use hanning filter to separate the numbers 
% there is no overlapping
figure(2)
spectrogram(y,hann(length(temp)/21),0,length(temp)/21,fs);
xlim([0.4,1.8])
title('Spectrogram of sequence y','FontSize',14)

% FFT segments for numbers 0,2,4,6
seq2 = zeros(11,8192);
n = linspace(0,0.25,0.25*fs)';
num = [0,1,2,3,4,5,6,7,8,9];
freq = [ 941 1336; 697 1209;697 1336;697 1477;770 1209;770 1336;770 1477;852 1209;852 1336;852 1477];
for i = 1:length(num)
     seq2(i,:) = sin(2*pi*n*freq(num(i)+1,1))+sin(2*pi*n*freq(num(i)+1,2));
end
for i = 1:length(num)
    figure(3)
    subplot(2,5,i)
    [s,f,t] = spectrogram(seq2(i,:),hann(8192),0,8192,fs);
    plot(f,abs(s));
    xlim([0, 2000])
    title(['FFT for number ', num2str(num(i))],'FontSize',14);
    xlabel('Frequency (Hz)','FontSize',14)
    ylabel('Magnitude','FontSize',14)
end

% Noise addition to the signal
var = (std(y))^2;
sigma = [0.07, 0.23, 2.3, 7.2] ;
snr = [20, 10, -10, -20]; % signal to noise ratio
for i = 1: length(snr)
    ny = awgn(y,snr(i));
    figure(4)
    subplot(2,4,i)
    plot(temp, ny)
    title(['Sequence, SNR ', num2str(snr(i))],'FontSize',14);
    xlabel('Seconds','FontSize',14)
    ylabel('Magnitude','FontSize',14)
    xlim([0,5.25])
    subplot(2,4,i+4)
    spectrogram(ny,hann(length(temp)/21),0,length(temp)/21,fs);
    xlim([0.4,1.8])
    title(['Spectrogram SNR =', num2str(snr(i))],'FontSize',14)
    % FFT of signal with noise
    figure(5)
    subplot(1,4,i)
    [s,f,t] = spectrogram(ny,hann(8192),0,8192,fs);
    plot(f,abs(s(:,7)));
    xlim([0, 2000])
    title(['FFT for SNR=', num2str(snr(i))],'FontSize',14);
    xlabel('Frequency (Hz)','FontSize',14)
    ylabel('Magnitude','FontSize',14)
end 


