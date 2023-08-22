function y = generate_LShape_g(sig,x)
% generates the function g of the L shape example based on the stress
% tensor sigma
upper = x(:,2)>0; % in the upper half-plane
lower = ~upper; % in the lower half-plane
xupper = x(upper,:);
xlower = x(lower,:);
y = zeros(size(x));
y(upper,1) = sig(xupper)*[1;0;1;0];
y(upper,2) = sig(xupper)*[0;1;0;1];
y(lower,1) = sig(xlower)*[1;0;-1;0];
y(lower,2) = sig(xlower)*[0;1;0;-1];
y = y/sqrt(2);
end