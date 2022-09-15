function V = getV(obj, t)
V = obj.getVr(t);
if obj.config.D == 3
    V = V + obj.getVz();
end
V = V + obj.getU(t);
end