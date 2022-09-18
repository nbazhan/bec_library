function addPotentialCosine(obj, params)
params.config = obj.config;
params.grid = obj.grid;
Vc = gpe_dim.PotentialCosine(params);
obj.Vcs = [obj.Vcs Vc];
end

