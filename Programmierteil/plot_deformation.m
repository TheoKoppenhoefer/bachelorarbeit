function plot_deformation(c4n,n4e,u4n,avshearenergy4n,varargin)
% plot_deformation plots a possible deformation of the solution u

[n,d] = size(c4n);

% handle the input
p = inputParser;
default_factor = 1;
default_exportPlt = false;
default_exportPath = '../plots/Deformation.eps';
default_alpha = 1;
addOptional(p,'factor',default_factor);
addOptional(p,'alpha',default_alpha);
addParameter(p,'exportPlt',default_exportPlt);
addParameter(p,'exportPath',default_exportPath);

parse(p,varargin{:});

alpha = p.Results.alpha;
factor = p.Results.factor;
exportPlt = p.Results.exportPlt;
exportPath = p.Results.exportPath;

figure;
if d == 2
    % plot a deformed grid with the shearenergy
    trisurf(n4e,c4n(:,1)+factor*u4n(:,1),c4n(:,2)+factor*u4n(:,2),zeros(n,1), ...
        avshearenergy4n,'facecolor','interp','FaceAlpha',alpha);
elseif d == 3
    avshearenergy4e = sum(avshearenergy4n(n4e),2)/(d+1);
    tetramesh(n4e,c4n+factor*u4n,avshearenergy4e,'FaceAlpha',0.05);
    zlabel('x_3');
end
xlabel('x_1');
ylabel('x_2');
axis equal;
colormap jet;
c = colorbar;
c.Label.String = 'Scherenergiedichte';
if d == 2; view(0,90); end


if exportPlt
    title('');
    f = gcf;
    exportgraphics(f,exportPath);
end
title('mögliche Verformung des Gitters');
end