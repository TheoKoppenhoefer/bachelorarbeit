function [c4n,n4e,n4Db,n4Nb,dof4lvl,etaM4lvl,etaR4lvl,energy4lvl,...
    avshearenergy4n,u4n,etaR4e,normSigDiff4lvl,normUDiff4lvl,cond4lvl] ...
    = ECAFEM(c4n,n4e,n4Db,f,Mw,varargin)
% ECAFEM Conformal adaptive finite element method for linear elasticity
%   The following arguments are required
%       c4n:    nxd-matrix specifying the coordinates of the nodes
%       n4e:    mx(d+1)-matrix specifying the nodes of an element
%       n4Db:   ?xd-matrix specifying the edge nodes on the Dirichlet
%               boundary
%       f:      function specifying the force in the domain
%       Mw:  [M,u_d], where u_d specifies the value on the Dirichlet
%               boundary
%   The following parameters are optional
%       n4Nb:   ?xd-matrix specifying the edge nodes on the Dirichlet
%               boundary
%       g:      function specifying the force on the Neumann boundary
%   The following parameters are given as name-value pairs
%       u:      the exact solution for u
%       sig:   the exact solution for sigma
%       lambda: lame-parameter
%       mu:     lame-parameter
%       max_dofs:          
%               integer specifying the maximum number of dofs
%       refinement_method:
%               takes values 'etaR','etaM' and 'uniform'
%       refinement_parameter:
%               number between 0 and 1
%       enclCircBenchmark: adjusts domain after refinement for the circular
%               enclosure benchmark
%       pltLocalErrors: plot the local errors for the adaptivity benchmark

d = size(c4n,2);

% handle the input
p = inputParser;
default_n4Nb = zeros(0,d);
default_g = @(x)zeros(size(x));
default_u = @(x)zeros(size(x));
default_sig = @(x)zeros(size(x,1),d*d);
default_lambda = 1;
default_mu = 1;
default_max_dofs = 1e3;
default_refinement_method = "uniform";
default_refinement_parameter = 0.5;
default_enclCircBenchmark = false;
default_pltLocalErrors = false;
addOptional(p,'n4Nb',default_n4Nb);
addOptional(p,'g',default_g);
addParameter(p,'u',default_u);
addParameter(p,'sig',default_sig);
addParameter(p,'lambda',default_lambda);
addParameter(p,'mu',default_mu);
addParameter(p,'max_dofs',default_max_dofs);
addParameter(p,'refinement_method',default_refinement_method);
addParameter(p,'refinement_parameter',default_refinement_parameter);
addParameter(p,'enclCircBenchmark',default_enclCircBenchmark);
addParameter(p,'pltLocalErrors',default_pltLocalErrors);
parse(p,varargin{:});

n4Nb = p.Results.n4Nb;
g = p.Results.g;
u = p.Results.u;
sig = p.Results.sig;
lambda = p.Results.lambda;
mu = p.Results.mu;
max_dofs = p.Results.max_dofs;
refinement_method = p.Results.refinement_method;
refinement_parameter = p.Results.refinement_parameter;
enclCircBenchmark = p.Results.enclCircBenchmark;
pltLocalErrors = p.Results.pltLocalErrors;

dof4lvl = []; etaM4lvl = []; etaR4lvl = []; energy4lvl = [];
normSigDiff4lvl = []; normUDiff4lvl = []; cond4lvl = [];
t4e = ones(size(n4e,1),1);

% main loop
while true
    % the following is for the enclosed circle benchmark
    if enclCircBenchmark; c4n = movecirclenodes(c4n,unique(n4Db)); end
    [n4ed,ed4e,e4ed,ed4Db,ed4Nb] = SIDES(n4e,n4Db,n4Nb);
    [area4e,h4e,mp4e,area4ed,h4ed,mp4ed,nl4ed] = triparam(c4n,n4e,n4ed,n4Nb,ed4Nb);
    n = size(c4n,1);
    [x,A] = ECFEM(c4n,n4e,n4Db,n4Nb,ed4Nb,area4e,mp4e,area4ed,mp4ed,lambda,mu,f,g,Mw);
    u4n = reshape(x(1:d*n),d,[])';
    [eps4e,aveps4n,sig4e,avsig4n,avshearenergy4n] ...
        = elastparam(c4n,n4e,area4e,x(1:d*n),lambda,mu);
    u4e = [mean(reshape(u4n(n4e,1),[],d+1),2),mean(reshape(u4n(n4e,2),[],d+1),2)];
    if d == 3; u4e = [u4e,mean(reshape(u4n(n4e,3),[],d+1),2)]; end
    normSigDiff4lvl(end+1) = sqrt(sum(area4e.*sum((sig(mp4e)-sig4e).^2,2),1));
    normUDiff4lvl(end+1) = sqrt(sum(area4e.*sum((u(mp4e)-u4e).^2,2),1));
    cond4lvl(end+1) = condest(A);
    dof = n*d;
    disp(dof);
    dof4lvl(end+1) = dof;
    energy4lvl(end+1) = x(1:d*n)'*A(1:d*n,1:d*n)*x(1:d*n)/2.;
    etaM4e = etaMEstimate(c4n,n4e,area4e,eps4e,aveps4n,sig4e,avsig4n);
    etaR4e = etaREstimate(c4n,n4e,n4Nb,ed4Nb,ed4Db,e4ed,ed4e,...
                        area4e,h4e,mp4e,area4ed,h4ed,mp4ed,nl4ed,sig4e,f,g);
    etaM4lvl(end+1) = norm(etaM4e);
    etaR4lvl(end+1) = norm(etaR4e);
    if dof4lvl(end) >= max_dofs || anynan(u4n); break; end
    switch refinement_method
        case 'etaM'
            mark4e = MARK(etaM4e.^2,refinement_parameter);
        case 'etaR'
            mark4e = MARK(etaR4e.^2,refinement_parameter);
        case 'uniform'
            mark4e = ones(size(n4e,1),1) == 1;
    end
    if pltLocalErrors && (dof4lvl(end) == 94 || dof4lvl(end) == 1610 ...
            || dof4lvl(end) == 286)
        % consider 2016 or 1610 or 1492
        % plot_localerror(c4n,n4e,area4e.*sum((u(mp4e)-u4e).^2,2),'errorType','u');
        plot_localerror(c4n,n4e,area4e.*sum((sig(mp4e)-sig4e).^2,2),'errorType','sig');
        plot_localerror(c4n,n4e,etaR4e,'errorType','etaR');
        plot_localerror(c4n,n4e,etaM4e,'errorType','etaM');
    end
    if d == 2
        [c4n,n4e,n4Db,n4Nb] = BISECT2D(c4n,n4e,n4Db,n4Nb,n4ed,ed4e,mark4e);
    elseif d ==3
        % TODO: Implement neumann boundary
        [c4n,n4e,t4e,n4Db] = BISECT3D(c4n,n4e,t4e,mark4e);
    end
end
end