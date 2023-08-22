function [c4n,n4e,n4Db,n4Nb,f,g,Mw,u,sig] = load_benchmark(problem,varargin)
% load_benchmark loads the various functions and domains of a given
% benchmark

% handle the input
default_lambda = 1;
default_mu = 1;
p = inputParser;
addOptional(p,'lambda',default_lambda);
addOptional(p,'mu',default_mu);

parse(p,varargin{:});

lambda = p.Results.lambda;
mu = p.Results.mu;

% some default settings
f = @(x)zeros(size(x));
g = @(x)zeros(size(x));
u = @(x)zeros(size(x));
Mw = @(x)create_Mw(u,x);
sig = @(x)zeros(size(x,1),size(x,2)^2);


switch problem
    case 'LShapeBenchmark'
        [c4n,n4e,n4Db,n4Nb] = load_domain('LShapeBenchmark');
        u = @(x)u_LShapeBenchmark(lambda,mu,x);
        Mw = @(x)create_Mw(u,x);
        if isfile('Functions/LShapeBenchmark.mat')
            sig = load('Functions/LShapeBenchmark.mat').sig;
            f = load('Functions/LShapeBenchmark.mat').f;
        else
            sig = generate_sig(@u_LShapeBenchmark);
            f = generate_f(sig);
            save('Functions/LShapeBenchmark.mat','sig','f');
        end
        sig = @(x)sig(lambda,mu,x);
        f = @(x)f(lambda,mu,x);
        g = @(x)generate_LShape_g(sig,x);
    case 'LShapeBenchmarkExact'
        [c4n,n4e,n4Db,n4Nb] = load_domain('LShapeBenchmark');
        u = @(x)u_LShapeBenchmark(lambda,mu,x);
        Mw = @(x)create_Mw(u,x);
        if isfile('Functions/LShapeBenchmark.mat')
            sig = load('Functions/LShapeBenchmark.mat').sig;
        else
            sig = generate_sig(@u_LShapeBenchmark);
            f = generate_f(sig);
            save('Functions/LShapeBenchmark.mat','sig','f');
        end
        sig = @(x)sig(lambda,mu,x);
        f = @(x)zeros(size(x));
    case 'EnclCircBenchmark'
        [c4n,n4e,n4Db,n4Nb] = load_domain('EnclCircBenchmark');
        u = @(x)u_CircEnclBenchmark(lambda,mu,x);
        sig = generate_sig(@u_CircEnclBenchmark);
        f = generate_f(sig);
        f = @(x)f(lambda,mu,x);
        sig = @(x)sig(lambda,mu,x);
        Mw = @(x)create_Mw_CircEnclBenchmark(u,x);
        g = @(x)g_CircEnclBenchmark(sig,x);
    case 'SquareBenchmark'
        [c4n,n4e,n4Db,n4Nb] = load_domain('SquareDirichlet');
        u = @u_SquareBenchmark;
        Mw = @(x)create_Mw(u,x);
        if isfile('Functions/SquareBenchmark.mat')
            sig = load('Functions/SquareBenchmark.mat').sig;
            f = load('Functions/SquareBenchmark.mat').f;
        else
            sig = generate_sig(@(lambda,mu,x)u(x));
            f = generate_f(sig);
            save('Functions/SquareBenchmark.mat','sig','f');
        end
        sig = @(x)sig(lambda,mu,x);
        f = @(x)f(lambda,mu,x);
    case 'SquareBenchmarkExact'
        [c4n,n4e,n4Db,n4Nb] = load_domain('SquareDirichlet');
        u = @u_SquareBenchmark;
        Mw = @(x)create_Mw(u,x);
        if isfile('Functions/SquareBenchmark.mat')
            sig = load('Functions/SquareBenchmark.mat').sig;
        else
            sig = generate_sig(@(lambda,mu,x)u(x));
            f = generate_f(sig);
            save('Functions/SquareBenchmark.mat','sig','f');
        end
        sig = @(x)sig(lambda,mu,x);
        f = @(x)f_SquareBenchmark(mu,x);
    case 'Cook'
        [c4n,n4e,n4Db,n4Nb] = load_domain('CooksMembrane');
        g = @f_Cook;
    case 'SquarePull'
        [c4n,n4e,n4Db,n4Nb] = load_domain('SquareNeumann');
        g = @f_Pull;
    case 'SquareShear'
        [c4n,n4e,n4Db,n4Nb] = load_domain('SquareNeumann');
        g = @f_Shear;
    case 'Box3D'
        [c4n,n4e,n4Db,n4Nb] = load_domain('Box3D');
    case 'Cube'
        [c4n,n4e,n4Db,n4Nb] = load_domain('Cube');
        f = @f_1;
    case 'CubeWhirl'
        [c4n,n4e,n4Db,n4Nb] = load_domain('Cube');
        f = @(x)f_CubeBenchmark(mu,x);
    case 'LShape3D'
        [c4n,n4e,n4Db,n4Nb] = load_domain('LShape3D');
end
end