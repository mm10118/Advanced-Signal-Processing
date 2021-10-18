%% Assignment 5: MLE For the frequency of a Signal
clear all;
%%
% plot of the periodograms
freq = [0.001:0.005:0.5];
p = zeros(1,100);
mle = zeros(1,100);
N = 10;
freq1 = [0.05, 0.1,0.2,0.3,0.4,0.45];
x = zeros(1,10);
y = 0;

figure(1)
for i = 1:length(freq1)
    for j = 1:length(freq)
        for n = 1:N
            x(n) = cos(2*pi*(n-1)*freq1(i)).*(cos((2.*pi.*freq(j).*(n-1)))+1i*sin((2.*pi.*freq(j).*(n-1))));
            y = x(n) + y;
        end
        p(j) = (1/10).*((abs(y)).^2);
        y = 0;
    end
    subplot(2,3,i)
    plot(freq,p)
    hold on
    plot([freq1(i) freq1(i)],[0 4],'--','LineWidth',1)
    title(['Periodogram for f_0=',num2str(freq1(i))],'FontSize',14)
    xlabel('Frequency f','FontSize',14)
    ylabel('Magnitude','FontSize',14)
    xlim([0,0.5])
    
end
legend('Estimate','Theoretical value','FontSize',12)

% plot of the MLE estimate

for i = 1:length(freq)
    for j = 1:length(freq)
        for n = 1:N
            x(n) = cos(2*pi*(n-1)*freq(i)).*(cos((2.*pi.*freq(j).*(n-1)))+1i*sin((2.*pi.*freq(j).*(n-1))));
            y = x(n) + y;
        end
        %y = sum(x);
        p(j) = (1/10).*((abs(y)).^2);
        y = 0;
    end
    [M,I]=max(p);
    mle(i) = I;
    
end

mle = mle/200;
figure(2)
plot(freq, freq,'LineWidth',1.5)
hold on
plot(freq,mle,'LineWidth',1.5)
legend('Original f_0','MLE estimate','FontSize',12)
title('Real and estimated f_0','FontSize',12)
xlabel('f_0','FontSize',12)
% add y label

for i = 1:length(freq)
    err(i) = mean((mle(i) - freq(i)).^2);
    
end

figure(3)
plot(freq,err,'LineWidth',1)
title('MSE','FontSize',15)
xlabel('f_0','FontSize',15)
ylabel('Magnitude','FontSize',15)

