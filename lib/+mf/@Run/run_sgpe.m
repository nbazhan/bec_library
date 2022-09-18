function [Psi, mu, t] = run_sgpe(obj, Psi, mu, t, tf)

ecut = mu + ecut_coef*log(2)*obj.model.config.kb*obj.model.config.T;
kcut = sqrt(2*obj.model.config.M*ecut/obj.model.config.hbar^2);
projec = obj.model.grid.kk*2 <= kcut^2;

while t < tf

    %% noise generation
    xi_ra = randn(obj.model.grid.N.x, obj.model.grid.N.y, obj.model.grid.N.z)*obj.sigma; 
    xi_rb = randn(obj.model.grid.N.x, obj.model.grid.N.y, obj.model.grid.N.z)*obj.sigma;
    eta_r = (xi_ra + 1i*xi_rb)/(obj.model.config.hbar*(1i - obj.model.config.gamma));
    Psi = Psi + eta_r*obj.dt;

%% SGPE step
v = obj.model.get_v(t);
          
Psi = ifftn(obj.ekk.*fftn(Psi));
Psi = exp((-1/obj.config.hbar) * obj.dt_f * ...
          (V + obj.config.g * abs(Psi.*conj(Psi)) - mu)).* Psi;
Psi = ifftn(obj.ekk.*fftn(Psi).*projec);



    v = obj.model.get_v(t);
    Psi2 = real(Psi.*conj(Psi));
    n = obj.model.get_n(Psi);

    

    %% SGPE step
    for i = 1 : obj.n_iter_fft
        Psi = exp(-0.5*obj.dt_f*...
                 (v + obj.model.config.g*Psi2 - mu)).*Psi;
        Psi = ifftn(obj.ekk.*fftn(Psi));
        Psi = exp(-0.5*obj.dt_f*...
                 (v + obj.model.config.g*Psi.*conj(Psi) - mu)).*Psi;
    end

    Psi2 = real(Psi.*conj(Psi));
    ncur = sum(Psi2(:).*obj.model.grid.dV);


    H = obj.model.applyham(Psi, v + obj.model.config.g*(abs(Psi).^2));
    mu = real(sum(H(:)).*obj.model.grid.dV)/n;
    t = t + obj.dt*obj.n_iter_fft;
end
end