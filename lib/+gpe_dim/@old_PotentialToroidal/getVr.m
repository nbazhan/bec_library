function V = getVr(obj, varargin)
if size(varargin) == 1
    grid = varargin{1};
else
    grid = obj.grid;
end
V = 0.5*(obj.w.r/obj.config.w.r)^2*...
        ((grid.X.^2 + grid.Y.^2).^0.5 - obj.R).^2;
end