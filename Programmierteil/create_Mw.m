function [w,M] = create_Mw(u,x)
% create_Mw generates the matrix M and the vector w for pure Dirichlet-boundary
% with edge points given in x

d = size(x,2);
M = repmat(eye(d),size(x,1),1);
w = reshape(u(x)',[],1);
end
