function [Psi, mu] = loadInit(obj)
Psi = obj.loadPsi(1);
mus = obj.loadMu();
mu = mus(1);
end
