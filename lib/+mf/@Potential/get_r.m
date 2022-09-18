function r = get_r(obj, t)
phi = atan2(obj.model.grid.Y, obj.model.grid.X);
if obj.R.x <= 0 && obj.R.y <= 0
    r2 = 0;
else
    r2 = obj.R.x^2*obj.R.y^2./...
        ((obj.R.y*cos(obj.W*t - phi)).^2 + ...
         (obj.R.x*sin(obj.W*t - phi)).^2);
end
r = sqrt(r2);
end