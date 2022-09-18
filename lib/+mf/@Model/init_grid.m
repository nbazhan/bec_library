function grid = init_grid(obj, grid)

% init space grid
L = obj.to_length_dim(grid.L);
grid.L = struct('x', L(1), 'y', L(2), 'z', L(3));
grid.N = struct('x', grid.N(1), 'y', grid.N(2), 'z', grid.N(3));

grid.r = struct('x', linspace(-grid.L.x/2, grid.L.x/2, grid.N.x), ...
                    'y', linspace(-grid.L.y/2, grid.L.y/2, grid.N.y), ...
                    'z', linspace(-grid.L.z/2, grid.L.z/2, grid.N.z));

grid.h = struct('x', grid.r.x(2) - grid.r.x(1), ...
                'y', grid.r.y(2) - grid.r.y(1), ...
                'z', grid.r.z(2) - grid.r.z(1));

if obj.D == 2
    grid.dV = grid.h.x * grid.h.y;
    [grid.X, grid.Y] = meshgrid(grid.r.x, grid.r.y);
else
    grid.dV = grid.h.x * grid.h.y * grid.h.z;
    [grid.X, grid.Y, grid.Z] = meshgrid(grid.r.x, ...
                                        grid.r.y, ...
                                        grid.r.z);
end

if grid.GPU
    grid.X = gpuArray(grid.X);
    grid.Y = gpuArray(grid.Y);
    if obj.D == 3
        grid.Z = gpuArray(grid.Z);
    end
end

% init momentum grid (works only for even N)
grid.k = struct('x', (2*pi/(grid.L.x + grid.h.x))*...
                     [(0 : grid.N.x/2) -(grid.N.x/2 - 1 : -1 : 1)], ...
                'y', (2*pi/(grid.L.y + grid.h.y))*...
                     [(0 : grid.N.y/2) -(grid.N.y/2 - 1 : -1 : 1)], ...
                'z', (2*pi/(grid.L.z + grid.h.z))*...
                     [(0 : grid.N.z/2) -(grid.N.z/2 - 1 : -1 : 1)]);
              
if obj.D == 2
    [KX, KY] = meshgrid(grid.k.x , grid.k.y);
    grid.kk = (KX.^2 + KY.^2)/2; 
elseif obj.D == 3
    [KX, KY, KZ] = meshgrid(grid.k.x , grid.k.y, grid.k.z);
    grid.kk = gpuArray((KX.^2 + KY.^2 + KZ.^2)/2); 
end

if grid.GPU
    grid.kk = gpuArray(grid.kk); 
end

end