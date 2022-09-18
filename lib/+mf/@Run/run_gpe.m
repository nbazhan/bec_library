function [Psi, mu, t] = run_gpe(obj, Psi, mu, t, tf)

while t < tf
    v = obj.model.get_v(t);
    Psi2 = real(Psi.*conj(Psi));
    n = obj.model.get_n(Psi);

    %% GPE step
    for i = 1 : obj.n_iter_fft
        Psi = exp(-0.5*obj.dt_f*...
                 (v + obj.model.config.g*Psi2 - mu)).*Psi;
        Psi = ifftn(obj.ekk.*fftn(Psi));
        Psi = exp(-0.5*obj.dt_f*...
                 (v + obj.model.config.g*Psi.*conj(Psi) - mu)).*Psi;
    end

    Psi2 = real(Psi.*conj(Psi));
    ncur = sum(Psi2(:).*obj.model.grid.dV);

    if(obj.model.config.gamma > 0)
        if(obj.model.config.td > 0)
            n = obj.model.config.N*exp(-t/obj.model.config.td);
        end       
        Psi = Psi*sqrt(n/ncur);
    end

    H = obj.model.applyham(Psi, v + obj.model.config.g*(abs(Psi).^2));
    mu = real(sum(H(:)).*obj.model.grid.dV)/n;
    t = t + obj.dt*obj.n_iter_fft;
end
end