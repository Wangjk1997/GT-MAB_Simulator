function output = ellipse(a, b)
% Input:  center: 2 by 1 vecter
%         a: x axis
%         b: y axis
% x^2/(a^2) + y^2/(b^2) = 1
    accuracy = 120;
    output = zeros(2,accuracy + 1);
    
    for i = 0:1:accuracy
        x_tmp = a*cos(2*pi/accuracy * i);
        y_tmp = b*sin(2*pi/accuracy * i);
        output(1, i + 1) = x_tmp;
        output(2, i + 1) = y_tmp;
    end
end