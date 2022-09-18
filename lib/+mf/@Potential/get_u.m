function U = get_u(obj, t)
if t < obj.U.t(1)
    U = 0;
elseif t <= obj.U.t(2)
    if obj.U.t(1) == obj.U.t(2)
        U = obj.U.max;
    else
        U = obj.U.max*((t - obj.U.t(1))/...
                       (obj.U.t(2) - obj.U.t(1)));
    end
elseif t <= obj.U.t(3)
    U = obj.U.max;
elseif t <= obj.U.t(4)
    U = obj.U.max*((obj.U.t(4) - t)/...
                   (obj.U.t(4) - obj.U.t(3)));
else
    U = 0;
end
end