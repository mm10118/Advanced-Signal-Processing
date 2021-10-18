
clear all

%% trial 1
load RRI-DATA.mat
xRRI1 = detrend(xRRI1);
xRRI2 = detrend(xRRI2);
xRRI3 = detrend(xRRI3);
% optimum model order
figure(1)
subplot(2,3,1)
[ar,nvar,rc] = aryule(xRRI1,10);
hold on
stem(-rc,'LineWidth',1.2)
hold on
yline(1.96/sqrt(996),'--r','LineWidth',1.2);
yline(-1.96/sqrt(996),'--r','LineWidth',1.2);
hold off
title('PAC for RRI1', 'FontSize', 17)
xlabel('Correlation lag','FontSize', 17)
ylabel('Correlation', 'FontSize', 17)
legend('Optimum','Threshold', 'FontSize', 14)
xlim([0,11]);


% MDL, AIC and AICc
N = 996;
avgrc = 0;
for p = 1:10
    
    [ar,err,rc] = aryule(xRRI1,p);
    
    MDL(p) = log(err) + (((p*log(N)))/N);
    AIC(p) = log(err) + 2*p/N;
    AICc(p) = AIC(p) + (2*p*(p+1))/(N-p-1);
    
    avgrc = avgrc - rc(p);
end


subplot(2,3,4)
plot(MDL,'LineWidth',1.2);
hold on
plot(AIC,'LineWidth',1.2);
hold on
plot(AICc,'LineWidth',1.2);
legend('MDL','AIC','AICc', 'FontSize', 14)
title('MDL, AIC and AICc for RRI1','FontSize', 17)
xlabel('model order p', 'FontSize', 17)
ylabel('magnitude', 'FontSize', 17)
xlim([0,10])

%% trial 2
% optimum model order 
m = mean(xRRI2);
s = std(xRRI2);


subplot(2,3,2)

[ar,nvar,rc] = aryule(xRRI2,10);
hold on
stem(-rc,'LineWidth',1.2)
hold on
yline(1.96/sqrt(970),'--r','LineWidth',1.2);
yline(-1.96/sqrt(970),'--r','LineWidth',1.2);
hold off
title('PAC for RRI2', 'FontSize', 17)
xlabel('Correlation lag', 'FontSize', 17)
ylabel('Correlation', 'FontSize', 17)
legend('Optimum','Threshold', 'FontSize', 14)
xlim([0,11]);


% MDL, AIC and AICc
N = 970;
avgrc = 0;
for p = 1:10
    
    [ar,err,rc] = aryule(xRRI2,p);
    
    MDL(p) = log(err) + (((p*log(N)))/N);
    AIC(p) = log(err) + 2*p/N;
    AICc(p) = AIC(p) + (2*p*(p+1))/(N-p-1);
    
    avgrc = avgrc - rc(p);
end


subplot(2,3,5)
plot(MDL,'LineWidth',1.2);
hold on
plot(AIC,'LineWidth',1.2);
hold on
plot(AICc,'LineWidth',1.2);
legend('MDL','AIC','AICc', 'FontSize', 14)
title('MDL, AIC and AICc for RRI2', 'FontSize', 17)
xlabel('model order p', 'FontSize', 17)
ylabel('magnitude', 'FontSize', 17)
xlim([0,10])

%% trial 3
% optimum model order 

m = mean(xRRI3);
s = std(xRRI3);


subplot(2,3,3)
[ar,nvar,rc] = aryule(xRRI3,10);
hold on
stem(-rc,'LineWidth',1.2)
hold on
yline(1.96/sqrt(898),'--r','LineWidth',1.2);
yline(-1.96/sqrt(898),'--r','LineWidth',1.2);
hold off
title('PAC RRI3', 'FontSize', 17)
xlabel('Correlation lag', 'FontSize', 17)
ylabel('Correlation', 'FontSize', 17)
legend('Optimum','Threshold', 'FontSize', 14)
xlim([0,11]);


% MDL, AIC and AICc
N = 898;
avgrc = 0;
for p = 1:10
    
    [ar,err,rc] = aryule(xRRI3,p);
    
    MDL(p) = log(err) + (((p*log(N)))/N);
    AIC(p) = log(err) + 2*p/N;
    AICc(p) = AIC(p) + (2*p*(p+1))/(N-p-1);
    
    avgrc = avgrc + rc(p);
end
subplot(2,3,6)
plot(MDL,'LineWidth',1.2);
hold on
plot(AIC,'LineWidth',1.2);
hold on
plot(AICc,'LineWidth',1.2);
legend('MDL','AIC','AICc', 'FontSize', 14)
title('MDL, AIC and AICc for RRI3','FontSize', 17)
xlabel('model order p', 'FontSize', 17)
ylabel('magnitude', 'FontSize', 17)
xlim([0,10])