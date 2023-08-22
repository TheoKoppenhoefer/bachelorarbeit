function mark4e = MARK(eta4e,theta)
% MARK was provided by Prof. Dr. J. Gedicke (Uni Bonn).

mark4e = false(size(eta4e,1),1);
[eta4e,indx] = sort(eta4e,'descend');
J = find(cumsum(eta4e) >= theta*sum(eta4e),1,'first');
mark4e(indx(1:J)) = true;
end