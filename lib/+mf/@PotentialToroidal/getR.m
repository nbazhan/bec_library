function r = getR(obj, t)
phi = atan2(obj.grid.Y, obj.grid.X);
r2 = obj.R.x^2*obj.R.y^2./...
    ((obj.R.y*cos(obj.W*t - phi)).^2 + ...
     (obj.R.x*sin(obj.W*t - phi)).^2);
r = sqrt(r2);
end