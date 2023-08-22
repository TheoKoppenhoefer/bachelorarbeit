function y = f_Cook(x)
% supposed to be used with Cook's membrane
y = zeros(size(x));
y(x(:,1) == 48.0,2) = 1;
end
