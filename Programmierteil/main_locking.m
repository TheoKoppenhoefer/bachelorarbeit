function main_locking
% main_locking: No input required, runs the locking benchmark on the square
% domain

% maximal number of dofs before ending the main loop
max_dof = 5e5;

convRateStarts = [2,4,6];
nus = [0.2,0.49,0.499];

% configure the plots
normSigDiffPlt = figure;
% normUDiffPlt = figure;
% etaRPlt = figure;
energyPlt = figure;
% convergenceplt = figure;
efficiencyPlt = figure;
inefficiencyPlt = figure;
conditionPlt = figure;

for i = 1:size(nus,2)
    % set parameters lambda and mu
    nu = nus(i);
    mu = 1e7;
    lambda = munu2lambda(mu,nu);
    % mu = lambdanu2mu(lambda,nu);
    
    [c4n,n4e,n4Db,n4Nb,f,g,Mw,u,sig] = load_benchmark('SquareBenchmark',lambda,mu);

    % plot_triangulation(c4n,n4e,n4Db,n4Nb);

    [c4n,n4e,n4Db,n4Nb,dof4lvl,etaM4lvl,etaR4lvl,energy4lvl,avshearenergy4n,...
        u4n,etaR4e,normSigDiff4lvl,normUDiff4lvl,cond4lvl] ...
        = ECAFEM(c4n,n4e,n4Db,f,Mw,'sig',sig,'u',u,'max_dofs',max_dof,'lambda',lambda,...
        'mu',mu);
    
    % now to the exciting part: the plots...

    % plot_deformation(c4n,n4e,u4n,avshearenergy4n,0.1);
    % plot_localerror(c4n,n4e,etaR4e);
    % plot_localenergy(c4n,n4e,avshearenergy4n);
    plot_totalerror(dof4lvl,normSigDiff4lvl,'errorType','sig',...
        'displayName',strcat('\nu=',string(nu)),'fig',normSigDiffPlt,...
        'convRateStart',convRateStarts(i));
    % plot_totalerror(dof4lvl,normUDiff4lvl,'errorType','u',...
    %     'displayName',strcat('\nu=',string(nu)),'fig',normUDiffPlt);
    % plot_totalerror(dof4lvl,etaR4lvl,'errorType','etaR',...
    %     'displayName',strcat('\nu=',string(nu)),'fig',etaRPlt);

    % plot_triangulation(c4n,n4e,n4Db,n4Nb);
    % plot_convergencerate(dof4lvl,etaR4lvl,'\eta_R',15);
    % plot_convergencerate(dof4lvl,error4lvl,...
    %     strcat('\nu=',string(nu)),convergenceplt);
    plot_condition(dof4lvl,cond4lvl,'displayName',strcat('\nu=',string(nu)),...
        'fig',conditionPlt);
    plot_totalenergy(dof4lvl,energy4lvl,'displayName',strcat('\nu=',string(nu)),...
        'fig',energyPlt);
    plot_efficiency(dof4lvl,normSigDiff4lvl,etaR4lvl,'displayName',...
        strcat('\nu=',string(nu)),'fig',efficiencyPlt,'errorType','sig');
    plot_efficiency(dof4lvl(etaM4lvl>1e-50),normSigDiff4lvl(etaM4lvl>1e-50),...
        etaM4lvl(etaM4lvl>1e-50),'displayName',strcat('\nu=',string(nu)),...
        'fig',inefficiencyPlt,'estimatorType','etaM','errorType','sig');
end
end