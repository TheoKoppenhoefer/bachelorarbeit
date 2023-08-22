function main_cubeWhirl
% main_cubeWhirl: requires no input arguments, plots a 3D adaptation of the
% benchmark on the square domain with homogenous Dirichlet boundary.

lambda = 1e7;
mu = 1e5;

max_dof = 1e3;

[c4n,n4e,n4Db,n4Nb,f,g,Mw,u,sig] = load_benchmark('CubeWhirl',lambda,mu);

plot_initialConditions(c4n,n4e,n4Db,n4Nb,'f',f,'g',g,'u',u);

[c4n,n4e,n4Db,n4Nb,dof4lvl,etaM4lvl,etaR4lvl,energy4lvl,...
    avshearenergy4n,u4n,etaR4e,normSigDiff4lvl,normUDiff4lvl,cond4lvl] ...
    = ECAFEM(c4n,n4e,n4Db,f,Mw,n4Nb,g,'max_dofs',max_dof,...
    'refinement_method','etaR','refinement_parameter',0.5,...
    'sig',sig,'u',u,'lambda',lambda,'mu',mu,'enclCircBenchmark',false);

% now to the exciting part: the plots...
plot_deformation(c4n,n4e,u4n,avshearenergy4n,5e-2);
solutionplt = plot_localenergy(c4n,n4e,avshearenergy4n,0.5);
plot_soln(c4n,u4n,'figure',solutionplt);
end
