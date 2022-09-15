function showPsi(obj, Psi)
% show potential images from 2 sides
figure('Position', [300 300 800 300])
          
subplot(1, obj.grid.D - 1, 1)
if obj.config.D == 2
    Psixy = Psi;
elseif obj.config.D == 3
    Psixy = Psi(:, :, obj.grid.N.z/2);
end
imagesc(obj.grid.r.x, obj.grid.r.y, abs(Psixy).^2)
axis square;
xlabel('x, $l_r$', 'interpreter', 'latex')
ylabel('y, $l_r$', 'interpreter', 'latex')
c = colorbar;
ylabel(c, '$\mid \Psi \mid^2$, $\hbar \omega_r$', 'interpreter', 'latex')
          
if obj.config.D == 3
    subplot(1, obj.grid.D - 1, 2)
    Psixz = squeeze(Psi(:, obj.grid.N.y/2, :))';
    imagesc(obj.grid.r.x, obj.grid.r.z, abs(Psixz).^2)
    axis square;
    xlabel('x, $l_r$', 'interpreter', 'latex')
    ylabel('z, $l_r$', 'interpreter', 'latex')
    c = colorbar;
    ylabel(c, '$\mid \Psi \mid^2$, $\hbar \omega_r$', 'interpreter', 'latex')
end

shg
end