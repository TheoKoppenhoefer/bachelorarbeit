function c4n = movecirclenodes(c4n,un4Db)
% movecirclenodes moves the nodes on the lower left edge of the circulare
% enclosure benchmark onto the circle

nodes = un4Db(c4n(un4Db,1) < 25 & c4n(un4Db,2) < 25);
[theta,~] = cart2pol(c4n(nodes,1),c4n(nodes,2));
[c4n(nodes,1),c4n(nodes,2)] = pol2cart(theta,25*ones(size(nodes)));
end