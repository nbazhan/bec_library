function [Psi, nt, mu] = getZNG(obj, varargin)

if obj.config.D == 2
    T = 0;
    disp('2D problem: calculating ITP...')
elseif size(varargin) > 1 
    T = varargin{1};
    disp('2D problem: calculating ITP...')
else
    T = obj.config.T;
end

V = obj.model.getV(0);
Nl2 = obj.model_nt.getV(0);

% initial Phi
if isempty(obj.config.mu)
    if obj.config.D == 3
        phi0 = rand(obj.grid.N.x, obj.grid.N.y, obj.grid.N.z) + ...
                    1i*rand(obj.grid.N.x, obj.grid.N.y, obj.grid.N.z); 
    elseif obj.config.D == 2
        phi0 = rand(obj.grid.N.x, obj.grid.N.y) + ...
                1i*rand(obj.grid.N.x, obj.grid.N.y);  
    end
    Psi = sqrt(obj.config.N/(sum(sum(sum(abs(phi0).^2)))*...
               obj.grid.dV))*phi0;
else
    Psi = real(sqrt(complex(obj.config.mu - V)/obj.config.g)); % use only Thomas-Fermi approximation as initial guess if mu_init is set
end

if ~isempty(obj.model.Vts)
   for i = 1 : size(obj.model.Vts, 2)
       if size(obj.model.M, 2) >= i
           M = obj.model.M(i);
           Psi = Psi.*exp(1i*M*angle(obj.grid.X + obj.grid.Y.*1i).*obj.model.getRingMask(i, 0));
       end
   end
end
	
if isempty(obj.config.mu)
    Nc = obj.config.N;
else
    Nc = 1;
end
% initial amount of thermal and condensed atoms
nt = zeros(size(obj.grid_nt.X),'like',V);
Nt = 0;

nx = round(obj.grid.N.x/2);
ny = round(obj.grid.N.y/2);
if obj.config.D == 3
    nz = round(obj.grid.N.z/2);
end

C = zeros(1000, 1);
c_old = 0;
MU = zeros(1000, 1);

delta = 1;
eps = 10^(-5);
i = 0;
dt = obj.dt_itp;
ekk = exp(-obj.grid.kk * dt);
Nl = V + obj.config.g*real(Psi.*conj(Psi));
while true 
    i = i + 1;

    Psi = exp(-(dt/2)*Nl).*Psi;
    Psi = ifftn(ekk.*fftn(Psi));
    Psi = exp(-(dt/2)*Nl).*Psi;
    
	Psi2 = real(Psi.*conj(Psi));
    
    if(T > 0 && mod(i,10) == 1 && isempty(obj.config.mu)) % for better performance and stability we do some initial iterations without a thermal cloud
        Nt = sum(nt(:)).*obj.grid_nt.dV;
        Nc = obj.config.N - Nt;
        if(Nc < 1)
            Nc = 1;
            nt = nt*obj.config.N/Nt; % we need to get the correct total number of particles even above Tc
        end
    end
    N = sum(Psi2(:)).*obj.grid.dV;
    if isempty(obj.config.mu)
        c = sqrt(Nc/N);
        N = N*c^2;
        C(i) = gather(log(c)/dt);
    else
        c = exp(obj.config.mu*dt);
        N = N*c^2;
        C(i) = gather(N);
    end
    
    Psi =Psi*c;
    Psi2 = Psi2*abs(c)^2;
    Nl = V + obj.config.g*(abs(Psi).^2);
     
    H = obj.applyham(Psi, Nl + 2*obj.shrink(nt));
    mu2 = real(sum(H(:)).*obj.grid.dV)/N;
    MU(i) = gather(mu2);
    
    if(mod(i,10) == 0)
        if(T > 0)
            if obj.config.D == 3
                Nl2(nx + 1:3*nx, ny + 1:3*ny, nz+1:3*nz) = V + 2*obj.config.g*real(Psi2);
            elseif obj.config.D == 2
                Nl2(nx + 1:3*nx, ny + 1:3*ny) = V + 2*obj.config.g*real(Psi2);
            end
            Nl2 = Nl2 + 2*obj.config.g*nt;
            ntt = (T/(2*pi))^(3/2)*...
                   util_yb.mypolylog(1.5, ...
                   exp((MU(i) - Nl2)/T));
            ntt = ntt.*isfinite(ntt);
            if(Nc <= 1 && isempty(obj.config.mu))
                Nt = sum(nt(:)).*obj.grid_nt.dV;
		        nt = (nt + ntt*obj.config.N/Nt)*0.5;
		    else
		        nt=(nt+ntt)*0.5;
            end
        end 
    end
    Nl = Nl + 2*obj.config.g*obj.shrink(nt);
   
    if(i > 50) && mod(i,10) == 5
        delta = (abs(C(i)-C(i-9))/9 + abs(C(i)-C(i-1)))/dt/C(i);
        if(delta < eps)
            if (dt < eps*10 || dt < 1e-4)
                break;
            else
                dt = dt/1.5;
                ekk = exp(-obj.grid.kk*dt);
            end
        end
    end
    if(i>=10000) 
        warning('Convergence not reached');
        break;
    end
end
mu = C(i-1);

% Make intial mean phase inside toroidal potential equal to zero 
% substitute mean phase base_phi
if ~isempty(obj.model.Vts)
     r = sqrt(obj.grid.X.^2 + obj.grid.Y.^2);
     R = obj.model.Vts(1).R.x;
     psi = Psi;
     filter = (abs(r - R) < 0.01*R);
     if obj.config.D == 3
         psi = psi(:, :, round(obj.grid.N.z./2));
         filter = filter(:, :, round(obj.grid.N.z./2));
     end
     base_phi = sum(angle(psi).*filter)/sum(filter);
     Psi = Psi.*exp(-1i*base_phi);
end

end
