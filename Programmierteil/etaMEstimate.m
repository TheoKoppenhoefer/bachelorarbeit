function eta4e = etaMEstimate(c4n,n4e,area4e,eps4e,aveps4n,sig4e,avsig4n)
% etaMEstimate calculates a local error estimator based on averaging, it is
% described in [Alberty et al.,p.253f.]
d = size(c4n,2);
m = size(n4e,1);
eta4e = zeros(m,1);
for j = 1 : m
    eta4e(j) = eta4e(j) + area4e(j)*norm(sig4e(j,:).*eps4e(j,:) ...
        + sum(avsig4n(n4e(j,:),:),1).*sum(aveps4n(n4e(j,:),:),1)/((d+1)*(d+1)) ...
        - sum(avsig4n(n4e(j,:),:),1).*eps4e(j,:)/(d+1) ...
        - sum(aveps4n(n4e(j,:),:),1).*sig4e(j,:)/(d+1))^2;
end
end