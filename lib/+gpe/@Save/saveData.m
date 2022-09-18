function saveData(obj, s, sf, params)

if isfield(params, 'Psi')
    Psi = params.Psi;
    save([obj.PsiMat 'Psi' num2str(s,'%.0f') '.mat'], 'Psi');
end

if isfield(params, 't')
    if s == 1
        obj.ts = zeros(1, sf);
    end
    obj.ts(s) = params.t;
    ts = obj.ts;
    save([obj.Data 't.mat'], 'ts')
end

if isfield(params, 'mu')
    if s == 1
        obj.mus = zeros(1, sf);
    end
    obj.mus(s) = params.mu;
    mus = obj.mus;
    save([obj.Data 'mu.mat'], 'mus')
end

if isfield(params, 'Ub')
    if s == 1
        obj.Ubs = zeros(sf, length(params.Ub));
    end
    obj.Ubs(s, :) = params.Ub;
    Ubs = obj.Ubs;
    save([obj.Data 'Ub.mat'], 'Ubs')
end


if isfield(params, 'L')
    if s == 1
        obj.ls = zeros(sf, length(params.L));
    end
    obj.ls(s, :) = params.L;
    ls = obj.ls;
    save([obj.Data 'l.mat'], 'ls')
end


if isfield(params, 'U1d')
    if s == 1
        obj.Us = zeros(sf, obj.grid.N);
    end
    obj.Us(s, :) = params.U1d;
    Us = obj.Us;
    save([obj.Data 'U.mat'], 'Us')
end

end