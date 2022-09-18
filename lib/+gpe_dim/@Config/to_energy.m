function energy = to_energy(obj, converted_energy)
% convert dimensionless energy to dimention
energy = converted_energy*obj.hbar*obj.w.r;
end

