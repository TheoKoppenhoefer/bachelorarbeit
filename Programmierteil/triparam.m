function [area4e,h4e,mp4e,area4ed,h4ed,mp4ed,nl4ed] = triparam(c4n,n4e,n4ed,n4Nb,ed4Nb)
% triparam returns various parameters for a given triangulation (like
% midpoints, area and diameter for a triangle and its sides)

d = size(c4n,2);
m = size(n4e,1);
n = size(n4ed,1); % here n is the number of edges rather than nodes

% calculate the midpoints of the sides
mp4e = [mean(reshape(c4n(n4e,1),[],d+1),2),...
       mean(reshape(c4n(n4e,2),[],d+1),2)];
if d == 3
    mp4e = [mp4e,mean(reshape(c4n(n4e,3),[],d+1),2)];
end

% calculate the midpoints of the edges
mp4ed = [mean(reshape(c4n(n4ed,1),[],d),2),...
       mean(reshape(c4n(n4ed,2),[],d),2)];
if d == 3
    mp4ed = [mp4ed,mean(reshape(c4n(n4ed,3),[],d),2)];
end

area4e = zeros(m,1);
h4e = zeros(m,1);
for j = 1:m
    % calculate the area of the element
    area4e(j) = abs(det([ones(1,d+1);c4n(n4e(j,:),:)'])/factorial(d));

    % calculate the maximum distance
    dist4e = c4n(n4e(j,nchoosek(1:d+1,2)'),:);
    dist4e = dist4e(1:2:end,:)-dist4e(2:2:end,:);
    % now calculate the norm of the rows
    dist4e = vecnorm(dist4e');
    h4e(j) = max(dist4e);
end

h4ed = zeros(n,1);
area4ed = zeros(n,1);
nl4ed = zeros(n,d);

if d == 2
    t = c4n(n4ed(:,2),:)-c4n(n4ed(:,1),:);
    area4ed = vecnorm(t,2,2);
    nl4ed = [t(:,2),-t(:,1)]./area4ed;
elseif d == 3
    nl = cross(c4n(n4ed(:,3),:)-c4n(n4ed(:,1),:), ...
        c4n(n4ed(:,2),:)-c4n(n4ed(:,1),:),2);
    area4ed = vecnorm(nl,2)/2;
    nl4ed = nl./area4ed;
end

for j = 1:n
    % calculate the maximum distance of the edge
    dist4ed = c4n(n4ed(j,nchoosek(1:d,2)'),:);
    dist4ed = dist4ed(1:2:end,:)-dist4ed(2:2:end,:);
    % now calculate the norm of the rows
    dist4ed = vecnorm(dist4ed');
    h4ed(j) = max(dist4ed);
end

% fix the orientation of the normals at the Neumann boundary
% TODO: check 3d case
if d == 2
    t = c4n(n4Nb(:,2),:)-c4n(n4Nb(:,1),:);
    nl4ed(ed4Nb,:) = [t(:,2),-t(:,1)]./area4ed(ed4Nb);
end
end
