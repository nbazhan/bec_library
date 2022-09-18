function mu = getAllmu(obj, Psi, t) 
% return array L with chemical of each ring
mu = zeros(1, length(obj.Vts));
Nl = obj.getV(t) + obj.config.g*(abs(Psi).^2);
for i = 1:length(obj.Vts)
    Psi_i = obj.getRingPsi(Psi, i, t);
    N_i = obj.getN(Psi_i);
    Nl_i = Nl.*obj.getRingMask(i, t);
    H_i = obj.applyham(Psi_i, Nl_i);
    mu(i) = real(sum(H_i(:)).*obj.grid.dV)/N_i;
end
end