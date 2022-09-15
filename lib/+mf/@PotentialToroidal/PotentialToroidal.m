classdef PotentialToroidal
   properties
      params;
      %w = struct('x', 2*pi*0.5*10^(3), ...
      %           'y', 2*pi*0.5*10^(3), ...
      %           'z', 2*pi*1.58*10^(3));
      w; % oscillator w
      l;
      R = [19.23*10^(-6), 19.23*10^(-6)]; % Rx and Ry of ellipse
      W = 0; % angular velocity of rotation around itself
      U = struct('max', 0, ...
                 't', [0, 0, 0, 0]);
      tof = struct('start', 1, ...
                   'end', 1.1);          
      Rc = [0, 0]; %radius of rotating around xyc
      xyc = [0, 0]; % center of rotation
      Wc = 0; % angular velocity of rotating center
      grid;
      config; 
   end
   methods
      function obj = PotentialToroidal(params)
          if nargin == 1
              if isfield(params, 'w')
                  w = params.w;
              end
              if isfield(params, 'W')
                  obj.W = params.W;
              end
              if isfield(params, 'R')
                  obj.R = params.R;
              end
              if isfield(params, 'Wc')
                  obj.Wc = params.Wc;
              end
              if isfield(params, 'Rc')
                  obj.Rc = params.Rc;
              end
              if isfield(params, 'xyc')
                  obj.xyc = params.xyc;
              end
              if isfield(params, 'U')
                  obj.U = params.U;
              end
              if isfield(params, 'tof')
                  obj.tof = struct('start', params.tof(1), ...
                                   'end', params.tof(2));
              end
              if isfield(params, 'grid')
                  obj.grid = params.grid;
              end
              if isfield(params, 'config')
                  obj.config = params.config;
              end
              
              obj.params = params;
              obj.w = struct('r', w(1), ...
                             'z', w(2));
                         
              l = sqrt(obj.config.hbar/obj.config.M./w);
              obj.l = struct('r', l(1), ...
                             'z', l(2));
              
              % dimensionless parameters
              obj.W = obj.config.to_omega_dim(obj.W);
              obj.Wc = obj.config.to_omega_dim(obj.Wc);
              obj.R =  struct('x', obj.config.to_length_dim(obj.R(1)), ...
                              'y', obj.config.to_length_dim(obj.R(2)));
              obj.Rc =  struct('x', obj.config.to_length_dim(obj.Rc(1)), ...
                               'y', obj.config.to_length_dim(obj.Rc(2)));
              obj.xyc =  struct('x', obj.config.to_length_dim(obj.xyc(1)), ...
                                'y', obj.config.to_length_dim(obj.xyc(2)));
              obj.U = struct('max', obj.config.to_energy_dim(obj.U.max),...
                             't', obj.config.to_time_dim(obj.U.t));
              obj.tof.start = obj.config.to_time_dim(obj.tof.start);
              obj.tof.end = obj.config.to_time_dim(obj.tof.end);
          end
      end
   end
end