function plot_convergencerate(dof4lvl,eta4lvl,displayName,fig)
% plot_convergencerate plots the convergence rate for each iteration

etaquot4lvl = eta4lvl(2:end)./eta4lvl(1:(end-1));
dofquot4lvl = dof4lvl(2:end)./dof4lvl(1:(end-1));
convergencerate = -log(etaquot4lvl)./log(dofquot4lvl);

figure(fig);
semilogx(dof4lvl(2:end),convergencerate,'-x','DisplayName',displayName);
hold all;
lineobj = yline(0.5,'-','\alpha=1/2');
lineobj.Annotation.LegendInformation.IconDisplayStyle = 'off';
title('Konvergenzrate')
xlabel('DOF, d\cdot n');
ylabel('Konvergenzrate, \alpha');
legend;
end