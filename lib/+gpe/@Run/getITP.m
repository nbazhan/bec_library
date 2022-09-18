function [Psi, mu] = getITP(obj)

disp('Start ITP...')

% initial amount of thermal and condensed atoms
if isempty(obj.config.mu)
    Ntot = obj.config.N;
else
    Ntot = 1;
end
Nc = Ntot;
V = obj.model.getV(0);

% initial Phi
if isempty(obj.config.mu)
    phi0 = rand(obj.grid.N, obj.grid.N, obj.grid.Nz) + ...
                1i*rand(obj.grid.N, obj.grid.N, obj.grid.Nz);  
    Psi = sqrt(Ntot/(sum(sum(sum(abs(phi0).^2)))*...
           obj.grid.dV))*phi0;
else
    Psi = real(sqrt(complex(obj.config.mu - V)/obj.config.g)); % use only Thomas-Fermi approximation as initial guess if mu_init is set
end

C = zeros(1000, 1);
c_old = 0;
MU = zeros(1000, 1);

delta = 1;
eps = 10^(-6);
i = 1;

Psi2 = Psi.*conj(Psi);
Nl = V + obj.config.g*real(Psi2);

while (delta > eps)
    Psi = ifftn(obj.ekk.*fftn(Psi));
    Psi = exp(-(obj.dt_itp/(obj.config.hbar))*Nl).* Psi;
    Psi = ifftn(obj.ekk.*fftn(Psi));
   
    if(mod(i,10) == 1 && isempty(obj.config.mu)) % for better performance and stability we do some initial iterations without a thermal cloud
        Nc = Ntot;
        if(Nc < 1)
            Nc = 1;
        end
    end
    
    Psi2 = Psi.*conj(Psi);
    N = sum(sum(sum(real(Psi2).*obj.grid.dV)));
    
    if isempty(obj.config.mu)
        c = sqrt(Nc/N);
        N = Nc;
        C(i) = gather(c);
    else
        c = exp((obj.config.mu/obj.config.hbar)*obj.dt_itp);
        N = N*c^2;
        C(i) = gather(N);
    end

    Psi=Psi*c;
    Psi2 = Psi2*c^2;
	Nl = V + obj.config.g*real(Psi2);
    
    Hk = conj(Psi).*(obj.config.hbar^2/(2*obj.config.M)).*...
               ifftn(obj.grid.kk.*fftn(Psi));
    Hi = Psi2.*Nl;
    mu2 = real(sum(sum(sum((Hk + Hi).*obj.grid.dV))))/N;
    MU(i) = gather(mu2);
    
    if(mod(i,10) == 0)
        mmu = min(MU(i),min(min(min(Nl)))- 10e-41); % compensate for possibly inaccurate chem. pot. calculation

        if isempty(obj.config.mu)
            delta = abs(log(c_old/c))*obj.config.hbar/(9*obj.dt_itp^2*mmu);
        else
            delta = abs(C(i) - c_old)/(9*obj.dt_itp);
        end
        disp(['i: ', num2str(i), ', delta: ', num2str(delta, '%.2g')])
        c_old = C(i - 9);

    end
	Nl = V + obj.config.g*real(Psi2);
    i=i+1;
    if(i>=10000) 
        warning('Convergence not reached');
        break;
    end
end
mu = MU(i-1);
disp('Finished!')
end
