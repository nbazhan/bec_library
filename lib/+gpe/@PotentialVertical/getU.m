function U = getU(obj, t)
if t < obj.t_start
    U = 0;
elseif t <= obj.t_max_start
    if obj.t_start == obj.t_max_start
        U = obj.U_max;
    else
        U = obj.U_max*((t - obj.t_start)/...
                   (obj.t_max_start - obj.t_start));
    end
elseif t <= obj.t_max_end
    U = obj.U_max;
elseif t <= obj.t_end
    U = obj.U_max*((obj.t_end - t)/...
                   (obj.t_end - obj.t_max_end));
else
    U = 0;
end
end