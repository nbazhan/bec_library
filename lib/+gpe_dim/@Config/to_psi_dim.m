function converted_psi = to_psi_dim(obj, psi)
% convert dimension energy to dimentionless
converted_psi = psi*obj.l.r^1.5;
end

