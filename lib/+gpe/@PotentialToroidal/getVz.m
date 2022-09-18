function V = getVz(obj)
V = 0.5*obj.config.M*obj.wz^2*obj.grid.Z.^2;
end