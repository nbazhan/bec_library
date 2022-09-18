function V = getV(obj)

V = obj.getVr();
if obj.config.D == 3
    V = V + obj.getVz();
end
end