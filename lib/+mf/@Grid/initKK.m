function [k, kk] = initKK(obj)

k = struct();
k.x = (2*pi/(obj.L.x + obj.h.x))*...
     [(0 : obj.N.x/2) -(obj.N.x/2 - 1 : -1 : 1)]; 
k.y = (2*pi/(obj.L.y + obj.h.y))*...
     [(0 : obj.N.y/2) -(obj.N.y/2 - 1 : -1 : 1)];
 
if obj.config.D == 2
    [KX, KY] = meshgrid(k.x , k.y);
    if obj.GPU
        kk = gpuArray((KX.^2 + KY.^2)/2); 
    else
    	kk = (KX.^2 + KY.^2)/2; 
    end
    
elseif obj.config.D == 3
    k.z = (2*pi/(obj.L.z + obj.h.z))*...
         [(0 : obj.N.z/2) -(obj.N.z/2 - 1 : -1 : 1)];
    [KX, KY, KZ] = meshgrid(k.x , k.y, k.z);
    if obj.GPU
        kk = gpuArray((KX.^2 + KY.^2 + KZ.^2)/2); 
    else
    	kk = (KX.^2 + KY.^2 + KZ.^2)/2; 
    end
end
end