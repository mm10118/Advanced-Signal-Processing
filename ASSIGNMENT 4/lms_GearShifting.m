function [y,err,w, gain_array] = lms_GearShifting(x,z,gain,order)

w = zeros(order,length(x)+1);
y = zeros(length(x),1);
err = zeros(length(x)+1,1);
p = zeros(order,length(x));
gain_array = zeros(length(x)+1,1);

for i = 1:length(x)
    for j = 1:order
        if ((i+1)>j)
            p(j,i) = x((i+1)-j);
        end 
    end
    y(i) = (w(:,i)')*p(:,i);
    err(i+1) = z(i)- y(i);
    gain_array(1) = gain;
    % change adaptive gain according to the error
    % if error is too big ==> decrease adaptive gain
    if(err(i+1) - err(i) > 0.12)
        gain_array(i+1) = 0.85*gain_array(i);
    end
    % if error is too small ==> increase adaptive gain
    if(err(i) - err(i+1) > 0.12)
        gain_array(i+1) = 1.15*gain_array(i);
    end
    % if no significant change in the error
    if(abs(err(i+1) - err(i)) <= 0.12)
        gain_array(i+1) = gain_array(i);
    end
    w(:,(i+1)) = w(:,i) + gain_array(i+1)*err(i+1)*p(:,i);
end