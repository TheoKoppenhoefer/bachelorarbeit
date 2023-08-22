function fig = plot_localenergy(c4n,n4e,avshearenergy4n,alpha)
% plot_localenergy gives a plot of the local shear energy density

if nargin == 3
    alpha = 1;
end
d = size(c4n,2);
fig = figure;
colormap jet;
title('Scherenergiedichte');
xlabel('x_1');
ylabel('x_2');
if d == 2
    zlabel('Durchschnittliche Scherenergiedichte');
    X = c4n(:,1); Y = c4n(:,2); Z = avshearenergy4n;
    plt = patch(X(n4e)',Y(n4e)',Z(n4e)',Z(n4e)','lineStyle','none','FaceAlpha',alpha);
    plt.Parent.DataAspectRatio([1,2]) = 1;
    % shading interp;
elseif d == 3
    zlabel('x_3');
    avshearenergy4e = sum(avshearenergy4n(n4e),2)/(d+1);
    tetramesh(n4e,c4n,avshearenergy4e,'FaceAlpha',0.05,'LineStyle','none');
    axis equal;
end
c = colorbar;
c.Label.String = 'Scherenergiedichte';
hold all
end