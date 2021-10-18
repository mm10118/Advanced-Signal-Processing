% inputs
x1 = randn(1,128);
x2 = randn(1,256);
x3 = randn(1,512);

N1 = 128;
N2 = 256;
N3 = 512;

[P1,f1] = pgm(x1 , N1);
[P2,f2] = pgm(x2 , N2);
[P3,f3] = pgm(x3 , N3);

%plot periodogram
y = 1;
figure(1)
subplot(1,3, 1)
plot(f1,P1)
hold on
yline(y, 'r--', 'LineWidth', 1.5) 
title(['Periodogram for N = ', num2str(N1)],'FontSize',14)
xlabel('Normalized Frequency f (Hz)','FontSize',14)
ylabel('Magnitude','FontSize',14)
legend('Periodogram','Theoretical PSD','FontSize',14)

subplot(1,3, 2)
plot(f2,P2)
hold on
yline(y, 'r--', 'LineWidth', 1.5) 
title(['Periodogram for N = ', num2str(N2)],'FontSize',14)
xlabel('Normalized Frequency f (Hz)','FontSize',14)
ylabel('Magnitude','FontSize',14)
legend('Periodogram','Theoretical PSD','FontSize',14)

subplot(1,3, 3)
plot(f3,P3)
hold on
yline(y, 'r--', 'LineWidth', 1.5) 
title(['Periodogram for N = ', num2str(N3)],'FontSize',14)
xlabel('Normalized Frequency f (Hz)','FontSize',14)
ylabel('Magnitude','FontSize',14)
legend('Periodogram','Theoretical PSD','FontSize',14)


% filtering the periodogram
b = 0.2*ones(5,1); % impulse response
filteredP1 = filter(b,1, P1);
figure(2)
subplot(1,3, 1)
plot(f1,P1)
hold on
plot(f1,filteredP1,'LineWidth', 1.5)
legend('Original periodogram','Filtered periodogram','FontSize',14)
title('Filtered periodogram for N = 128','FontSize',14)
xlabel('Normalized frequency f (Hz)','FontSize',14)
ylabel('Magnitude','FontSize',14)

filteredP2 = filter(b,1, P2);
subplot(1,3, 2)
plot(f2,P2)
hold on
plot(f2,filteredP2,'LineWidth', 1.5)
legend('Original periodogram','Filtered periodogram','FontSize',14)
title('Filtered periodogram for N = 256','FontSize',14)
xlabel('Normalized frequency f (Hz)','FontSize',14)
ylabel('Magnitude','FontSize',14)

filteredP3 = filter(b,1, P3);
subplot(1,3, 3)
plot(f3,P3)
hold on
plot(f3,filteredP3,'LineWidth', 1.5)
legend('Original periodogram','Filtered periodogram','FontSize',14)
title('Filtered periodogram for N = 512','FontSize',14)
xlabel('Normalized frequency f (Hz)','FontSize',14)
ylabel('Magnitude','FontSize',14)