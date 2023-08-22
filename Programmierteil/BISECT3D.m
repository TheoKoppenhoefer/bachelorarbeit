function [c4n,n4e,t4e,n4Db] = BISECT3D(c4n,n4e,t4e,r4e)
% BISECT3D was provided by Prof. Dr. J. Gedicke (Uni Bonn)

m4n_old = sparse(size(c4n,1),size(c4n,1));
while true
    n = size(c4n,1);
    while true
        r4eOld = r4e;
        m4n = sparse(n4e(r4e,1),n4e(r4e,4),ones(nnz(r4e),1),n,n);
        m4n = m4n + m4n' + m4n_old;
        r4e(any([m4n(uint64(n4e(:,1)) + n*uint64(n4e(:,2)-1)),...
            m4n(uint64(n4e(:,1)) + n*uint64(n4e(:,3)-1)),...
            m4n(uint64(n4e(:,1)) + n*uint64(n4e(:,4)-1)),...
            m4n(uint64(n4e(:,2)) + n*uint64(n4e(:,3)-1)),...
            m4n(uint64(n4e(:,2)) + n*uint64(n4e(:,4)-1)),...
            m4n(uint64(n4e(:,3)) + n*uint64(n4e(:,4)-1))],2)) = true;
        if all(r4e==r4eOld); break; end
    end
    if nnz(r4e)==0; break; end
    m4n = triu(m4n - max(m4n(:))*m4n_old);
    [I,J] = find(m4n>0);
    m4n = sparse(I,J,n + (1:numel(I)),n,n);
    m4n = m4n + m4n' + m4n_old;
    m = full(m4n(uint64(n4e(r4e,1)) + n*uint64(n4e(r4e,4)-1)));
    c4n = [c4n; 1/2*(c4n(I,:)+c4n(J,:))]; 
    n4e = [n4e(~r4e,:); n4e(r4e,1),m,n4e(r4e,[2 3]);
        n4e(t4e==0 & r4e,4),m(t4e(r4e)==0,:),n4e(t4e==0 & r4e,[3 2]);
        n4e(t4e>0 & r4e,4),m(t4e(r4e)>0,:),n4e(t4e>0 & r4e,[2 3])];
    t4e = mod([t4e(~r4e)-1;t4e(r4e);t4e(t4e==0 & r4e);t4e(t4e>0 & r4e)]+1,3);
    m4n_old = [m4n,sparse(n,numel(I));sparse(numel(I),size(c4n,1))];
    r4e = false(size(n4e,1),1);
end
n4Db = sort([n4e(:,[1 2 3]);n4e(:,[1 2 4]);n4e(:,[2 3 4]);n4e(:,[3 1 4])],2);
[~,first] = unique(n4Db,'rows','first'); 
[~,second] = unique(n4Db,'rows','last');
n4Db = n4Db(first(first==second),:);
end
