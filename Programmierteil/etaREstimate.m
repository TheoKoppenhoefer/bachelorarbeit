function eta4e = etaREstimate(c4n,n4e,n4Nb,ed4Nb,ed4Db,e4ed,ed4e,...
                        area4e,h4e,mp4e,area4ed,h4ed,mp4ed,nl4ed,sig4e,f,g)
% etaREstimate calculates an estimation of \eta_{R,T} based on the mid-point
% rule
d = size(c4n,2);
m = size(n4e,1);
n = size(e4ed,1); % here n is the number of edges rather than nodes
R_E4ed = zeros(m,d+1,d);
for j = 1 : m
    signum = (-1).^(e4ed(ed4e(j,:),1)~=j);
    R_E4ed(j,:,:) = signum.*nl4ed(ed4e(j,:),:)*reshape(sig4e(j,:),d,d);
end

% deal with the Neumann boundary with the mid-point-rule
for j = 1:size(n4Nb,1)
    R_E4ed(e4ed(ed4Nb(j),1),ed4e(e4ed(ed4Nb(j),1),:) == ed4Nb(j),:) = 2*((nl4ed(ed4Nb(j),:)*...
                    reshape(sig4e(e4ed(ed4Nb(j),1),:),d,d)-...
                    g(mp4ed(ed4Nb(j),:))));
end

R_E4ed = accumarray([repmat(ed4e(:),d,1),repelem(cumsum(ones(d,1)),m*(d+1),1)],R_E4ed(:),[n d]);

eta4ed = h4ed.*area4ed.*sum(R_E4ed.^2,2);
% deal with the Dirichlet-boundary
eta4ed(ed4Db) = 0;
eta4e = sqrt(area4e.*h4e.^2.*sum(f(mp4e).^2,2)+0.5*sum(eta4ed(ed4e),2));
end