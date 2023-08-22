function [n4s,s4e,e4s,s4Db,s4Nb] = SIDES(n4e,n4Db,n4Nb)
% This function was provided by Prof. Dr. J. Gedicke (Uni Bonn).
% The sole change is the implementation of Neumann boundaries

d = size(n4e,2)-1;
sides = n4e(:,fliplr(nchoosek(1:d+1,d)'));
sides = sort([reshape(sides',d,[]),n4Db',n4Nb'],1)';
[n4s, e4s1, s4e] = unique(sides,'rows','stable');
[~, perm] = unique(sides,'rows','first');
[~, perm] = sort(perm);
[~, e4s2] = unique(sides,'rows','last');
e4s2 = e4s2(perm);
e4s2(e4s2>(d+1)*size(n4e,1)) = 0;
e4s = ceil([e4s1,e4s2]/(d+1));
s4Db = s4e((d+1)*size(n4e,1)+(1:size(n4Db,1)));
s4Nb = s4e((d+1)*size(n4e,1)+size(n4Db,1)+(1:size(n4Nb,1)));
s4e = reshape(s4e(1:(d+1)*size(n4e,1)),d+1,size(n4e,1))';
end