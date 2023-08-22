function plot_initialConditions(c4n,n4e,n4Db,varargin)
% plot_initialConditions plots the initial conditions of a benchmark

[n_old,d] = size(c4n);

% handle the input
p = inputParser;
default_n4Nb = zeros(0,d);
default_f = @(x)zeros(size(x));
default_exportPlt = false;
default_refinement = 3;
default_exportPath = '../plots/inititalConditions.eps';
addOptional(p,'n4Nb',default_n4Nb);
addParameter(p,'g',default_f);
addParameter(p,'f',default_f);
addParameter(p,'u',default_f);
addParameter(p,'refinement',default_refinement);
addParameter(p,'exportPlt',default_exportPlt);
addParameter(p,'exportPath',default_exportPath);

parse(p,varargin{:});

n4Nb = p.Results.n4Nb;
f = p.Results.f;
g = p.Results.g;
u = p.Results.u;
exportPlt = p.Results.exportPlt;
exportPath = p.Results.exportPath;
refinement = p.Results.refinement;

fig = plot_triangulation(c4n,n4e,n4Db,n4Nb);
t4e = ones(size(n4e,1),1);

for i = 1:refinement
    mark4e = ones(size(n4e,1),1) == 1;
    [n4ed,ed4e,~,~,~] = SIDES(n4e,n4Db,n4Nb);
    if d == 2
        [c4n,n4e,n4Db,n4Nb] = BISECT2D(c4n,n4e,n4Db,n4Nb,n4ed,ed4e,mark4e);
    elseif d == 3
        [c4n,n4e,t4e,n4Db] = BISECT3D(c4n,n4e,t4e,mark4e);
    end
end
n = size(c4n,1);

figure(fig);
hold all
f4n = f(c4n);
u4n = u(c4n);
un4Db = unique(n4Db);
un4Nb = unique(n4Nb);
g4n = g(c4n(un4Nb,:));
if d == 2
    % plot soln vector u
    X = c4n(:,1); Y = c4n(:,2); 
    quiver3(X,Y,n_old*ones(n,1),f4n(:,1),f4n(:,2),zeros(n,1),0.6,'Color',[0.3,0.3,0.3],'DisplayName','f');
    hold all
    % plot dirichlet boundary
    m = size(un4Db,1);
    quiver3(c4n(un4Db,1),c4n(un4Db,2),n_old*ones(m,1),u4n(un4Db,1),u4n(un4Db,2),zeros(m,1),'Color',[0,0,0.6],'DisplayName','u_0');
    hold all
    % plot Neumann boundary
    m = size(un4Nb,1);
    if m ~= 0
        quiver3(c4n(un4Nb,1),c4n(un4Nb,2),n_old*ones(m,1),g4n(:,1),g4n(:,2),zeros(m,1),'Color',[0.6,0,0],'DisplayName','g');
        hold all
    end
elseif d == 3
    % plot the soln vector u
    X = c4n(:,1); Y = c4n(:,2); Z = c4n(:,3);
    quiver3(X,Y,Z,f4n(:,1),f4n(:,2),f4n(:,3));
end

if exportPlt
    title('');
    f = gcf;
    exportgraphics(f,exportPath);
end
title('Anfangsbedingungen');
end