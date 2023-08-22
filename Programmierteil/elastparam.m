function [eps4e,aveps4n,sig4e,avsig4n,avshearenergy4n] ...
    = elastparam(c4n,n4e,area4e,u4n,lambda,mu)
% elastparam calculates various parameters of elasticity for a given solution u,
% like the stress tensor or average shear energy density

d = size(c4n,2);
m = size(n4e,1);
n = size(c4n,1);
eps4e = zeros(m,d*d);
sig4e = zeros(m,d*d);
aveps4n = zeros(n,d*d);
avsig4n = zeros(n,d*d);
for j = 1 : m
    grads = [ones(1,d+1);c4n(n4e(j,:),:)']\[zeros(1,d);eye(d)];
    gradU = u4n(repelem(d*(n4e(j,:)-1),d,1)+repmat((1:d)',1,d+1))*grads;
    eps4e(j,:) = reshape((gradU+gradU')/2,1,d*d);
    sig4e(j,:) = reshape(lambda*trace(gradU)*eye(d)+2*mu*(gradU+gradU')/2,1,d*d);
    aveps4n(n4e(j,:),:) = aveps4n(n4e(j,:),:)+area4e(j)*ones(d+1,1)*eps4e(j,:);
    avsig4n(n4e(j,:),:) = avsig4n(n4e(j,:),:)+area4e(j)*ones(d+1,1)*sig4e(j,:);
end
areaomega4n = accumarray(n4e(:),repmat(area4e,d+1,1));
aveps4n = aveps4n./repmat(areaomega4n,1,d*d);
avsig4n = avsig4n./repmat(areaomega4n,1,d*d);
if d == 2
    avshearenergy4n = (mu/(24*(mu+lambda)^2)+1/(8*mu))*(avsig4n(:,1)+...
        avsig4n(:,4)).^2+1/(2*mu)*(avsig4n(:,2).^2-avsig4n(:,1).*avsig4n(:,4));
elseif d==3
    % calculate according to [Alberty et al.,p.252]
    avshearenergy4n = sum((avsig4n-sum(avsig4n(:,1:3),2).*[ones(n,3),zeros(n,6)]/3).^2,2)/(4*mu);
end
end