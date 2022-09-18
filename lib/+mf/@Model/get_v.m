function v = get_v(obj, t)

if obj.D == 2
    v = zeros([obj.model.grid.N.x, obj.model.grid.N.y]);
elseif obj.D == 3
    v = zeros([obj.model.grid.N.x, obj.model.grid.N.y, obj.model.grid.N.z]);
end


typs = fieldnames(obj.Vs);
for i = 1 : length(typs)
    typ = typs{i};
    if ~srtcmp('toroidal', typ)
        for j = 1 : length(obj.Vs.(typ))
            v = v + obj.Vs.(typ)(j).get_v(obj, t);
        end
    else
        rc = obj.Vs.toroidal(1).get_rc(t);
        r = sqrt((obj.model.grid.X - rc.x).^2 + ...
                 (obj.model.grid.Y - rc.y).^2);
        v = v + obj.Vs.toroidal(1).get_v(t).*(r < obj.Vs.toroidal(1).get_r(t));
        if length(obj.Vs.toroidal) > 1
            for j = 2:length(obj.Vs.toroidal)
                rc = obj.Vs.toroidal(j).get_rc(t);
                r = sqrt((obj.model.grid.X - rc.x).^2 + ...
                         (obj.model.grid.Y - rc.y).^2);
                rm = 0.5*(obj.Vs.toroidal(j - 1).get_r(t) + ...
                          obj.Vs.toroidal(j).get_r(t));
                v = v + obj.Vs.toroidal(j - 1).get_v_tof(t).*...
                        (r > obj.Vs.toroidal(j - 1).get_r(t)).*(r < rm);
                v = v + obj.Vs.toroidal(i).get_v_tof(t).*...
                        (r > rm).*(r < obj.Vs.toroidal(j).get_r(t));
            end
        end
        v = v + obj.Vs.toroidal(end).get_v(t).*(r > obj.Vs.toroidal(end).get_r(t));
    end
end

end

