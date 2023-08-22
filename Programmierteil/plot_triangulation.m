function fig = plot_triangulation(c4n,n4e,n4Db,varargin)
% plot_triangulation plots the currenct triangulation

[n,d] = size(c4n);
m = size(n4e,1);

% handle the input
p = inputParser;
default_fig = figure;
default_n4Nb = zeros(0,d);
default_exportPlt = false;
default_exportPath = '../plots/triangulation.eps';
addOptional(p,'n4Nb',default_n4Nb);
addParameter(p,'fig',default_fig);
addParameter(p,'exportPlt',default_exportPlt);
addParameter(p,'exportPath',default_exportPath);

parse(p,varargin{:});

n4Nb = p.Results.n4Nb;
fig = p.Results.fig;
exportPlt = p.Results.exportPlt;
exportPath = p.Results.exportPath;

if fig ~= default_fig
    close(default_fig);
end

figure(fig);

if d == 2
    % plot the current triangulation
    plt = trimesh(n4e,c4n(:,1),c4n(:,2),1:size(c4n,1),'EdgeColor',[0.7,0.7,0.7]);
    % plot the boundaries
    lDb = line(reshape(c4n(n4Db(:),1),[],d)',reshape(c4n(n4Db(:),2),[],d)',n*ones(size(n4Db')),'Color',[0,0,1]);
    lNb = line(reshape(c4n(n4Nb(:),1),[],d)',reshape(c4n(n4Nb(:),2),[],d)',n*ones(size(n4Nb')),'Color',[1,0,0]);
    if n <= 50
        % plot the node number
        text(c4n(:,1),c4n(:,2),n*ones(n,1),string(1:size(c4n,1)));
        text(mean(reshape(c4n(n4e(:),1),m,d+1),2),mean(reshape(c4n(n4e(:),2),m,d+1),2), ...
            n*ones(m,1),string(1:m));
    end
    plt.Parent.DataAspectRatio([1,2]) = 1;
    view(0,90)
    zlabel('node');
    if size(lDb,1)>0 && size(lNb,1)>0
        lgd = legend([lDb(1) lNb(1)],'Dirichlet Rand','Neumann Rand');
    elseif size(lDb,1) > 0
        lgd = legend(lDb(1),'Dirichlet Rand');
    elseif size(lNb,1) > 0
        lgd = legend(lNb(1),'Neumann Rand');
    end
    lgd.Color = 'none';
    lgd.EdgeColor = 'none';
elseif d == 3
    % plot the current triangulation
    tetramesh(n4e,c4n,'EdgeColor',[0.5,0.5,0.5],'FaceAlpha',0.1);
    % plot the boundaries
    % TODO: Fix this
    %trimesh(n4Db,reshape(c4n(n4Db(:),1),[],d)',reshape(c4n(n4Db(:),2),[],d)',reshape(c4n(n4Db(:),3),[],d)','Color',[0,0,0.5]);
    %trimesh(n4Db,reshape(c4n(n4Nb(:),1),[],d)',reshape(c4n(n4Nb(:),2),[],d)',reshape(c4n(n4Nb(:),3),[],d)','Color',[0.5,0,0]);
    if n <= 50
        % plot the node number
        text(c4n(:,1),c4n(:,2),c4n(:,3),string(1:size(c4n,1)));
        text(mean(reshape(c4n(n4e(:),1),m,d+1),2),mean(reshape(c4n(n4e(:),2),m,d+1),2), ...
            mean(reshape(c4n(n4e(:),3),m,d+1),2),string(1:m));
    end
    axis equal;
    zlabel('x_3');
end
xlabel('x_1');
ylabel('x_2');

if exportPlt
    title('');
    f = gcf;
    exportgraphics(f,exportPath);
end
title('Triangulierung');
end