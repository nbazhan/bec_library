function savePic(obj, Psi, s, t)
cr = 10^6;

PsiXY = sum(abs(Psi).^2, 3);
PsiXZ = squeeze(sum(abs(Psi).^2, 2)).';

PhaseXY = angle(Psi(:, :, obj.grid.Nz/2));
PhaseXZ = squeeze(angle(Psi(:, obj.grid.N/2, :))).';

f = figure('visible', 'off', 'Position', [10 10 600 600]);
p = uipanel('Parent',f,'BorderType','none'); 
p.Title = ['t = ', num2str(t, '%0.3f'), ' s']; 
p.TitlePosition = 'centertop'; 
p.FontSize = 24;
          
subplot(2,2,1, 'Parent',p);
imagesc(cr*obj.grid.r, cr*obj.grid.r, PsiXY);
axis image;
ylabel('y, $\mu m$', 'interpreter', 'latex');
xlabel('x, $\mu m$', 'interpreter', 'latex');
set(gca,'YDir','normal')

subplot(2,2,3, 'Parent',p);
imagesc(cr*obj.grid.r, cr*obj.grid.rz, PsiXZ);
axis image;
ylabel('z, $\mu m$', 'interpreter', 'latex');
xlabel('x, $\mu m$', 'interpreter', 'latex');

subplot(2,2,2, 'Parent',p);
imagesc(cr*obj.grid.r, cr*obj.grid.r, PhaseXY);
axis image;
ylabel('y, $\mu m$', 'interpreter', 'latex');
xlabel('x, $\mu m$', 'interpreter', 'latex');
set(gca,'YDir','normal')

subplot(2,2,4, 'Parent',p);
imagesc(cr*obj.grid.r, cr*obj.grid.rz, PhaseXZ);
axis image;
ylabel('z, $\mu m$', 'interpreter', 'latex');
xlabel('x, $\mu m$', 'interpreter', 'latex');
set(gca,'YDir','normal')

saveas(f,[obj.Pictures,'Pic' num2str(s) '.png']);
clear f;
end