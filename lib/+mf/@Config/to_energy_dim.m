function converted_energy = to_energy_dim(obj, energy)
% convert dimension energy to dimentionless
converted_energy = energy/(obj.hbar*obj.w.r);
end

