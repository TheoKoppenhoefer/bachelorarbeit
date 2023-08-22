function plot_localerror(c4n,n4e,error4e,varargin)
% plot_localerror plots the local error of a solution

% handle the input
p = inputParser;
default_fig = figure;
default_errorType = 'u';
default_exportPlt = false;
default_exportPath = '../plots/localErrorU.eps';
addParameter(p,'errorType',default_errorType);
addParameter(p,'fig',default_fig);
addParameter(p,'exportPlt',default_exportPlt);
addParameter(p,'exportPath',default_exportPath);

parse(p,varargin{:});

errorType = p.Results.errorType;
fig = p.Results.fig;
exportPlt = p.Results.exportPlt;
exportPath = p.Results.exportPath;

if fig ~= default_fig
    close(default_fig);
end

[n,d] = size(c4n);
if d == 2

    % plot the error estimate
    figure(fig);
    X = c4n(:,1); Y = c4n(:,2); Z = repmat(error4e,1,d+1);
    patch(X(n4e)',Y(n4e)',Z',Z');
    view(0,90);
    xlabel('x_1');
    ylabel('x_2');
    axis equal;
    c = colorbar;
    switch errorType
        case 'u'
            c.Label.String = 'Fehler, ||u-u_h||';
            zlabel('Fehler, ||u-u_h||');
        case 'sig'
            c.Label.String = 'Fehler, ||\sigma-\sigma_h||';
            zlabel('Fehler, ||\sigma-\sigma_h||');
        case 'etaR'
            c.Label.String = 'Fehlerschätzer, \eta_{R,T}';
            zlabel('Fehler, \eta_{R,T}');
        case 'etaM'
            c.Label.String = 'Fehlerschätzer, |\eta_{R,T}';
            zlabel('Fehler, \eta_{M,T}');
    end
end

if exportPlt
    f = gcf;
    exportgraphics(f,exportPath);
end
switch errorType
    case 'u'
        title(strcat('Lokaler Fehler bei d·n=',string(n*d)));
    case 'sig'
        title(strcat('Lokaler Fehler bei d·n=',string(n*d)));
    case 'etaR'
        title(strcat('Lokaler Fehlerschätzer bei d·n=',string(n*d)));
    case 'etaM'
        title(strcat('Lokaler Fehlerschätzer bei d·n=',string(n*d)));
end
end