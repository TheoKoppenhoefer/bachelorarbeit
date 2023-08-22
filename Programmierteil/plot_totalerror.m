function plot_totalerror(dof4lvl,error4lvl,varargin)
% plot_totalerror plots the total error for each iteration

% handle the input
p = inputParser;
default_fig = figure;
default_errorType = 'u';
default_lineStyle = '-x';
default_exportPlt = false;
default_displayName = '';
default_exportPath = '../plots/errorU.eps';
default_convRateStart = 0;
addParameter(p,'errorType',default_errorType);
addParameter(p,'fig',default_fig);
addParameter(p,'lineStyle',default_lineStyle);
addParameter(p,'exportPlt',default_exportPlt);
addParameter(p,'exportPath',default_exportPath);
addParameter(p,'displayName',default_displayName);
addParameter(p,'convRateStart',default_convRateStart);

parse(p,varargin{:});

errorType = p.Results.errorType;
fig = p.Results.fig;
lineStyle = p.Results.lineStyle;
exportPlt = p.Results.exportPlt;
exportPath = p.Results.exportPath;
displayName = p.Results.displayName;
convRateStart = p.Results.convRateStart;

if fig ~= default_fig
    close(default_fig);
end

% error plot
figure(fig);
plt = loglog(dof4lvl,error4lvl,lineStyle,'DisplayName',displayName);
if size(displayName,2) ~= 0
    lgd = legend;
    lgd.Location = 'southwest';
end
hold all;
if convRateStart ~= 0 && convRateStart < size(dof4lvl,2)
    % average convergence rate
    convergenceRate = round(log(error4lvl(end)/error4lvl(convRateStart))...
        /log(dof4lvl(end)/dof4lvl(convRateStart)),2,"significant");
    line([dof4lvl(convRateStart);dof4lvl(end)],...
        [error4lvl(convRateStart);error4lvl(convRateStart)*dof4lvl(convRateStart)...
        ^(-convergenceRate)*(dof4lvl(end)-dof4lvl(convRateStart))^convergenceRate],...
        'DisplayName',strcat('Konvergenzrate=',string(convergenceRate)),'LineStyle','--',...
        'Color',plt.Color);
    hold all;
end
xlabel('Freiheitsgrade, dn');
switch errorType
    case 'u'
        ylabel('Fehler, ||u-u_h||');
    case 'sig'
        ylabel('Fehler, ||\sigma-\sigma_h||');
    case 'eps'
        ylabel('Fehler, ||\epsilon-\epsilon_h||');
    case 'etaR'
        ylabel('Fehler, \eta_R');
end

if exportPlt
    title('');
    f = gcf;
    exportgraphics(f,exportPath);
end
title('Fehler');
end