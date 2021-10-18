clear all
%% Assignment 2: Exercise 3.1
% limits of the y-axis of both distributions
a = -2.5;
c = 1.5;
d = -1.5;
b = 2.5;
% the two distributions
a1 = (b-a).*rand(100000, 1) + a;
a2 = (c-d).*rand(100000, 1) + d;

temp = [-2.5:1:2.5];
figure(1)
hold on
for i=1:100000

        if(a1(i)+a2(i)<1 && a2(i)-a1(i)<1 && abs(a2(i))<1)
            scatter(a1(i),a2(i),'*');
            
        end
    
end

xlabel('a1','FontSize',17)
ylabel('a2','FontSize',17)
title('Stable coefficients (a1,a2) for AR(2)','FontSize',17)

figure(2)
y1 = temp + 1;
y2 = 1 - temp;
y3 = -1;
plot(temp,y1,'b', 'LineWidth', 1.5)
hold on 
plot(temp, y2, 'b', 'LineWidth', 1.5)
hold on
yline(y3,'b', 'LineWidth', 1.5)
ylim([-1.5,1.5])
xlim([-2.5,2.5])
grid on
xlabel('a1','FontSize',17)
ylabel('a2','FontSize',17)
title('Stability triangle','FontSize',17)
% for i=1:100
%     for j=1:100
%         sys = tf(1,[-a2(j) -a1(i) 1]);
%         p = pole(sys);
%         if(abs(p)<1)
%             scatter(a1(i),a2(j));
%             hold on
%         end
%     end
% end
