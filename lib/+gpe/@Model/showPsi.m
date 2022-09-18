function showPsi(obj, Psi)
% show potential images from 2 sides

% get dimensionless parameters
%[l, E] = obj.getDimless();
l = 1;
E = 1;

r = obj.grid.r/l;
rz = obj.grid.rz/l;
Psixy = Psi(:, :, obj.grid.Nz/2)/E;
Psixz = squeeze(Psi(:, obj.grid.N/2, :))'/E;
          
figure('Position', [300 300 800 300])
          
subplot(1, 2, 1)
imagesc(r, r, abs(Psixy).^2)
axis square;
xlabel('x, $l_r$', 'interpreter', 'latex')
ylabel('y, $l_r$', 'interpreter', 'latex')
c = colorbar;
ylabel(c, '$\mid \Psi \mid^2$, $\hbar \omega_r$', 'interpreter', 'latex')
          
subplot(1, 2, 2)
imagesc(r, rz, abs(Psixz).^2)
axis square;
xlabel('x, $l_r$', 'interpreter', 'latex')
ylabel('z, $l_r$', 'interpreter', 'latex')
c = colorbar;
ylabel(c, '$\mid \Psi \mid^2$, $\hbar \omega_r$', 'interpreter', 'latex')
        
shg
end