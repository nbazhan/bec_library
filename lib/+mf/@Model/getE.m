function E = getE(obj, Psi, t)
Psi2 = Psi.*conj(Psi);
E = 0.5*conj(Psi).*ifftn(obj.grid.kk.*fftn(Psi)) + ...
    0.5*Psi.*ifftn(obj.grid.kk.*fftn(conj(Psi))) + ...
    (obj.getV(t) + 0.5*obj.config.g*Psi2).*Psi2;
E = gather(real(sum(E(:).*obj.grid.dV)));
end