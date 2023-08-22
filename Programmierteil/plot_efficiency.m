function plot_efficiency(dof4lvl,error4lvl,eta4lvl,varargin)
% plot_efficiency plots the efficiency index of the error estimators eta_R
% and eta_M

% handle the input
p = inputParser;
default_fig = figure;
default_exportPlt = false;
default_exportPath = '../plots/efficiency.eps';
default_estimatorType = 'etaR';
default_errorType = 'u';
default_displayName = '';
default_legendLocation = 'northeast';
addParameter(p,'fig',default_fig);
addParameter(p,'exportPlt',default_exportPlt);
addParameter(p,'exportPath',default_exportPath);
addParameter(p,'estimatorType',default_estimatorType);
addParameter(p,'errorType',default_errorType);
addParameter(p,'displayName',default_displayName);
addParameter(p,'legendLocation',default_legendLocation);

parse(p,varargin{:});

fig = p.Results.fig;
exportPlt = p.Results.exportPlt;
exportPath = p.Results.exportPath;
estimatorType = p.Results.estimatorType;
errorType = p.Results.errorType;
displayName = p.Results.displayName;
legendLocation = p.Results.legendLocation;

if fig ~= default_fig
    close(default_fig);
end

switch errorType
    case 'u'
        errorText = '||u-u_h||';
    case 'sig'
        errorText = '||\sigma-\sigma_h||';
end

figure(fig);
xlabel('Freiheitsgrade, dn');
switch estimatorType
    case 'etaR'
        semilogx(dof4lvl,eta4lvl./error4lvl,'-x','DisplayName',displayName);
        ylabel(['Fehlerschätzer / Fehler, \eta_R / ',errorText]);
    case 'etaM'
        loglog(dof4lvl,eta4lvl./error4lvl,'-x','DisplayName',displayName);
        ylabel(['Fehlerschätzer / Fehler, \eta_M / ',errorText]);
end
hold all;

if size(displayName,2) ~= 0
    lgd = legend;
    lgd.Location = legendLocation;
end

if exportPlt
    title('');
    f = gcf;
    exportgraphics(f,exportPath);
end

switch estimatorType
    case 'etaR'
        title('Effizienz Index des Schätzers');
    case 'etaM'
        title('Ineffizienz des Schätzers');
end
end