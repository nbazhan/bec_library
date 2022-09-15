function [Psi, mu] = loadPsiMu(obj, s)
    Psi = obj.loadPsi(s);
    mus = obj.loadMu();
    mu = mus(s);
end