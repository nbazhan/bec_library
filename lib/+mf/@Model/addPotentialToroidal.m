function addPotentialToroidal(obj, params)
params.config = obj.config;
params.grid = obj.grid;

if ~isfield(params, 'tof') && ~isempty(obj.tof)
    params.tof = obj.tof;
end

newVt = gpe_dim.PotentialToroidal(params);

if isempty(obj.Vts)
    obj.Vts = [newVt];
else     
    % sort Toroidal Potentials in increasing radius order
    newVts = [];
    newAdded = 0;

    for i = 1:length(obj.Vts) + 1             
        if i == length(obj.Vts) + 1 && ~newAdded
            newVts = [newVts newVt];
        else
            Vt = obj.Vts(i - newAdded);
            if (min(Vt.R.x, Vt.R.y) > min(newVt.R.x, newVt.R.y) && ~newAdded) 
                newVts = [newVts newVt];
                newAdded = 1;
            else
                newVts = [newVts Vt];
            end
        end
    end
    obj.Vts = newVts;
end
end

