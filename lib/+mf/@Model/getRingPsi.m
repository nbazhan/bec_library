function Psi_i = getRingPsi(obj, Psi, i, t)
% returns Psi with only 1 ring Vts(i)
    if i <= length(obj.Vts)
        %R = sqrt(obj.grid.X.^2 + obj.grid.Y.^2);
        R = sqrt((obj.grid.X - obj.Vts(i).getRc(t).x).^2 + ...
                 (obj.grid.Y - obj.Vts(i).getRc(t).y).^2);
        
        lim_bottom = 0;
        lim_top = min(obj.grid.L.x, obj.grid.L.y);
        
        if i > 1
            lim_bottom = obj.Vts(i).getR(t) - ...
                         abs(obj.Vts(i).getR(t) - obj.Vts(i - 1).getR(t))/4;
        end
        
        if i < length(obj.Vts)
            lim_top =  obj.Vts(i).getR(t) + ...
                       abs(obj.Vts(i + 1).getR(t) - obj.Vts(i).getR(t))/4;
        end
        Psi_i = Psi.*(R > lim_bottom).*(R < lim_top);

    end
end

