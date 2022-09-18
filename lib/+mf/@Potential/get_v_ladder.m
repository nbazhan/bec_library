function v = get_v_ladder(obj, t, varargin)

u = obj.get_u(t);

if any(strcmp(varargin, 'nt'))
    grid = obj.model.grid_nt;
else
    grid = obj.model.grid;
end

phi = 2*pi/obj.n;
at = atan2(grid.Y, grid.X);

v = u*cos(obj.phi(ceil(obj.n/2))).*ones(size(grid.X));
for i = 0 : floor(obj.n/2) - 1
    v( i*phi <= at & at < (i + 1)*phi) = u*cos(obj.phi(i + 1));
    v( -i*phi >= at & at > -(i + 1)*phi) = u*cos(obj.phi(end - i));
end

end