function [r, h, dV] = initR(obj)
r = struct('x', linspace(-obj.L.x/2, obj.L.x/2, obj.N.x), ...
           'y', linspace(-obj.L.y/2, obj.L.y/2, obj.N.y));
h = struct('x', r.x(2)-r.x(1), ...
           'y', r.y(2)-r.y(1));
dV = h.x * h.y;
if obj.config.D == 3
    r.z = linspace(-obj.L.z/2, obj.L.z/2, obj.N.z);
    h.z = r.z(2) - r.z(1);
    dV = dV * h.z;
end
end
