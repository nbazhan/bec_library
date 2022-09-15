function [X, Y] = initXY(obj)
[X, Y] = meshgrid(obj.r.x, obj.r.y);
if obj.GPU
    X = gpuArray(X);
    Y = gpuArray(Y);
end
end
