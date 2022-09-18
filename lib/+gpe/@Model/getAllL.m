function L = getAllL(obj, Psi)
% return array L with angular momentum of each ring
L = zeros(1, length(obj.Vts));
for i = 1:length(obj.Vts)
    Psi_i = obj.getRingPsi(Psi, i);
    L(i) = obj.getL(Psi_i);
end
end

