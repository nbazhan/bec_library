function saveIlls(obj)
load([obj.Data, 't.mat'], 'ts')
load([obj.Data, 'l.mat'], 'ls')
load([obj.Data, 'mu.mat'], 'mus')

font = 15;
width = 1.5;
colors = [[0, 0, 0];
          [0.4940, 0.1840, 0.5560];
          [0.4660, 0.6740, 0.1880];
          [0.6350, 0.0780, 0.1840];];

light_colors = [[0.9290, 0.6940, 0.1250];
                [0.3010, 0.7450, 0.9330];];

sf = length(ts);
for s = 1:sf
    coli = 1;
    light_coli = 1;
    
    xts = obj.config.to_time(ts)*1000;
    t = xts(s);
    load([obj.PsiMat, 'Psi', num2str(s), '.mat'], 'Psi')

    f = figure('visible', 'off', 'Position', [10 10 700 600]);
    p = uipanel('Parent', f, 'BorderType', 'none'); 
    p.Title = ['t = ', num2str(t, '%0.0f'), ' ms']; 
    p.TitlePosition = 'centertop'; 
    p.FontSize = 24;

    if obj.config.D == 2
        PsiXY = sum(abs(Psi).^2, 3);
        PhaseXY = angle(Psi);
    elseif obj.config.D == 3
        PsiXY = sum(abs(Psi(:, :, obj.grid.N.z/2)).^2, 3);
        PhaseXY = angle(Psi(:, :, obj.grid.N.z/2));
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
    imagesc(obj.grid.r.x, obj.grid.r.y, PhaseXY);
    axis image;
    ylabel('y, $\mu m$', 'interpreter', 'latex', ...
                         'FontSize', font);
    xlabel('x, $\mu m$', 'interpreter', 'latex', ...
                         'FontSize', font);
    set(gca,'YDir','normal')
    set(gca,'FontSize', font)
    c = colorbar('Location','eastoutside');
    c.Position = c.Position + [.05 0 0 0];
    caxis([-pi, pi])

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
    xlim([min(xts), max(xts)])
    grid on;
    
    plot(xts(s)*[1, 1], [min(ls(:))-1, max(ls(:))+1], ...
                    'Color', '#77AC30', ...
                    'LineWidth', 0.8*width, ...
                    'LineStyle', '--')
    hold on
    leg{end + 1} = 'cursor';

    yyaxis right
    lims = [0, 0];

    if ~isempty(obj.model.Vbs) && abs(obj.model.Vbs(1).U_max) > 0
        load([obj.Data, 'Ub.mat'], 'Ubs')
        plot(xts, Ubs, 'Color', colors(coli, :), ...
                  'LineWidth', width);   
        hold on;
        leg{end + 1} = '$U_b$';
        lims = [min(min(Ubs), lims(1)), max(max(Ubs), lims(2))];
        coli = coli + 1;
    end
    
    if ~isempty(obj.model.Vls) && abs(obj.model.Vls(1).U_max) > 0
        load([obj.Data, 'Ul.mat'], 'Uls')
        plot(xts, Uls, 'Color', colors(coli, :), ...
                  'LineWidth', width);
        hold on;
        leg{end + 1} = '$U_l$';
        lims = [min(min(Uls), lims(1)), max(max(Uls), lims(2))];
        coli = coli + 1;
    end
    
    if ~isempty(obj.model.Vts)
        load([obj.Data, 'Ut.mat'], 'Uts')
        for uti = 1 : size(Uts, 2) 
            if  abs(obj.model.Vts(uti).U.max) > 0
                plot(xts, Uts(:, uti), 'Color', colors(coli, :), ...
                          'LineWidth', width);
                hold on;
                leg{end + 1} = ['$U_t^', num2str(uti), '$'];
                lims = [min(min(Uts(:, uti)), lims(1)), max(max(Uts(:, uti)), lims(2))];
                coli = coli + 1;
            end
        end
    end
    
    
    for mui = 1 : size(mus, 2) 
        plot(xts, mus(:, mui), 'Color', light_colors(light_coli, :), ...
                               'LineWidth', width, 'LineStyle', ':');
        hold on;
        leg{end + 1} = ['$\mu^', num2str(mui), '$'];
        lims = [min(min(mus(:, mui)), lims(1)), max(max(mus(:, mui)), lims(2))];
        light_coli = light_coli + 1;
    end
    ylim([lims(1) - 0.1*abs(lims(1)), lims(2) + 0.1*abs(lims(2))])
    set(gca,'FontSize', font)
    ylabel('$U, \hbar \omega_r$', 'interpreter', 'latex', ...
                    'FontSize', font);
    xlabel('t, ms', 'interpreter', 'latex', ...
                         'FontSize', font);
    
    legend(leg, ...
                'interpreter', 'latex', ...
                'FontSize', 0.9*font, ...
                'Orientation','horizontal', ...
                'Location','southeast')
   
    
    saveas(f,[obj.Ills, 'Ill' num2str(s) '.png']);
    disp([num2str(s), ':', num2str(sf),' saved illustration'])
end
end