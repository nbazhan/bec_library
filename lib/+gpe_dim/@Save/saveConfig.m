function saveConfig(obj, params)
obj.saveInfo();
sv = obj;
save([obj.Config 'sv.mat'], 'sv');

if isfield(params, 'model')
    model = params.model;
    save([obj.Config 'model.mat'], 'model');
end

if isfield(params, 'run')
    run = params.run;
    save([obj.Config 'run.mat'], 'run');
end 
end