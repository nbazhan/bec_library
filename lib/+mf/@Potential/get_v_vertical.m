function V = get_v_vertical(obj, t)
v = 0;
u = obj.get_u(t);
phi = obj.W*obj.model.config.to_time(t);

r2 = obj.model.grid.X.^2 + obj.model.grid.Y.^2;
filter = (r2 >= obj.rlim(1)).*(r2 <= obj.rlim(2));

if obj.n > 0
    for i = 1 : obj.n
        theta =  ((obj.model.grid.X.*cos(phi + obj.phi0(i)) + ...
                   obj.model.grid.Y.*sin(phi + obj.phi0(i))) > 0);
        v = v + u*exp(-(1/(2*obj.width^2))*...
                     (obj.model.grid.X.*sin(phi + obj.phi(i))- ...
                      obj.model.grid.Y.*cos(phi + obj.phi0(i))).^2).*theta;    
    end
end
v = v.*filter;
end