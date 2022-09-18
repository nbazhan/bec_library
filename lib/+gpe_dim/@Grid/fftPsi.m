function [Psif, kf] = fftPsi(obj, Psi)
kf.x = circshift(obj.k.x, obj.N.x/2 - 1);
kf.y = circshift(obj.k.y, obj.N.y/2 - 1);
if obj.config.D == 2
    Psif = circshift(fftn(Psi), [obj.N.x/2 - 1, obj.N.y/2 - 1]);
elseif obj.config.D == 3
    kf.z = circshift(obj.k.z, obj.N.z/2 - 1);
    Psif = circshift(fftn(Psi), [obj.N.x/2 - 1, obj.N.y/2 - 1, obj.N.z/2 - 1]);
end
end