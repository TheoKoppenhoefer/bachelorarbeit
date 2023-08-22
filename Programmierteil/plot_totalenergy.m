function plot_totalenergy(dof4lvl,energy4lvl,varargin)
% plot_totalenergy plots the total energy for each iteration

% handle the input
p = inputParser;
default_fig = figure;
default_exportPlt = false;
default_exportPath = '../plots/efficiency.eps';
default_displayName = '';
addParameter(p,'fig',default_fig);
addParameter(p,'exportPlt',default_exportPlt);
addParameter(p,'exportPath',default_exportPath);
addParameter(p,'displayName',default_displayName);

parse(p,varargin{:});

fig = p.Results.fig;
exportPlt = p.Results.exportPlt;
exportPath = p.Results.exportPath;
displayName = p.Results.displayName;

if fig ~= default_fig
    close(default_fig);
end

figure(fig);
semilogx(dof4lvl,sqrt(energy4lvl),'-x','DisplayName',displayName);
xlabel('Freiheitsgrade, dn');
ylabel('Energie, a(u,u)/2');
hold all;

if size(displayName,2) ~= 0
    lgd = legend;
    lgd.Location = 'southeast';
end

if exportPlt
    title('');
    f = gcf;
    exportgraphics(f,exportPath);
end
title('Energie');
end