function [y,err,w] = lms(x,z,gain,order)

w = zeros(order,length(x));
y = zeros(length(x),1);
err = zeros(length(x),1);
p = zeros(order,length(x));

for i = 1:length(x)
    for j = 1:order
        if ((i+1)>j)
            p(j,i) = x((i+1)-j);
        end 
    end
    y(i) = (w(:,i)')*p(:,i);
    err(i) = z(i)- y(i);
    w(:,(i+1)) = w(:,i) + gain*err(i)*p(:,i);
end