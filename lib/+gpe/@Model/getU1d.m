function U = getU1d(obj, t)
V= obj.getV(t);
U = V(round(obj.grid.N/2), :, round(obj.grid.Nz/2));
end
