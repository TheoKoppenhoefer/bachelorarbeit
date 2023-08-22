function [lambda,mu] = Enu2lambdamu(E,nu)
% Enu2lambdamu converts the Material parameters E and nu to the
% Lame-Parameters lambda and mu
lambda = E*nu/((1+nu)*(1-2*nu));
mu = E/(2*(1+nu));
end
