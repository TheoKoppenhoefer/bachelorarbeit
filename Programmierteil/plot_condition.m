function plot_condition(dof4lvl,cond4lvl,varargin)
% plot_condition plots condest(A) for each iteration

% handle the input
p = inputParser;
default_fig = figure;
default_displayName = '';
default_exportPlt = false;
default_exportPath = '../plots/inititalConditions.eps';
addOptional(p,'displayName',default_displayName);
addOptional(p,'fig',default_fig);
addParameter(p,'exportPlt',default_exportPlt);
addParameter(p,'exportPath',default_exportPath);

parse(p,varargin{:});

displayName = p.Results.displayName;
fig = p.Results.fig;
exportPlt = p.Results.exportPlt;
exportPath = p.Results.exportPath;

if fig ~= default_fig
    close(default_fig);
end

% error plot
figure(fig);
loglog(dof4lvl,cond4lvl,'-x','DisplayName',displayName);
hold all;
xlabel('Freiheitsgrade, dn');
ylabel('Konditionszahl, condest(A)');

if size(displayName,2) ~= 0
    lgd = legend;
    lgd.Location = 'southeast';
end

if exportPlt
    title('');
    f = gcf;
    exportgraphics(f,exportPath);
end
title('Kondition der Matrix A');
end