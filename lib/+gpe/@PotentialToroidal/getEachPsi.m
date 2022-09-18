function [Psi_i, Psi_o] = getEachPsi(obj, Psi)
    Ro = max(obj.R, obj.R2);
    Ri = min(obj.R, obj.R2);
    dR = abs(Ro - Ri)/4;
    Psi_o = Psi.*(abs(sqrt(obj.grid.X.^2 + ...
                          obj.grid.Y.^2) - Ro) < dR);
    Psi_i = Psi.*(abs(sqrt(obj.grid.X.^2 + ...
                          obj.grid.Y.^2) - Ri) < dR);
end

