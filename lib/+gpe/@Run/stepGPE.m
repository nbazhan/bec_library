function [Psi, mu] = stepGPE(obj, Psi, mu, t)

V = obj.model.getV(t);
N_prev = obj.model.getN(Psi);

%% GPE step
Psi = ifftn(obj.ekk.*fftn(Psi));
Psi = exp((-1/obj.config.hbar) * obj.dt_f * ...
          (V + obj.config.g * abs(Psi.*conj(Psi)) - mu)).* Psi;
Psi = ifftn(obj.ekk.*fftn(Psi));

%% changing mu to fix amount of particles N = N(t)
Nbase = obj.model.getN(Psi);
G = -(1/(obj.dt)) * log(gather (Nbase)/gather(N_prev));
mu = mu + obj.config.hbar*(G - obj.inv_td) * ...
    (1 + obj.config.gamma^2)/(2 * obj.config.gamma);

end