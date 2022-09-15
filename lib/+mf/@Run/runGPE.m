function [Psi, mu, t] = runGPE(obj, Psi, mu, t, tf)

while t < tf
    V = obj.model.getV(t);
    Psi2 = real(Psi.*conj(Psi));
    N = obj.model.getN(Psi);

    %% GPE step
    for i = 1 : obj.n_iter_fft
        Psi = exp(-0.5*obj.dt_f*...
                 (V + obj.config.g*Psi2 - mu)).*Psi;
        Psi = ifftn(obj.ekk.*fftn(Psi));
        Psi = exp(-0.5*obj.dt_f*...
                 (V + obj.config.g*Psi.*conj(Psi) - mu)).*Psi;
    end

    Psi2 = real(Psi.*conj(Psi));
    ncur = sum(Psi2(:).*obj.grid.dV);

    if(obj.config.gamma > 0)
        if(obj.config.td > 0)
            N = obj.config.N*exp(-t/obj.config.td);
        end       
        Psi = Psi*sqrt(N/ncur);
    end

    H = obj.applyham(Psi, V + obj.config.g*(abs(Psi).^2));
    mu = real(sum(H(:)).*obj.grid.dV)/N;
    t = t + obj.dt*obj.n_iter_fft;
end
end