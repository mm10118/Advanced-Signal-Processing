%% Assignment 1: Exercise 3.3
% limits of the y-axis of both distributions
a = -0.5;
c = 1.5;
d = 0.5;
b = 0.5;
% the two distributions
v1 = (b-a).*rand(500, 1) + a;
v2 = (c-d).*rand(500, 1) + d;
% time vectors for each distribution
temp1 = [1:1:500];
temp2 = [501:1:1000];
figure(1)
scatter(temp1, v1, 6)
hold on
scatter(temp2, v2, 6)
title('separation of the distribution into two uniform distributions','FontSize',14)
xlabel('n','FontSize',14)
ylabel('x[n]','FontSize',14)
legend('distribution with zero mean','distribution with unitary mean','FontSize',12)