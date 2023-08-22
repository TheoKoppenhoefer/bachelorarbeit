function y = f_Shear(x)
% supposed to be used with one of the boxes
y = zeros(size(x));
y(x(:,2) == 1,2) = -x(x(:,2) == 1,1);
end