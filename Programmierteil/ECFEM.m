function [x,A] = ECFEM(c4n,n4e,n4Db,n4Nb,ed4Nb,area4e,m4e,area4ed,mp4ed,lambda,mu,f,g,Mw)
% ECFEM assembles the stiffness matrix A and calculates the solution
% vector x according to [Alberty et al.]

n = size(c4n,1); m = size(n4e,1); d = size(c4n,2);
A = zeros(d*(d+1),d*(d+1),m);
% Assemble the matrix C
C = zeros(d*(d+1)/2,d*(d+1)/2);
C(1:d,1:d) = lambda*ones(d,d) + 2*mu*eye(d);
C((d+1):end,(d+1):end) = mu*eye(d*(d+1)/2-d);
R = zeros(d*(d+1)/2, d*(d+1));
% A loop over the triangles follows
for j = 1 : m
    grads = [ones(1,d+1);c4n(n4e(j,:),:)']\[zeros(1,d);eye(d)];
    % Arrange matrix R
    if d == 2
        R([1,3],[1,3,5]) = grads';
        R([3,2],[2,4,6]) = grads';
    elseif d == 3
        R([1,4,5],1:3:10) = grads';
        R([4,2,6],2:3:11) = grads';
        R([5,6,3],3:3:12) = grads';
    end
    % calculate A
    A(:,:,j) = area4e(j)*R'*C*R;
end
% determine the RHS with the mid-point rule
b = area4e.*f(m4e)/(d+1);

% convert the indexing from triangles to nodes
% insert d indices representing the directional basis vectors in a node
n4e_expanded = repelem(n4e.*d,1,d)+repmat(cumsum(ones(d,m))',1,d+1)-d;
% upsize that meshgrid a little
K = n4e_expanded(:,cumsum(ones(d*(d+1),d*(d+1)))')';
J = n4e_expanded(:,cumsum(ones(d*(d+1),d*(d+1))))';
A = sparse(J(:),K(:),A(:),n*d,n*d);

% expand this to match the indexing of the nodal basis
b = repmat(b,1,d+1);
b = accumarray(n4e_expanded(:),b(:),[d*n 1]);

% deal with the Neumann boundary
l = size(n4Nb,1);
if size(ed4Nb,1) == 0
    c = zeros(0,d);
else
    c = area4ed(ed4Nb).*g(mp4ed(ed4Nb,:));
end

% insert d indices representing the directional basis vectors in a node
n4Nb_expanded = repelem(n4Nb.*d,1,d)+repmat(cumsum(ones(l,d)')',1,d)-d;
% expand this to match the indexing of the nodal basis
c = repmat(c,1,d);
c = accumarray(n4Nb_expanded(:),c(:),[d*n 1]);

% add the Neumann boundary terms to the RHS vector
b = b + c;

% now to the Dirichlet conditions
un4Db = reshape(unique(n4Db),[],1);
n_Db = size(un4Db,1);
[w,M] = Mw(c4n(un4Db,:));
J = repelem((1:d*n_Db)',1,d);
K = repelem(d*un4Db,d,d)+repmat(cumsum(ones(d,1))',d*n_Db,1)-d;
B = sparse(J,K,M,d*n_Db,d*n);

mask = find(sum(abs(B),2));
A = [A, B(mask,:)'; B(mask,:),sparse(length(mask),length(mask))];
b = [b; w(mask,:)];
x = A\b;
end
