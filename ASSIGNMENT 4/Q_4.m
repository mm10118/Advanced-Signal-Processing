%% 4.4.1
clear all;
%%

n = randn(1000,1); % white noise

% AR model
a = [1 0.9 0.2];
x = filter(1,a,n);

% values we consider for the adaptive gain
gain = [0.01 0.02 0.05 0.1];


pred = zeros(length(x),1);
w = zeros(2,length(x)); 
err = zeros(length(x),1);

figure(1)
for i = 1:length(gain)
    for j = 3:length(x)
        pred(j) = (w(1,j)*x(j-1))+(w(2,j)*x(j-2));
        % error
        err(j) = x(j) - pred(j);
        % adaptation algorithm
        w(1,j+1) = w(1,j) + gain(i)*err(j)*x(j-1);
        w(2,j+1) = w(2,j) + gain(i)*err(j)*x(j-2);
    end
    subplot(1,4,i)
    plot(w(1,:),'LineWidth',1)
    hold on
    plot(w(2,:),'LineWidth',1)
    title(['weigths for \mu = ',num2str(gain(i))],'FontSize',15)
    xlabel('Steps','FontSize',15);
    ylabel('Coefficients','FontSize',15)
    legend('a_1','a_2','FontSize',12)
    ylim([-2 2]);
end
    