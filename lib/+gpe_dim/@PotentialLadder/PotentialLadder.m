classdef PotentialLadder
   properties
      params;
      n = 6;
      k = 1;
      U_max = 10.6*2*pi*123*1.054*10^(-34);
      phi0;
      t_start = 0;
      t_max_start = 0.02;
      t_max_end = 0.04;
      t_end = 0.06;
      R_min = 0;
      grid;
      config; 
   end
   methods
      function obj = PotentialLadder(params)
          if nargin == 1
              if isfield(params, 'grid')
                  obj.grid = params.grid;
              end
              if isfield(params, 'config')
                  obj.config = params.config;
              end
              if isfield(params, 't_start')
                  obj.t_start = params.t_start;
              end
              if isfield(params, 't_max_start')
                  obj.t_max_start = params.t_max_start;
              end
              if isfield(params, 't_max_end')
                  obj.t_max_end = params.t_max_end;
              end
              if isfield(params, 't_end')
                  obj.t_end = params.t_end;
              end
              if isfield(params, 'k')
                  obj.k = params.k;
              end
              if isfield(params, 'n')
                  obj.n = params.n;
              end
              if isfield(params, 'phi0')
                  obj.phi0 = params.phi0;
              end
              if isfield(params, 'R_min')
                  obj.R_min = params.R_min;
              end
              if isfield(params, 'U_max')
                  obj.U_max = params.U_max;
              end
              
              % dimensionless parameters
              obj.params = params;
              obj.t_start = obj.config.to_time_dim(obj.t_start);
              obj.t_max_start = obj.config.to_time_dim(obj.t_max_start);
              obj.t_max_end = obj.config.to_time_dim(obj.t_max_end);
              obj.t_end = obj.config.to_time_dim(obj.t_end);
              obj.R_min = obj.config.to_length_dim(obj.R_min);
              obj.U_max = obj.config.to_energy_dim(obj.U_max);
              
              if isempty(obj.phi0)
                  obj.phi0 = obj.k*(2*pi/obj.n)*[0 : obj.n - 1];
              end
          end
      end
   end
end