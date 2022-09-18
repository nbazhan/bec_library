function temperature = to_temp(obj, converted_temperature)
% convert dimensionless T to dimention T
temperature = converted_temperature*obj.hbar*obj.w.r/obj.kb;
end

