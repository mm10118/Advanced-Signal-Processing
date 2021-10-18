%% Assignment 1: Exercise 1.3.2

function v=rp3(M,N)
num = [100,1000,10000];
for i = 1:3
    a=0.5;
    m=3;
    N = num(i);
    M = 100;
    v=(rand(M,N)-0.5)*m + a;

    y1 = 0.333; % theoretical pdf
    figure(4)
    bins = 30;


    subplot(1,3,i)
    [f, x] = hist(v, bins); % Create histogram from a normal distribution.
    bar(x, f / trapz(x, f)); 
    yline(y1,'r', 'LineWidth', 2)
    ylim([0,0.45])
    title(['PDF estimate for N = ', num2str(N)],'FontSize',14)
    xlabel('x','FontSize',14)
    ylabel('P(x)','FontSize',14)
    legend('estimated pdf','theoretical pdf','FontSize',12)
end
