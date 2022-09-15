function addPotentialLadder(obj, params)
params.config = obj.config;
params.grid = obj.grid;
Vl = gpe_dim.PotentialLadder(params);
obj.Vls = [obj.Vls Vl];
end

