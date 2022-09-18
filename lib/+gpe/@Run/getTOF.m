function getTOF(obj, Psi, mu, t)
    file = ['TOF_t=', num2str(t, '%.3f'), '.png' ];

    f = figure('visible', 'off', 'Position', [10 10 800 400]);
    p = uipanel('Parent',f,'BorderType','none'); 
    %p.Title = ['t = ', num2str(t, '%0.3f'), ' s']; 
    %p.TitlePosition = 'centertop'; 
    p.FontSize = 24;
    cr = 10^6;
    dt = 0.005;

    disp('Started cycle')
    for s = 1 : 4
        if s > 1
            [Psi, mu] = obj.runGPE(Psi, mu, t, t + dt);
            t = t + dt;
        end
        disp(num2str(t))
            
        PsiXY = sum(abs(Psi).^2, 3);
        PhaseXY = angle(Psi(:, :, obj.grid.Nz/2));
        
        subplot(2, 4, s, 'Parent',p);
        imagesc(cr*obj.grid.r, cr*obj.grid.r, PsiXY);
        axis image;
        ylabel('y, $\mu m$', 'interpreter', 'latex');
        xlabel('x, $\mu m$', 'interpreter', 'latex');
        set(gca,'YDir','normal')
        title(['t = ', num2str(t, '%0.3f'), ' s'])
        
        subplot(2, 4, s + 4, 'Parent',p);
        imagesc(cr*obj.grid.r, cr*obj.grid.r, PhaseXY);
        axis image;
        ylabel('y, $\mu m$', 'interpreter', 'latex');
        xlabel('x, $\mu m$', 'interpreter', 'latex');
        set(gca,'YDir','normal')
    end
    
saveas(f,file);
clear f;
end