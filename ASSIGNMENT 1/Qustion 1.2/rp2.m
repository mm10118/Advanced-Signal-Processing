function v=rp2(M,N)
 M = 100;
 N = 100;
 Ar=rand(M,1)*ones(1,N);
 Mr=rand(M,1)*ones(1,N);
 v=(rand(M,N)-0.5).*Mr+Ar;
 
 m = mean(v,2);
 s = std(v,[],2);

 temp = [1:1:100];
 EnsAvg = mean(v);
 EnsStd = std(v);
 y1 = 0.5;
 y2 = 0.3333;
 figure(2)
subplot(1,2,1)
scatter(temp, EnsAvg, 5)
hold on;
yline(y1,'r', 'LineWidth', 1.5)
title('Plot of the ensemble mean of process 2')
xlabel('n')
ylabel('Ensemble mean')
ylim([0,1]);
legend('random process','theoretical mean')

subplot(1,2,2)
scatter(temp, EnsStd, 5)
hold on;
yline(y2,'r', 'LineWidth', 1.5)
title('Plot of the ensemble standard deviation of process 2')
xlabel('n')
ylabel('Ensemble standard deviation')
ylim([0,1])
legend('random process','theoretical standard deviation')

 end