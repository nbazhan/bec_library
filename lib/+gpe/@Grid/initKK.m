function kk = initKK(obj)
k = (2*pi/(obj.L + obj.h))*[(0 : obj.N/2) -(obj.N/2 - 1 : -1 : 1)]; 
kz = (2*pi/(obj.Lz + obj.hz))*[(0 : obj.Nz/2) -(obj.Nz/2 - 1 : -1 : 1)];
[KX,KY,KZ] = meshgrid(k,k,kz);
          
if obj.GPU
    kk = gpuArray((KX.^2+KY.^2+KZ.^2)/2); 
else
    kk = ((KX.^2+KY.^2+KZ.^2)/2);
end
end