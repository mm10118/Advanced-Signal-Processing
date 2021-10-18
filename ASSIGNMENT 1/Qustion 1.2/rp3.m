 function v=rp3(M,N)
a=0.5;
m=3;
M = 100;
N = 100;
v=(rand(M,N)-0.5)*m + a;


m = mean(v,2);
s = std(v,[],2);

y1 = 0.5; %theoretical mean
y2 = 0.866; % theoretical standard deviation
 temp = [1:1:100];
 EnsAvg = mean(v);
 EnsStd = std(v);
 
figure(2)
subplot(1,2,1)
scatter(temp, EnsAvg, 5)
hold on;
yline(y1, 'r', 'LineWidth', 1.5)
title('Plot of the ensemble mean of process 3')
xlabel('n')
ylabel('Ensemble mean')
ylim([0,1.5]);
legend('random process','theoretical mean')

subplot(1,2,2)
scatter(temp, EnsStd, 5)
hold on;
yline(y2, 'r', 'LineWidth', 1.5)
title('Plot of the ensemble standard deviation of process 3')
xlabel('n')
ylabel('Ensemble standard deviation')
ylim([0,1.5])
legend('random process','theoretical standard deviation')

 end