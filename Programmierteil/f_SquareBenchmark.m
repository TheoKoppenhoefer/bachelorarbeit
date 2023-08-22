function y = f_SquareBenchmark(mu,x)
% function given in [Carstensen et al.,p.2911f.] for the benchmark on the
% square domain
y = 2*mu*(pi^3)*[-cospi(x(:,2)).*sinpi(x(:,2)).*(2*cospi(2*x(:,1))-1),...
                cospi(x(:,1)).*sinpi(x(:,1)).*(2*cospi(2*x(:,2))-1)];
end
