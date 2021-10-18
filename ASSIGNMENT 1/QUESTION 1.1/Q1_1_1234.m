%% Assignment 1: Exercise 1.1.1, 1.1.2, 1.1.3 and 1.1.4
figure(1)
temp1 = [1:1:1000]; % create a vector of discrete time
vector = rand(1000,1); %vector of random numbers from 0 to 1
scatter(temp1, vector,5, 'b');
ylim([-1,2])
ylabel('x[n]','FontSize',14)
xlabel('n','FontSize',14)
title('Plot of the randomly generated vector x','FontSize',14)

% 1.1.1 and 1.1.2
M = mean(vector); % we calculate the sample mean of the random sample
S = std(vector);% we compute the sample standard deviation

% 1.1.3
temp = [0:1:9];
m1 = zeros(1,10);
s1 = zeros(1,10);



for i = 1:10 % for loop for the 10 realisations of a random process
    v = rand(1000,1);
    m1(i) = mean(v);
    s1(i) = std(v);
    
   
end
figure (2) % plot of the estimate of the mean
scatter(temp, m1, 25);
ylim([0,1])
hold on
y1 = 0.5; % theoretical mean
yline(y1,'m')
title('sample mean','FontSize',14)
ylabel('sample mean','FontSize',14)
xlabel('sample realizations','FontSize',14)
legend('estimated mean','theoretical mean','FontSize',14)

figure(3) % plot of the estimated standard deviation
y2 = 0.2887; % theoretical standard deviation
scatter(temp, s1, 25);
ylim([0,1])
hold on
yline(y2,'m')
title('sample standard deviation','FontSize',14)
ylabel('sample standard deviation','FontSize',14)
xlabel('sample realizations','FontSize',14)
legend('estimated standard deviation','theoretical standard deviation','FontSize',14)

% 1.1.4  
   
figure(4)   
[f, x] = hist(rand(10000, 1), 20); % Create histogram from a normal distribution.
pd1 = makedist('Uniform');                     
dx = diff(x(1:2));
bar(x, f / sum(f * dx),'HandleVisibility','off'); hold on
ylim([0,1.5])
xlim([-1,2])
x = -3:.01:3;
pdf1 = pdf(pd1,x); % theoretical pdf
plot(x,pdf1,'r','LineWidth',2);
grid on
title('Normalized histogram for bins = 10','FontSize',14)
xlabel('x','FontSize',14)
ylabel('P(x)','FontSize',14)
legend('theoretical PDF','FontSize',14)





