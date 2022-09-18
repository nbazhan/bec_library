function Ub = getAllUb(obj, t)
% get Ub amplitudes of all vertical barriers
Ub = zeros(1, length(obj.Vbs));
for i = 1:length(obj.Vbs)
    Ub(i) = obj.Vbs(i).getU(t);
end
end

