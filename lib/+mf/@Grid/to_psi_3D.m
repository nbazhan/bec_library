function psi_ph = to_psi_3D(obj, psi)
[~, ~, Z] = meshgrid(obj.r.x, obj.r.y, obj.r.z);
psi_ph = (1/sqrt(pi)/obj.config.l.z)^0.5*...
          exp(-Z.^2/2/obj.config.l.z^2).*psi;
end