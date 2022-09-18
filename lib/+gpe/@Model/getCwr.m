function Cwr = getCwr(obj, t)
% coefficient for wr for merging the rings
if t <= obj.t_start
    Cwr = 1;
elseif t < obj.t_end
    Cwr = 1 - (t - obj.t_start)/(obj.t_end - obj.t_start);
else
    Cwr = 0;
end
end