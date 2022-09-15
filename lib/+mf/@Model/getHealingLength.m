function hl = getHealingLength(obj, Psi, t)
if ~isempty(obj.Vts)
    for i = 1 : size(obj.Vts, 2)
        Psi_i = Psi.*obj.getRingMask(i, t);
        n0 = max(abs(Psi_i(:)).^2);
        hl(i) = 1/sqrt(8*pi*obj.config.as*n0);
    end
end
end