function lambda = munu2lambda(mu,nu)
% munu2lambda converts material parameters mu and nu to lambda
lambda = mu./(0.5-nu);
end
