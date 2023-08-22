function main_squarePull
% main_squarePull: No input required, generates plots of the example in the
% introduction

% set material parameters
lambda = 1e7;
mu = 1e5;

refinement_methods = ["uniform","etaR"];

[c4n,n4e,n4Db,n4Nb,f,g,Mw,u,sig] = load_benchmark('SquarePull',lambda,mu);

plot_initialConditions(c4n,n4e,n4Db,n4Nb,'f',f,'g',g,'u',u);

for refinement_method = refinement_methods
    [c4n,n4e,n4Db,n4Nb,f,g,Mw,u,sig] = load_benchmark('SquarePull',lambda,mu);

    [c4n,n4e,n4Db,n4Nb,dof4lvl,etaM4lvl,etaR4lvl,energy4lvl,...
        avshearenergy4n,u4n,etaR4e,~,~,cond4lvl] ...
        = ECAFEM(c4n,n4e,n4Db,f,Mw,n4Nb,g,'max_dofs',4e2,...
        'refinement_method',refinement_method,'refinement_parameter',0.5,...
        'sig',sig,'u',u,'lambda',lambda,'mu',mu,'enclCircBenchmark',false);

    % now to the exciting part: the plot...
    plot_deformation(c4n,n4e,u4n,avshearenergy4n,2e4);
end
end
