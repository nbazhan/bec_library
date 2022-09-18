function Psi_i = getRingPsi(obj, Psi, i)
% returns Psi with only 1 ring Vts(i)
    if i <= length(obj.Vts)
        R = sqrt(obj.grid.X.^2 + obj.grid.Y.^2);
        
        lim_bottom = 0;
        lim_top = obj.grid.L;
        
        if i > 1
            lim_bottom = obj.Vts(i).R - ...
                         abs(obj.Vts(i).R - obj.Vts(i - 1).R)/4;
        end
        
        if i < length(obj.Vts)
            lim_top =  obj.Vts(i).R + ...
                       abs(obj.Vts(i + 1).R - obj.Vts(i).R)/4;
        end
        
        Psi_i = Psi.*(R > lim_bottom).*(R < lim_top);

    end
end

