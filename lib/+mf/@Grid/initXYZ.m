function [X, Y, Z] = initXYZ(obj)
[X, Y, Z] = meshgrid(obj.r.x, obj.r.y, obj.r.z);
if obj.GPU
    X = gpuArray(X);
    Y = gpuArray(Y);
Z = gpuArray(Z);
end
end