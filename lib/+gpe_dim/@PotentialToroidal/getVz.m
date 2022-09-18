function V = getVz(obj, varargin)
if size(varargin) == 1
    grid = varargin{1};
else
    grid = obj.grid;
end
V = 0.5*(obj.w.z/obj.config.w.r)^2*grid.Z.^2;
end