function [w,M] = create_Mw_LShapeBenchmark(u,x)
% create_Mw_LShapeBenchmark generates the matrix M and the 
% vector w for the L-Shaped benchmark with edge points 
% given by x

M = zeros(2*size(x,1),2);
% deal with lower edge
nodes = vecnorm(x,Inf,2) >= 1;
M(repelem(nodes,2,2)) = repmat(eye(2),sum(nodes),1);
w = reshape(u(x)',[],1);
end
