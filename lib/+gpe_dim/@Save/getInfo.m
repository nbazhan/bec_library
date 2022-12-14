function [info] = getInfo(obj)
    info = ['General configurations:', newline,...
            '-----------------------', newline, ...
            num2str(obj.config.D), 'D problem', newline, ...
             'N = ', num2str(obj.config.N), newline, ...
             'T = ', num2str(obj.config.to_temp(obj.config.T)), ' K', newline, ...
             newline];

    if ~isempty(obj.model.Vts)
        info = [info, 'Toroidal Potentials:', newline, ...
                      '--------------------', newline];
    end
    for i = 1:length(obj.model.Vts)
        Vt = obj.model.Vts(i);
        R = obj.config.to_length(Vt.R.x);
        W = obj.config.hbar/(obj.config.M*R^2);
        info = [info, ...
                '(wr', num2str(i), ', wz', num2str(i), ')', ...
                ' = 2*pi*(', num2str(Vt.w.r/(2*pi)), ...
                ', ', num2str(Vt.w.z/(2*pi)), ') Hz', newline, ...
                'R', num2str(i), ' = ', num2str(R, '%.2g'), ' m', newline,...
                'Rotating quantum:', newline, ...
                'W', num2str(i), ' = 2*pi*', num2str(W/(2*pi), '%.2f'), ' Hz', newline, ...
                 newline];
    end
    
    if ~isempty(obj.model.Vbs) && abs(obj.model.Vbs(1).U_max) > 0
        info = [info, 'Vertical Potentials:', newline, ...
                      '--------------------', newline];
    end
    for i = 1:length(obj.model.Vbs)
        Vb = obj.model.Vbs(i);
        U_max = obj.config.to_energy(Vb.U_max);
        if abs(U_max) > 0
            a_max = obj.config.to_length(Vb.a_max);
            t_start = obj.config.to_time(Vb.t_start);
            t_max_start = obj.config.to_time(Vb.t_max_start);
            t_max_end = obj.config.to_time(Vb.t_max_end);
            t_end = obj.config.to_time(Vb.t_end);
            info = [info, ...
                    'W', num2str(i), ' = 2*pi*', num2str(Vb.w/(2*pi)), ' Hz', newline, ...
                    'U_max', num2str(i), ' = ', num2str(U_max, '%.2g'), ' J', newline, ...
                    'a_max', num2str(i), ' = ', num2str(a_max, '%.2g'), ' m', newline, ...
                    'Protocol: [', num2str(t_start, '%.2g'), ', ', ...
                                   num2str(t_max_start, '%.2g'), ', ', ...
                                   num2str(t_max_end, '%.2g'), ', ', ...
                                   num2str(t_end, '%.2g'), ']', newline, ...
                     newline];
        end
    end
    
    if ~isempty(obj.model.Vls) && abs(obj.model.Vls(1).U_max) > 0
        info = [info, 'Ladder Potentials:', newline, ...
                      '--------------------', newline];
    end
    for i = 1:length(obj.model.Vls)
        Vl = obj.model.Vls(i);
        U_max = obj.config.to_energy(Vl.U_max);
        if abs(U_max) > 0
            t_start = obj.config.to_time(Vl.t_start);
            t_max_start = obj.config.to_time(Vl.t_max_start);
            t_max_end = obj.config.to_time(Vl.t_max_end);
            t_end = obj.config.to_time(Vl.t_end);
            
            text_phi0 = '[';
            for ii = 1:size(Vl.phi0)
                text_phi0 = [text_phi0 num2str(Vl.phi0(ii), '%.2f') ', '];
            end
            text_phi0 = [text_phi0(1:end-2) ']'];
            
            info = [info, ...
                    'U_max', num2str(i), ' = ', num2str(U_max, '%.2g'), ' J', newline, ...
                    'n', num2str(i), ' = ', num2str(Vl.n, '%.2g'), ' m', newline, ...
                    'Protocol: [', num2str(t_start, '%.2g'), ', ', ...
                                   num2str(t_max_start, '%.2g'), ', ', ...
                                   num2str(t_max_end, '%.2g'), ', ', ...
                                   num2str(t_end, '%.2g'), ']', newline, ...
                     text_phi0, newline, ...
                     newline];
        end
    end
    
    info = [info, 'System parameters:', newline, ...
                  '------------------', newline, ...
                  '(Nx, Ny, Nz) = (', num2str(obj.grid.N.x), ', ', ...
                                      num2str(obj.grid.N.y), ', ', ...
                                      num2str(obj.grid.N.z), ')', newline, ...
                  'folder = ', obj.Folder];
end


