function y = u_SquareBenchmark(x)
% solution u to the benchmark on the square domain as described in
% [Carstensen et al.,p.2911f.]

y = pi*[cospi(x(:,2)).*(sinpi(x(:,1)).^2).*sinpi(x(:,2)),...
        -cospi(x(:,1)).*sinpi(x(:,1)).*(sinpi(x(:,2)).^2)];
end
