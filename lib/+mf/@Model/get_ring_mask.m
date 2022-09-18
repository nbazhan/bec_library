function mask_i = get_ring_mask(obj, i, t)
% returns Psi with only 1 ring Vts(i)
    if i <= length(obj.Vs.toroidal)
        %R = sqrt(obj.grid.X.^2 + obj.grid.Y.^2);
        r = sqrt((obj.grid.X - obj.Vs.toroidal(i).get_rc(t).x).^2 + ...
                 (obj.grid.Y - obj.Vs.toroidal(i).get_rc(t).y).^2);
        
        lim_bottom = 0;
        lim_top = min(obj.grid.L.x, obj.grid.L.y);
        
        if i > 1
            lim_bottom = obj.Vs.toroidal(i).get_r(t) - ...
                         abs(obj.Vs.toroidal(i).get_r(t) - obj.Vs.toroidal(i - 1).get_r(t))/4;
        end
        
        if i < length(obj.Vs.toroidal)
            lim_top =  obj.Vs.toroidal(i).get_r(t) + ...
                       abs(obj.Vs.toroidal(i + 1).get_r(t) - obj.Vs.toroidal(i).get_r(t))/4;
        end
        mask_i = (r > lim_bottom).*(r < lim_top);

    end
end

