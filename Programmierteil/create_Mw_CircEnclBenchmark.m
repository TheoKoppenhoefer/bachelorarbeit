function [w,M] = create_Mw_CircEnclBenchmark(u,x)
% create_Mw_CircEnclBenchmark generates the matrix M and the vector w for
% gliding boundary conditions for the circular enclosure benchmark

M = repmat(eye(2),size(x,1),1);
% deal with lower edge
nodes = x(:,1) > 25 & x(:,2) == 0;
M(repelem(nodes,2,2)) = repmat([0,0;0,1],sum(nodes),1);
% deal with left edge
nodes = x(:,1) == 0 & x(:,2) > 25;
M(repelem(nodes,2,2)) = repmat([1,0;0,0],sum(nodes),1);
w = reshape(u(x)',[],1);
end
