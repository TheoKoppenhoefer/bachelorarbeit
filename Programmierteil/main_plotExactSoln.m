function main_plotExactSoln
% main_plotExactSoln: No input required, plots the initial conditions and
% the solution plot for the Benchmarks on the Square domain and on the L
% Shape domain

% set parameters lambda and mu
mus = [1e7,1e7];
lambdas = [munu2lambda(mus(1),0.2),munu2lambda(mus(2),0.3)];
benchmarkNames = ["SquareBenchmark","LShapeBenchmarkExact"];
factors = [0.1,1e6];
refinements = [3,2];

for i = 1:size(benchmarkNames,2)
    lambda = lambdas(i);
    mu = mus(i);

    [c4n,n4e,n4Db,n4Nb,f,g,Mw,u,sig] = load_benchmark(benchmarkNames(i),lambda,mu);

    plot_initialConditions(c4n,n4e,n4Db,n4Nb,'f',f,'g',g,'u',u,'exportPlt');

    for j = 1:refinements(i)
        mark4e = ones(size(n4e,1),1) == 1;
        [n4ed,ed4e,e4ed,ed4Db,ed4Nb] = SIDES(n4e,n4Db,n4Nb);
        [c4n,n4e,n4Db,n4Nb] = BISECT2D(c4n,n4e,n4Db,n4Nb,n4ed,ed4e,mark4e);
    end
    rough_c4n = c4n;
    rough_u4n = u(c4n);
    for j = 1:1
        mark4e = ones(size(n4e,1),1) == 1;
        [n4ed,ed4e,e4ed,ed4Db,ed4Nb] = SIDES(n4e,n4Db,n4Nb);
        [c4n,n4e,n4Db,n4Nb] = BISECT2D(c4n,n4e,n4Db,n4Nb,n4ed,ed4e,mark4e);
    end
    u4n = u(c4n);
    avsig4n = sig(c4n);
    avshearenergy4n = (mu/(24*(mu+lambda)^2)+1/(8*mu))*(avsig4n(:,1)+...
        avsig4n(:,4)).^2+1/(2*mu)*(avsig4n(:,2).^2-avsig4n(:,1).*avsig4n(:,4));
    plot_deformation(c4n,n4e,u4n,avshearenergy4n,factors(i));
    for j = 1:2
        mark4e = ones(size(n4e,1),1) == 1;
        [n4ed,ed4e,e4ed,ed4Db,ed4Nb] = SIDES(n4e,n4Db,n4Nb);
        [c4n,n4e,n4Db,n4Nb] = BISECT2D(c4n,n4e,n4Db,n4Nb,n4ed,ed4e,mark4e);
    end

    avsig4n = sig(c4n);
    avshearenergy4n = (mu/(24*(mu+lambda)^2)+1/(8*mu))*(avsig4n(:,1)+...
        avsig4n(:,4)).^2+1/(2*mu)*(avsig4n(:,2).^2-avsig4n(:,1).*avsig4n(:,4));
    % plot_localenergy(c4n,n4e,avshearenergy4n);

    localenergyplt = plot_localenergy(c4n,n4e,avshearenergy4n);
    plot_soln(rough_c4n,rough_u4n,'figure',localenergyplt,'zOffset',max(avshearenergy4n));
end
end
