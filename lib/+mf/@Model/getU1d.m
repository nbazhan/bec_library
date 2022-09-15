function U = getU1d(obj, t)
V= obj.getV(t);
U = V(round(obj.grid.N.x/2), :, round(obj.grid.N.z/2));
end
