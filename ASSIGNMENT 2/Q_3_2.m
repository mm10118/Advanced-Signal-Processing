
clear all
%%
load sunspot.dat


% for N = 5
auto1 = xcorr(sunspot(1:5,2),'unbiased')'; % ACF of the first 5 elements of the second column
temp1 = [-4:1:4]; % time vector to plot the ACF against
m1 = mean(auto1);
figure(1)
subplot(3,1,1)
plot(temp1,auto1);
hold on
plot(temp1,auto1-m1); % zero mean ACF
grid on
title('ACF for N = 5','FontSize',14)
xlabel('time lag','FontSize',14)
ylabel('ACF','FontSize',14)
legend('ACF','zero mean ACF','FontSize',10)



% for N = 20
auto2 = xcorr(sunspot(1:20,2),'unbiased')'; % ACF of the first 20 elements of the second column
temp2 = [-19:1:19]; % time vector to plot the ACF against
m2 = mean(auto2);
subplot(3,1,2)
plot(temp2,auto2);
hold on
plot(temp2,auto2-m2); % zero mean ACF
xlim([-19,19])
grid on
title('ACF for N = 20','FontSize',14)
xlabel('time lag','FontSize',14)
ylabel('ACF','FontSize',14)
legend('ACF','zero mean ACF','FontSize',10)

% for N = 250
auto3 = xcorr(sunspot(1:250,2),'unbiased')'; % ACF of the first 250 elements of the second column
temp3 = [-249:1:249]; % time vector to plot the ACF against
m3 = mean(auto3);
subplot(3,1,3)
plot(temp3,auto3);
hold on
plot(temp3,auto3-m3); % zero mean ACF
xlim([-249,249])
grid on
title('ACF for N = 250','FontSize',14)
xlabel('time lag','FontSize',14)
ylabel('ACF','FontSize',14)
legend('ACF','zero mean ACF','FontSize',10)


