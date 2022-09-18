function Phase = getSecs6(obj, phi)
% n - amount of sectors with random phases
% phi0 - initial angle of starting point

Phase = ones(obj.grid.N, obj.grid.N, obj.grid.Nz);
at = atan(obj.grid.Y./obj.grid.X);

Phase(0 <= at & at < (pi/3) & obj.grid.X > 0) = exp(1i*phi(1));
Phase((pi/3) <= abs(at) & obj.grid.Y > 0) = exp(1i*phi(2));
Phase((-pi/3)<=at & at <=0 & obj.grid.X < 0) = exp(1i*phi(3));
Phase(0 <= at & at < (pi/3) & obj.grid.X < 0) = exp(1i*phi(4));
Phase((pi/3) <= abs(at) & obj.grid.Y < 0) =  exp(1i*phi(5));
Phase((-pi/3) <= at & at <=0 & obj.grid.X > 0) = exp(1i*phi(6));
end

