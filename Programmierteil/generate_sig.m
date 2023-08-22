function y = generate_sig(u)
d = 2;
syms slambda smu
syms(sym('sx',[1 d]));
assume(sx1,'real');
assume(sx2,'real');
assume(slambda,'positive');
assume(smu,'positive');
% assume(alph,'positive');
% assume(alph*sinpi(3/2)+sinpi(3*alph/2) == 0);
su = u(slambda,smu,[sx1 sx2]);
sgradu = [diff(su,sx1);diff(su,sx2)];
ssig = reshape(slambda*trace(sgradu)*eye(d)+2*smu*(sgradu+sgradu')/2,1,d*d);
ssig = simplify(ssig);
% ssigu = subs(ssigu,alph,0.544483736782);
y = matlabFunction(ssig,'Vars',{slambda,smu,[sx1 sx2]});
end