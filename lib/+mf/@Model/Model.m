classdef Model < handle
   properties

       D = 3; % dimensions 
       l = struct('r', 1e-6, 'z', 0.5e-6); % oscillator length
       w;
       test = 0; % if test - 
       
       config = struct('hbar', 1.054571800e-34, ... % Planck constant
                       'kb', 1.38064852e-23, ... % Boltzmann constant
                       'amu', 1.660539040e-27, ... % atomic mass unit
                       'a0', 5.2917721067e-11, ... % Bohr radius
                       'td',  10, ... % sec, time of decay
                       'gamma', 0.05, ... % dissipation parameter
                       'T', 0, ... % temperature
                       'che', 'Rb87', ... % type of atoms (chemical element)
                       'N', 80000)% N particles
      
       grid = struct('GPU', 1, ...
                     'N', [128, 128, 32], ...
                     'L', [100e-6, 100e-6, 30e-6]);
       
       Vs;
   end
   methods
      function obj = Model(params)
          if nargin == 1
              if isfield(params, 'config')
                  obj.config = util.add_struct(obj.config, params.config);
              end
              if isfield(params, 'grid')
                  obj.grid = util.add_struct(obj.grid, params.grid);
              end
              if isfield(params, 'test')
                  obj.test = params.test;
              end
              if isfield(params, 'D')
                  obj.D = params.D;
              end
              if isfield(params, 'w')
                  obj.w = struct('r', params.w(1), ...
                                 'z', params.w(2));
              end
              if isfield(params, 'l')
                  obj.l = struct('r', params.l(1), ...
                                 'z', params.l(2));
              end
          end

          obj.init_config();
          obj.init_grid();
          %obj.init_grid_nt();
      end

      
      function H = applyham(obj, psi, V)
           Hk = conj(psi).*ifftn(obj.grid.kk.*fftn(psi));
           Hi = conj(psi).*V.*psi;
           H = Hk + Hi;
      end
      

      %% converting functions  
      % convert length
      function converted_length = to_length_dim(obj, length)
          converted_length = length/obj.l.r;
      end

      function length = to_length(obj, converted_length)
          length = converted_length*obj.l.r;
      end

      % convert time
      function converted_time = to_time_dim(obj, time)
          converted_time = time*obj.w.r;
      end

      function time = to_time(obj, converted_time)
          time = converted_time/obj.w.r;
      end

      % convert energy
      function converted_energy = to_energy_dim(obj, energy)
          converted_energy = energy/(obj.config.hbar*obj.w.r);
      end

      function energy = to_energy(obj, converted_energy)
          energy = converted_energy*obj.config.hbar*obj.w.r;
      end

      % convert omega
      function converted_omega = to_omega_dim(obj, omega)
          converted_omega = omega/obj.w.r;
      end

      function omega = to_omega(obj, converted_omega)
          omega = converted_omega*obj.w.r;
      end

      % convert temperature
      function converted_temperature = to_temp_dim(obj, temperature)
          converted_temperature = temperature/(obj.config.hbar*obj.w.r/obj.config.kb);
      end

      function temperature = to_temp(obj, converted_temperature)
          temperature = converted_temperature*obj.config.hbar*obj.w.r/obj.config.kb;
      end

      % convert psi
      function converted_psi = to_psi_dim(obj, psi)
          converted_psi = psi*obj.l.r^1.5;
      end
   end
end