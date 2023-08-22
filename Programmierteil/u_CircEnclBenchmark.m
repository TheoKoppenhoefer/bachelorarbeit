function y = u_CircEnclBenchmark(lambda,mu,x)
% solution u to the circular enclosure benchmark as described in
% [Carstensen et al.,p.2913f.]

nu = lambdamu2nu(lambda,mu);
kappa = 3-4*nu;
gamma = 2*nu-1;
a = 1/4;
[theta,rho] = cart2pol(x(:,1),x(:,2));
ur = 1/(8*mu)*((kappa-1)*rho.^2+2*gamma*a^2+(2*rho.^2 ...
    -2*(kappa+1)*a^2/kappa+2*a^4/kappa./(rho.^2)).*cos(2*theta))./rho;
ut = -1/(8*mu)*(2*rho.^2-2*(kappa-1)*a^2/kappa-2*a^4/kappa./(rho.^2)) ...
    .*sin(2*theta)./rho;
y = [ur.*cos(theta)-ut.*sin(theta), ur.*sin(theta)+ut.*cos(theta)];
end