function [Psi, nt, mu] = getZNG_dim(obj)

w = 2*pi*150;
es = obj.config.hbar*w;
rs = sqrt(obj.config.hbar/(obj.config.M*w));
ts = 1/w;

% divide V and mu on hbar
V = obj.model.getV(0)/es;
mu = obj.config.mu/es;
dV = obj.grid.dV/rs^3;
g = (obj.config.g/rs)*(obj.config.M/obj.config.hbar^2);
dt_itp = obj.dt_itp/ts;
kk = obj.grid.kk*rs^2;
ekk = exp(-0.5 * kk * dt_itp);

T = obj.config.T*obj.config.kb/es;

% initial Phi
if isempty(obj.config.mu)
    phi0 = rand(obj.grid.N, obj.grid.N, obj.grid.Nz) + ...
                1i*rand(obj.grid.N, obj.grid.N, obj.grid.Nz);  
    Psi = sqrt(obj.config.N/(sum(sum(sum(abs(phi0).^2)))*dV))*phi0;
else
    Psi = real(sqrt(complex(mu - V)/g)); % use only Thomas-Fermi approximation as initial guess if mu_init is set
end

nt = zeros([obj.grid.N, ...
            obj.grid.N, ...
            obj.grid.Nz], 'like', Psi);
Nt = 0;

% initial amount of thermal and condensed atoms
if isempty(obj.config.mu)
    Nc = obj.config.N;
else
    Nc = 1;
end

C = zeros(1000, 1);
c_old = 0;
MU = zeros(1000, 1);


delta = 1;
eps = 10^(-6);
i = 1;

Psi2 = Psi.*conj(Psi);
Nl = V + g*real(Psi2) + 2*g*nt;

while (delta > eps)
    Psi = exp(-(dt_itp/2)*Nl).*Psi;
    Psi = ifftn(ekk.*fftn(Psi));
    Psi = exp(-(dt_itp/2)*Nl).*Psi;
    
    if(T > 0 && mod(i,10) == 1 && isempty(obj.config.mu)) % for better performance and stability we do some initial iterations without a thermal cloud
        Nt = sum(sum(sum(nt.*dV)));
        Nc = obj.config.N - Nt;
        if(Nc < 1)
            Nc = 1;
            nt = nt*obj.config.N/Nt; % we need to get the correct total number of particles even above Tc
        end
    end
    
    Psi2 = Psi.*conj(Psi);
    N = sum(sum(sum(real(Psi2).*dV)));
    
    if isempty(obj.config.mu)
        c = sqrt(Nc/N);
        N = N*c^2;
        C(i) = gather(c);
    else
        c = exp(mu*dt_itp);
        N = N*c^2;
        C(i) = gather(N);
    end

    Psi=Psi*c;
    Psi2 = Psi2*abs(c)^2;
	Nl = V + g*real(Psi2) + 2*g*nt;
    
    Hk = conj(Psi).*(1/2).*...
               ifftn(kk.*fftn(Psi));
    Hi = Psi2.*Nl;
    mu2 = real(sum(sum(sum((Hk + Hi).*dV))))/N;
    MU(i) = gather(mu2);
    
    if(mod(i,10) == 0)
        mmu = min(MU(i),min(min(min(Nl)))- 10e-10); % compensate for possibly inaccurate chem. pot. calculation
        if(T > 0)
            ntt = (T/(2*pi))^(3/2)*...
                   util.myPolylog(1.5, exp((mmu - Nl)/T));
  
            if(Nc <= 1 && isempty(obj.config.mu))
                Nt = sum(sum(sum(nt.*dV)));
		        nt = (nt+ntt*obj.config.N/Nt)*0.5;
		    else
		        nt=(nt+ntt)*0.5;
		    end
        end

        Nt = sum(sum(sum(nt.*dV)));
        if isempty(obj.config.mu)
            delta = abs(log(c_old/c))*1/(9*dt_itp^2*mmu);
        else
            delta = abs(C(i) - c_old)/(9*dt_itp);
        end
        c_old = C(i - 9);

    end
	Nl = V + g*real(Psi2) + 2*g*nt;
    i=i+1;
    
    if(i>=10000) 
        warning('Convergence not reached');
        break;
    end
end
Psi = Psi/(rs)^(3/2); 
nt = nt/(rs^3);
mu = MU(i-1)*es;
end
