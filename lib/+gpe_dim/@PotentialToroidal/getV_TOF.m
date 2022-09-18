function V = getV_TOF(obj, t)
if t <= obj.tof.start
    c = 1;
elseif t < obj.tof.end
    c = 1 - (t - obj.tof.start)/(obj.tof.end - obj.tof.start);
else
    c = 0;
end

%disp(['t = ', num2str(obj.config.to_time(t)), ', c = ', num2str(c)])

V = c*obj.getVr(t);
if obj.config.D == 3
    V = V + obj.getVz();
end
end