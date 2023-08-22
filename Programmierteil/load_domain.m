function [c4n,n4e,n4Db,n4Nb] = load_domain(domainName)
% load_domain loads a domain
% Set the source to Domains/Box3D/, Domains/Box2D/, Domains/LShapeDirichlet/,
% Domains/LShapeNeumann/, Domains/CooksMembrane, /Domains/SquareDirichlet and much more

sourcepath = ['Domains/',domainName,'/'];
% load the data from the source path
c4n = load([sourcepath,'c4n.dat']);
n4e = load([sourcepath,'n4e.dat']);
n4Db = load([sourcepath,'n4Db.dat']);
d = size(c4n,2);
if isfile([sourcepath,'n4Nb.dat'])
    n4Nb = load([sourcepath,'n4Nb.dat']);
else
    n4Nb = zeros(0,d);
end
end