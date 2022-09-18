function Ul = getAllUl(obj, t)
% get Ub amplitudes of all vertical barriers
Ul = zeros(1, length(obj.Vls));
for i = 1:length(obj.Vls)
    Ul(i) = obj.Vls(i).getU(t);
end
end

