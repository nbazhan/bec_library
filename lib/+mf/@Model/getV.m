function V = getV(obj, t)

if obj.config.D == 2
    V = zeros([obj.grid.N.x, obj.grid.N.y]);
elseif obj.config.D == 3
    V = zeros([obj.grid.N.x, obj.grid.N.y, obj.grid.N.z]);
end

% draws each part of the ring separatly, 
% so their potentials do not intersect
if ~isempty(obj.Vts) 
    R = sqrt((obj.grid.X - obj.Vts(1).getRc(t).x).^2 + ...
             (obj.grid.Y - obj.Vts(1).getRc(t).y).^2);
    V = V + obj.Vts(1).getV(t).*(R < obj.Vts(1).getR(t));
    
    if length(obj.Vts) > 1
        for i = 2:length(obj.Vts)
            R = sqrt((obj.grid.X - obj.Vts(i).getRc(t).x).^2 + ...
                     (obj.grid.Y - obj.Vts(i).getRc(t).y).^2);
            Rm = 0.5*(obj.Vts(i - 1).getR(t) + ...
                      obj.Vts(i).getR(t));
            V = V + ...
                obj.Vts(i-1).getV_TOF(t).*...
                (R > obj.Vts(i - 1).getR(t)).*(R < Rm);
            V = V + ...
                obj.Vts(i).getV_TOF(t).*...
                (R > Rm).*(R < obj.Vts(i).getR(t));
        end
    end
    R = sqrt((obj.grid.X - obj.Vts(end).getRc(t).x).^2 + ...
             (obj.grid.Y - obj.Vts(end).getRc(t).y).^2);
    V = V + obj.Vts(end).getV(t).*(R > obj.Vts(end).getR(t));
end

for i = 1:length(obj.Vbs)
    V = V + obj.Vbs(i).getV(t);
end

for i = 1:length(obj.Vls)
    V = V + obj.Vls(i).getV(t);
end

for i = 1:length(obj.Vcs)
    V = V + obj.Vcs(i).getV(t);
end

end

