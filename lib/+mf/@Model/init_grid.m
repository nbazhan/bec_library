function init_grid(obj)

% init space grid
L = obj.to_length_dim(obj.grid.L);
obj.grid.L = struct('x', L(1), 'y', L(2), 'z', L(3));
obj.grid.N = struct('x', obj.grid.N(1), 'y', obj.grid.N(2), 'z', obj.grid.N(3));

obj.grid.r = struct('x', linspace(-obj.grid.L.x/2, obj.grid.L.x/2, obj.grid.N.x), ...
                    'y', linspace(-obj.grid.L.y/2, obj.grid.L.y/2, obj.grid.N.y), ...
                    'z', linspace(-obj.grid.L.z/2, obj.grid.L.z/2, obj.grid.N.z));

obj.grid.h = struct('x', obj.grid.r.x(2) - obj.grid.r.x(1), ...
                    'y', obj.grid.r.y(2) - obj.grid.r.y(1), ...
                    'z', obj.grid.r.z(2) - obj.grid.r.z(1));

if obj.D == 2
    obj.grid.dV = obj.grid.h.x * obj.grid.h.y;
    [obj.grid.X, obj.grid.Y] = meshgrid(obj.grid.r.x, obj.grid.r.y);
else
    obj.grid.dV = obj.grid.h.x * obj.grid.h.y * obj.grid.h.z;
    [obj.grid.X, obj.grid.Y, obj.grid.Z] = meshgrid(obj.grid.r.x, ...
                                                    obj.grid.r.y, ...
                                                    obj.grid.r.z);
end

if obj.grid.GPU
    obj.grid.X = gpuArray(obj.grid.X);
    obj.grid.Y = gpuArray(obj.grid.Y);
    if obj.D == 3
        obj.grid.Z = gpuArray(obj.grid.Z);
    end
end

% init momentum grid (works only for even N)
obj.grid.k = struct('x', (2*pi/(obj.grid.L.x + obj.grid.h.x))*...
                         [(0 : obj.grid.N.x/2) -(obj.grid.N.x/2 - 1 : -1 : 1)], ...
                    'y', (2*pi/(obj.grid.L.y + obj.grid.h.y))*...
                         [(0 : obj.grid.N.y/2) -(obj.grid.N.y/2 - 1 : -1 : 1)], ...
                    'z', (2*pi/(obj.grid.L.z + obj.grid.h.z))*...
                         [(0 : obj.grid.N.z/2) -(obj.grid.N.z/2 - 1 : -1 : 1)]);
              
if obj.D == 2
    [KX, KY] = meshgrid(obj.grid.k.x , obj.grid.k.y);
    obj.grid.kk = (KX.^2 + KY.^2)/2; 
elseif obj.D == 3
    [KX, KY, KZ] = meshgrid(obj.grid.k.x , obj.grid.k.y, obj.grid.k.z);
    obj.grid.kk = gpuArray((KX.^2 + KY.^2 + KZ.^2)/2); 
end

if obj.grid.GPU
    obj.grid.kk = gpuArray(obj.grid.kk); 
end

end