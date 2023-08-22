function y = generate_f(sig_u)
% generate_f calculates f based on a given stress tensor sigma, it requires
% the Symbolic Math Toolbox to run
syms slambda smu
syms(sym('sx',[1 2]));
assume(slambda,'positive');
assume(smu,'positive');
assume(sx1,'real');
assume(sx2,'real');
ssig = reshape(sig_u(slambda,smu,[sx1 sx2]),2,2);
sgradxsigu = diff(ssig,sx1);
sgradysigu = diff(ssig,sx2);
sdivsig = -[1,0]*sgradxsigu-[0,1]*sgradysigu;
sdivsig = simplify(sdivsig);
y = matlabFunction(sdivsig,'Vars',{slambda,smu,[sx1 sx2]});
end