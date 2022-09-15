function V = getV(obj, t)

U = obj.getU(t);

phi = 2*pi/obj.n;
at = atan2(obj.grid.Y, obj.grid.X);

V = U*cos(obj.phi0(ceil(obj.n/2))).*ones(size(obj.grid.X));
for i = 0 : floor(obj.n/2) - 1
    V( i*phi <= at & at < (i + 1)*phi) = U*cos(obj.phi0(i + 1));
    V( -i*phi >= at & at > -(i + 1)*phi) = U*cos(obj.phi0(end - i));
end

end