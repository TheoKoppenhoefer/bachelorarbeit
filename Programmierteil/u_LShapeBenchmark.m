function y = u_LShapeBenchmark(lambda,mu,x,alph)
% solution u to the L-Shape Benchmark as described in
% [Carstensen et al.,p.2914f.]

if nargin < 4
    alph = 0.544483736782;
end
C_1 = -cospi((alph+1)*3/4)/(cospi((alph-1)*3/4));
C_2 = 2*(lambda+2*mu)/(lambda+mu);
[theta,rho] = cart2pol(x(:,1),x(:,2));
ur = 1/(2*mu) *rho.^alph.*(-(alph+1)*cos((alph+1)*theta)...
    +(C_2-alph-1)*C_1*cos((alph-1)*theta));
ut = 1/(2*mu) *rho.^alph.*((alph+1)*sin((alph+1)*theta)...
    +(C_2+alph-1)*C_1*sin((alph-1)*theta));
y = [ur.*cos(theta)-ut.*sin(theta), ur.*sin(theta)+ut.*cos(theta)];
end
