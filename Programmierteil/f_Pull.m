function y = f_Pull(x)
% supposed to be used with one of the boxes
y = zeros(size(x));
y(x(:,1) == 1.0,1) = 1;
end