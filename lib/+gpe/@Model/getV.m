function V = getV(obj, t)

V = zeros([obj.grid.N, obj.grid.N, obj.grid.Nz]);

% draws each part of the ring separatly, 
% so their potentials do not intersect
if ~isempty(obj.Vts) 
    R = sqrt(obj.grid.X.^2 + obj.grid.Y.^2);
    V = V + obj.Vts(1).getV().*(R < obj.Vts(1).R);
    if length(obj.Vts) > 1
        for i = 2:length(obj.Vts)
            Rm = 0.5*(obj.Vts(i - 1).R + obj.Vts(i).R);
            V = V + ...
                (obj.Vts(i-1).getVr()*obj.getCwr(t) + ...
                 obj.Vts(i-1).getVz()).*...
                (R > obj.Vts(i - 1).R).*(R < Rm);
            V = V + ...
                (obj.Vts(i).getVr()*obj.getCwr(t) + ...
                 obj.Vts(i).getVz()).*...
                (R > Rm).*(R < obj.Vts(i).R);
        end
    end
    V = V + obj.Vts(end).getV().*(R > obj.Vts(end).R);
end

for i = 1:length(obj.Vbs)
    V = V + obj.Vbs(i).getV(t);
end

end

