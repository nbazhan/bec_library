function [Psi, mu] = runSGPE(obj, Psi, mu, ts, tf, ecut_coef)

%% calculate cutting condition
ecut = mu + ecut_coef*obj.config.kb*obj.config.T*log(2);
kcut = sqrt(2*obj.config.M*ecut/obj.config.hbar^2);
projec = obj.grid.kk*2 <= kcut^2;

t = ts;
while t < tf 
    [Psi, mu] = obj.stepSGPE(Psi, mu, t, projec);
    t = t + obj.dt;
end
end