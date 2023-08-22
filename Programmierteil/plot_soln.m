function plot_soln(c4n,u4n,varargin)
% plot_soln plots the solution u

[~,d] = size(c4n);

% handle the input
p = inputParser;
default_zOffset = 0;
default_fig = figure;
default_exportPlt = false;
default_exportPath = '../plots/Solution.eps';
% fig = plot_localenergy(c4n,n4e,avshearenergy4n,1);
addOptional(p,'zOffset',default_zOffset);
addParameter(p,'figure',default_fig);
addParameter(p,'exportPlt',default_exportPlt);
addParameter(p,'exportPath',default_exportPath);

parse(p,varargin{:});

zOffset = p.Results.zOffset;
exportPlt = p.Results.exportPlt;
exportPath = p.Results.exportPath;
fig = p.Results.figure;

if fig ~= default_fig
    close(default_fig);
end


figure(fig);
xlabel('x_1');
ylabel('x_2');
if d == 2
    view(0,90);
    quiver3(c4n(:,1),c4n(:,2),zOffset*ones(size(c4n,1),1),u4n(:,1),u4n(:,2),zeros(size(c4n,1),1),0.7,'black');
elseif d == 3
    X = c4n(:,1); Y = c4n(:,2); Z = c4n(:,3);
    quiver3(X,Y,Z,u4n(:,1),u4n(:,2),u4n(:,3),'black');
end

if exportPlt
    f = gcf;
    exportgraphics(f,exportPath);
end
title('Lösung u und Scherenergiedichte');
end