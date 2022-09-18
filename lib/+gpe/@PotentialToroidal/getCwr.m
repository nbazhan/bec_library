function Cwr = getCwr(obj, t)
if t <= obj.t_start
    Cwr = 1;
elseif t < obj.t_end
    Cwr = 1 - (t - obj.tstart)/(obj.t_end - obj.t_start);
else
    Cwr = 0;
end
end