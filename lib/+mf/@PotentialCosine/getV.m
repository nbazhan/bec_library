function V = getV(obj, t)

U = obj.getU(t);

at = atan2(obj.grid.Y, obj.grid.X);
r = sqrt(obj.grid.X.^2 + obj.grid.Y.^2);

V = U*cos(obj.k*at - obj.w*t + obj.phi).*exp(-(r - obj.R).^2/(2*obj.a^2));
end