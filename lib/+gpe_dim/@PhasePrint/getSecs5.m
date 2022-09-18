function Psi = getSecs5(obj, Psi, phi)
% n - amount of sectors with random phases
% phi0 - initial angle of starting point

Phase = exp(1i*phi(3))*ones(size(Psi));
at = atan2(obj.grid.Y, obj.grid.X);

Phase(0 <= at & at < (2*pi/5)) = exp(1i*phi(1));
Phase((2*pi/5) <= at & at < 2*(2*pi/5)) = exp(1i*phi(2));
Phase(0 > at & at >= -(2*pi/5)) = exp(1i*phi(5));
Phase(-(2*pi/5)> at & at >= -2*(2*pi/5)) = exp(1i*phi(4));

Psi = Psi.*Phase;
end

