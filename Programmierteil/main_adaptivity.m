function main_adaptivity
% main_adaptivity: No inputs required, runs the adaptivity benchmark on the
% L-shaped domain

% set parameters lambda and mu
mu = 1e7;
lambda = munu2lambda(mu,0.3);

refinement_methods = ["uniform","etaR","etaM"];
refinement_parameters = [0.7,0.7,0.7];

% maximal number of nodes before ending the main loop
% max_dofs = [1e4,1e4,3e3];
max_dofs = [1e5,5e5,3e3];

% points at which to start plotting the convergence rates
convRateStarts = [3,3,0];

% configure plots
normSigDiffPlt = figure;
% normUDiffPlt = figure;
% convergenceplt = figure;
efficiencyPlt = figure;
inefficiencyPlt = figure;
conditionplt = figure;

% main loop
for i = 1:size(refinement_methods,2)
    refinement_method = refinement_methods(i);
    refinement_parameter = refinement_parameters(i);
    max_dof = max_dofs(i);
    
    % Load the benchmark
    [c4n,n4e,n4Db,n4Nb,f,g,Mw,u,sig] = load_benchmark('LShapeBenchmark',lambda,mu);

    % plot_triangulation(c4n,n4e,n4Db,n4Nb);

    [c4n,n4e,n4Db,n4Nb,dof4lvl,etaM4lvl,etaR4lvl,energy4lvl,avshearenergy4n...
        ,u4n,etaR4e,normSigDiff4lvl,normUDiff4lvl,cond4lvl] ...
        = ECAFEM(c4n,n4e,n4Db,f,Mw,n4Nb,g,'u',u,'sig',sig,'max_dofs',max_dof,...
        'lambda',lambda,'mu',mu,...
        'refinement_method',refinement_method,'refinement_parameter',refinement_parameter,...
        'enclCircBenchmark',false,'pltLocalErrors',true);

    % now to the exciting part: the plots...

    displayName = strcat('Methode: ',refinement_method);
    plot_totalerror(dof4lvl,normSigDiff4lvl,...
        'errorType','sig','displayName',displayName,'fig',normSigDiffPlt,...
        'convRateStart',convRateStarts(i));
    % plot_totalerror(dof4lvl,normUDiff4lvl,...
    %     'errorType','u','displayName',displayName,'fig',normUDiffPlt);
    plot_condition(dof4lvl,cond4lvl,...
        'displayName',displayName,'fig',conditionplt);

%     if refinement_method ~= "etaM"
%         plot_convergencerate(dof4lvl,normUDiff4lvl,...
%             'displayName',displayName,'fig',convergenceplt);
%     end
    plot_efficiency(dof4lvl,normSigDiff4lvl,etaR4lvl,'displayName',displayName,...
        'fig',efficiencyPlt,'errorType','sig','legendLocation','southeast');
    inconsistMask = etaM4lvl>1e-50;
    inconsistMask(1:3) = 0;
    plot_efficiency(dof4lvl(inconsistMask),normSigDiff4lvl(inconsistMask),...
        etaM4lvl(inconsistMask),'displayName',displayName,...
        'fig',inefficiencyPlt,'estimatorType','etaM','errorType','sig',...
        'legendLocation','southeast');
end
end