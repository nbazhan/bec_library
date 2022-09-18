function v = get_v(obj, t, varargin)

if any(strcmp(varargin, 'nt'))
    c = struct('nt', {'nt'}, 'tof', {'tof', 'nt'});
    grid = obj.grid_nt;
else
    c = struct('nt', {}, 'tof', {'tof'});
    grid = obj.grid;
end

if obj.D == 2
    v = zeros([grid.N.x, grid.N.y]);
elseif obj.D == 3
    v = zeros([grid.N.x, grid.N.y, grid.N.z]);
end


typs = fieldnames(obj.Vs);
for i = 1 : length(typs)
    typ = typs{i};
    if ~strcmp('toroidal', typ)
        for j = 1 : length(obj.Vs.(typ))
            v = v + obj.Vs.(typ)(j).get_v(t, c.nt);
        end
    else
        rc = obj.Vs.toroidal(1).get_rc(t, c.nt);
        r = sqrt((grid.X - rc.x).^2 + ...
                 (grid.Y - rc.y).^2);
        v = v + obj.Vs.toroidal(1).get_v(t, c.nt).*(r < obj.Vs.toroidal(1).get_r(t, c.nt));
        if length(obj.Vs.toroidal) > 1
            for j = 2:length(obj.Vs.toroidal)
                rc = obj.Vs.toroidal(j).get_rc(t, c.nt);
                r = sqrt((grid.X - rc.x).^2 + ...
                         (grid.Y - rc.y).^2);
                rm = 0.5*(obj.Vs.toroidal(j - 1).get_r(t, c.nt) + ...
                          obj.Vs.toroidal(j).get_r(t, c.nt));
                v = v + obj.Vs.toroidal(j - 1).get_v(t, c.tof).*...
                        (r > obj.Vs.toroidal(j - 1).get_r(t, c.nt)).*(r < rm);
                v = v + obj.Vs.toroidal(i).get_v(t, c.tof).*...
                        (r > rm).*(r < obj.Vs.toroidal(j).get_r(t, c.nt));
            end
        end
        v = v + obj.Vs.toroidal(end).get_v(t, c.nt).*(r > obj.Vs.toroidal(end).get_r(t, c.nt));
    end
end

end

