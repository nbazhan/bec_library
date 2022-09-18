function Ut = getAllUt(obj, t)
% get Ub amplitudes of all vertical barriers
Ut = zeros(1, length(obj.Vts));
for i = 1:length(obj.Vts)
    Ut(i) = obj.Vts(i).getU(t);
end
end

