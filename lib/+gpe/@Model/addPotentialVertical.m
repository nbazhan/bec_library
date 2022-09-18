function addPotentialVertical(obj, params)
params.config = obj.config;
params.grid = obj.grid;
Vb = gpe.PotentialVertical(params);
obj.Vbs = [obj.Vbs Vb];
end

