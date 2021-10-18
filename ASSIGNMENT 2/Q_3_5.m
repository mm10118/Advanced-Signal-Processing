clear all
%%
load sunspot.dat

temp = 0:1:287;
m = mean(sunspot(:,2));
var = std(sunspot(:,2));
data = (sunspot(:,2)-m)/var;
p = [1,2,10]; % model order
m = [1,2,5,10];

for i = 1:length(p)
    figure(i)
    for j = 1:length(m)
        sys = ar(data,p(i));
        yp = predict(sys,data,m(j));
        subplot(2,2,j)
        plot(1:288, data, 1:288, yp)
        legend('Real data','prediction','FontSize',9);
        title(['AR(', num2str(p(i)), ') & m = ', num2str(m(j))],'FontSize',14);
        xlabel('Sample number N','FontSize',14)
        ylabel('Magnitude','FontSize',14)
    end
end




