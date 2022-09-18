function psi = get_tf(obj)
psi = (obj.mu - obj.model.get_v(obj.t))/obj.model.config.g;
end