function getTOF(obj, Psi, mu, t, dt)
    file = ['TOF_t=', num2str(obj.config.to_time(t), '%.3f'), '.png' ];

    f = figure('visible', 'off', 'Position', [10 10 800 400]);
    p = uipanel('Parent',f,'BorderType','none'); 
    %p.Title = ['t = ', num2str(t, '%0.3f'), ' s']; 
    %p.TitlePosition = 'centertop'; 
    p.FontSize = 24;

    disp('Started cycle')
    t0 = 0;
    for s = 1 : 4
        if s > 1
            [Psi, mu] = obj.runGPE(Psi, mu, t0, t0 + dt);
            t0 = t0 + dt;
            t = t + dt;
        end
        disp(['s = ', num2str(s), ', t = ', num2str(obj.config.to_time(t))])
            
        PsiXY = sum(abs(Psi).^2, 3);
        PhaseXY = angle(Psi(:, :, obj.grid.N.z/2));
        
        subplot(2, 4, s, 'Parent',p);
        imagesc(obj.grid.r.x, obj.grid.r.y, PsiXY);
        axis image;
        ylabel('y, $\mu m$', 'interpreter', 'latex');
        xlabel('x, $\mu m$', 'interpreter', 'latex');
        set(gca,'YDir','normal')
        title(['t = ', num2str(obj.config.to_time(t), '%0.3f'), ' s'])
        
        subplot(2, 4, s + 4, 'Parent',p);
        imagesc(obj.grid.r.x, obj.grid.r.y, PhaseXY);
        axis image;
        ylabel('y, $\mu m$', 'interpreter', 'latex');
        xlabel('x, $\mu m$', 'interpreter', 'latex');
        set(gca,'YDir','normal')
    end
    
saveas(f,file);
clear f;
end