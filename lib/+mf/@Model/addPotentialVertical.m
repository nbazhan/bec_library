function addPotentialVertical(obj, params)
params.config = obj.config;
params.grid = obj.grid;
Vb = gpe_dim.PotentialVertical(params);
obj.Vbs = [obj.Vbs Vb];
end

