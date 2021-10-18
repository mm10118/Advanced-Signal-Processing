clear all;
%%
x = randn(1, 1024);

% subdivide x in 8 equal parts
for i = 1:8
   v(:,i) = x(((i-1)*128 + 1):(i*128));
end
 
% normalized frequency vector
f = [0:1:(128-1)]/128;

% calculate the periodogram of each subpart
figure(1)
for i = 1:8
    P(:,i) = abs((fft(v(:,i),128)).^2/128);
    subplot(2,4,i)
    plot(f,P(:,i))
    title('Periodogram for section number ', i,'FontSize',14);
    xlabel('Normalized frequency f (Hz)','FontSize',14)
    ylabel('Magnitude','FontSize',14)
   
end

% calculate averaged periodogram
y = 1; % theoretical value of the PSD
avgP = mean(P,2);
figure(2)
plot(f,avgP);
hold on
yline(y, 'r--', 'LineWidth', 1.5) 
ylim([0,6])
title('Averaged periodogram','FontSize',14);
xlabel('Normalized frequency f (Hz)','FontSize',14)
ylabel('Magnitude','FontSize',14)
legend('Averaged Periodogram','Theoretical value of the PSD','FontSize',14)