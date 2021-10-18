%% Assignment 1: Exercise 2.1 and 2.2
% First random process
function v=rp1(M,N);
a=0.02;
b=5;
N = 100;
M = 100;
Mc=ones(M,1)*b*sin((1:N)*pi/N);
Ac=a*ones(M,1)*[1:N];
v=(rand(M,N)-0.5).*Mc+Ac;

m = mean(v,2); % time averages of mean
s = std(v,[],2); % time averages of standard deviation

temp = [1:1:100]; % time vector
% Ensemble averages
EnsAvg = mean(v);
EnsStd = std(v);
y1 = 0.02*temp; % theoretical value of the mean
y2 = (5/(12^(1/2)))*sin (temp*pi/N); % theoretical value of the standard deviation
figure(1)
subplot(1,2,1)
scatter(temp, EnsAvg, 5)
hold on
plot(temp, y1, 'LineWidth', 1.5)
title('Ensemble mean of process 1','FontSize',14)
xlabel('n','FontSize',14)
ylabel('Ensemble mean','FontSize',14)
legend('random process','theoretical mean','FontSize',12)

subplot(1,2,2)
scatter(temp, EnsStd, 5)
hold on;
plot(temp, y2, 'LineWidth', 1.5)
title('Ensemble standard deviation of process 1','FontSize',14)
xlabel('n','FontSize',14)
ylabel('Ensemble standard deviation','FontSize',14)
legend('random process','theoretical standard deviation','FontSize',12)

end

 
        