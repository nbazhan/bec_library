function L = getL(obj, Psi)

Nbase = obj.getN(Psi);

if obj.config.D == 2
    [grad_Psi_x, grad_Psi_y] = ...
              gradient(Psi, obj.grid.h.x, obj.grid.h.y);
elseif obj.config.D == 3
    [grad_Psi_x, grad_Psi_y, ~] = ...
              gradient(Psi, obj.grid.h.x, obj.grid.h.y, ...
                            obj.grid.h.z);
end
      
Lbase = real(sum(sum(sum( 1i*conj(Psi).*(obj.grid.Y.*grad_Psi_x - ...
             obj.grid.X.*grad_Psi_y))))) * obj.grid.dV;
         
L = Lbase/Nbase;
          
if obj.grid.GPU == 1
    L = gather(L);
end
end 

