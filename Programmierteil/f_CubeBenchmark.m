function y = f_CubeBenchmark(mu,x)
% function based on a benchmark for the square in [Carstensen et al.,p.2911f.]

y = 2*mu*(pi^3)*[-cospi(x(:,2)).*sinpi(x(:,2)).*(2*cospi(2*x(:,1))-1),...
                cospi(x(:,1)).*sinpi(x(:,1)).*(2*cospi(2*x(:,2))-1),...
                zeros(size(x,1),1)];
end
