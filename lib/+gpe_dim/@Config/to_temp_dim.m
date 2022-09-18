function converted_temperature = to_temp_dim(obj, temperature)
% convert dimension T to dimentionless T
converted_temperature = temperature/(obj.hbar*obj.w.r/obj.kb);
end

