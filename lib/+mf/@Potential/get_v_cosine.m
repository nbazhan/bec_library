function v = get_v_cosine(obj, t)

u = obj.get_u(t);

at = atan2(obj.model.grid.Y, obj.model.grid.X);
v = u*cos(obj.n*at - obj.W*t + obj.phi);

end