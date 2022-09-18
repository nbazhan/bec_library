function saveIllsFourier(obj)
load([obj.Data, 't.mat'], 'ts')
load([obj.Data, 'l.mat'], 'ls')
load([obj.Data, 'mu.mat'], 'mus')

util.createFolder(obj.IllsFourier);

font = 15;
width = 1.5;

sf = length(ts);
for s = 1:sf
    xts = obj.config.to_time(ts)*1000;
    t = xts(s);
    load([obj.PsiMat, 'Psi', num2str(s), '.mat'], 'Psi')

    f = figure('visible', 'off', 'Position', [10 10 700 600]);
    p = uipanel('Parent', f, 'BorderType', 'none'); 
    p.Title = ['t = ', num2str(t, '%0.0f'), ' ms']; 
    p.TitlePosition = 'centertop'; 
    p.FontSize = 24;

    [Psif, kf] = obj.grid.fftPsi(Psi);
    if obj.config.D == 2
        PsiXY = sum(abs(Psi).^2, 3);
        FourierXY = abs(Psif).^2;
    elseif obj.config.D == 3
        PsiXY = sum(abs(Psi(:, :, obj.grid.N.z/2)).^2, 3);
        FourierXY = sum(abs(Psif(:, :, obj.grid.N.z/2)).^2, 3);
    end

    subplot(2, 2, 1, 'Parent', p);
    imagesc(obj.grid.r.x, obj.grid.r.y, PsiXY);
    axis image;
    ylabel('y, $\mu m$', 'interpreter', 'latex', ...
                         'FontSize', font);
    xlabel('x, $\mu m$', 'interpreter', 'latex', ...
                         'FontSize', font);
    set(gca,'YDir','normal')
    set(gca,'FontSize', font)
    c = colorbar('Location','eastoutside');
    c.Position = c.Position + [.05 0 0 0];
    %c.Position = [0.5, 0.5, 0.2, 1];

    subplot(2, 2, 2, 'Parent', p);
    imagesc(kf.x, kf.y, FourierXY);

    axis image;
    ylabel('$k_y$', 'interpreter', 'latex', ...
                         'FontSize', font);
    xlabel('$k_x$', 'interpreter', 'latex', ...
                         'FontSize', font);
    set(gca,'YDir','normal')
    set(gca,'FontSize', font)
    c = colorbar('Location','eastoutside');
    c.Position = c.Position + [.05 0 0 0];

    %% plotting graph
    subplot(2, 2, [3, 4], 'Parent', p);
    
    plot(xts, ls(:, 1), 'Color', 'blue', ...
                       'LineWidth', width);
    hold on
    leg = {'inner'};
 
    if size(ls, 2) > 1
        plot(xts, ls(:, 2), 'Color', 'red', ...
                           'LineWidth', width);
        hold on
        leg{end + 1} = 'outer';
    end
    set(gca,'FontSize', font)
    ylabel('$L_i/N$', 'interpreter', 'latex', ...
                      'FontSize', font);
    ylim([min(min(ls))- 1, max(max(ls))+1])
    xlim([xts(1), xts(end)])
    grid on;
    
    plot(xts(s)*[1, 1], [min(ls(:))-1, max(ls(:))+1], ...
                    'Color', '#77AC30', ...
                    'LineWidth', 0.8*width, ...
                    'LineStyle', '--')
    hold on
    leg{end + 1} = 'cursor';

    yyaxis right
    if ~isempty(obj.model.Vbs) && abs(obj.model.Vbs(1).U_max) > 0
        load([obj.Data, 'Ub.mat'], 'Ubs')
        plot(xts, Ubs, 'Color', 'black', ...
                  'LineWidth', width);   
        hold on;
        leg{end + 1} = '$U_b$';
    end
    
    if ~isempty(obj.model.Vls) && abs(obj.model.Vls(1).U_max) > 0
        load([obj.Data, 'Ul.mat'], 'Uls')
        plot(xts, Uls, 'Color', [0.4940 0.1840 0.5560], ...
                  'LineWidth', width);
        hold on;
        leg{end + 1} = '$U_l$';
    end
    
    plot(xts, mus, 'Color', 'yellow', ...
                  'LineWidth', width, 'LineStyle', ':');
    hold on;
    leg{end + 1} = '$\mu$';
    set(gca,'FontSize', font)
    ylabel('$U, \hbar \omega_r$', 'interpreter', 'latex', ...
                    'FontSize', font);
    xlabel('t, ms', 'interpreter', 'latex', ...
                         'FontSize', font);
    
    legend(leg, ...
                'interpreter', 'latex', ...
                'FontSize', font, ...
                'Orientation','horizontal', ...
                'Location','northeast')
   
    
    saveas(f,[obj.IllsFourier, 'IllFourier' num2str(s) '.png']);
    disp([num2str(s), ':', num2str(sf),' saved illustration fourier'])
end
end