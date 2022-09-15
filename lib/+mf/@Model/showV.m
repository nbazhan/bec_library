function showV(obj, t)
% show potential images from 2 sides
V = obj.getV(t);
figure('Position', [300 300 800 300])
          
subplot(1, obj.grid.D - 1, 1)
if obj.grid.D == 2
    Vxy = V(:, :);
elseif obj.grid.D == 3
    Vxy = V(:, :, obj.grid.N.z/2);
end
imagesc(obj.grid.r.x, obj.grid.r.y, Vxy)
axis square;
xlabel('x, $l_r$', 'interpreter', 'latex')
ylabel('y, $l_r$', 'interpreter', 'latex')
c = colorbar;
ylabel(c, 'V, $\hbar \omega_r$', 'interpreter', 'latex')
          
if obj.grid.D == 3
    subplot(1, obj.grid.D - 1, 2)
    Vxz = squeeze(V(:, obj.grid.N.y/2, :))';
    imagesc(obj.grid.r.x, obj.grid.r.z, Vxz)
    axis square;
    xlabel('x, $l_r$', 'interpreter', 'latex')
    ylabel('z, $l_r$', 'interpreter', 'latex')
    c = colorbar;
    ylabel(c, 'V, $\hbar \omega_r$', 'interpreter', 'latex')
end
        
shg
end