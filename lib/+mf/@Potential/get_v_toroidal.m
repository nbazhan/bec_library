function v = get_v_toroidal(obj, t)

% calculate vr
rc = obj.get_rc(t);
r = ((obj.model.grid.X - rc.x).^2 + (obj.model.grid.Y - rc.y).^2).^0.5;
v = 0.5*(obj.w.r/obj.model.config.w.r)^2*(r - obj.get_r(t)).^2;

% add vz 
if obj.config.D == 3
    v = v + 0.5*(obj.w.z/obj.model.config.w.r)^2*model.grid.Z.^2;
end

% add bias
v = v + obj.get_u(t);
end