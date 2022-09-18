function [Psi, mu] = runGPE(obj, Psi, mu, ts, tf)

t = ts;
while t < tf
    [Psi, mu] = obj.stepGPE(Psi, mu, t);
    t = t + obj.dt;
end
end
      