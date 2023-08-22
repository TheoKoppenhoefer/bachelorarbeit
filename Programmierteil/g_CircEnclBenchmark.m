function y = g_CircEnclBenchmark(sig,x)
% function for the circular inclusion benchmark as described in
% [Carstensen et al., p.2913f.]
y = zeros(size(x));
nodes = x(:,1)==100;
y(nodes,:) = [sig(x(nodes,:))*[1;0;0;0],sig(x(nodes,:))*[0;1;0;0]];
nodes = x(:,2)==100;
y(nodes,:) = [sig(x(nodes,:))*[0;0;1;0],sig(x(nodes,:))*[0;0;0;1]];
end