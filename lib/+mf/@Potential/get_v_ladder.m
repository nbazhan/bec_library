function V = get_v_ladder(obj, t)

u = obj.get_u(t);

phi = 2*pi/obj.n;
at = atan2(obj.model.grid.Y, obj.model.grid.X);

V = u*cos(obj.phi(ceil(obj.n/2))).*ones(size(obj.model.grid.X));
for i = 0 : floor(obj.n/2) - 1
    v( i*phi <= at & at < (i + 1)*phi) = u*cos(obj.phi(i + 1));
    v( -i*phi >= at & at > -(i + 1)*phi) = u*cos(obj.phi(end - i));
end

end