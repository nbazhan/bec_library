classdef PotentialCosine
   properties
      params;
      U = struct('max', 0, ...
                 't', [0, 0.02, 0.04, 0.06]);
      k = 1;
      phi = 0;
      R = [0, 0];
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
              if isfield(params, 'k')
                  obj.k = params.k;
              end
              if isfield(params, 'w')
                  obj.w = params.w;
              end
              if isfield(params, 'phi')
                  obj.phi = params.phi;
              end
              if isfield(params, 'R')
                  obj.R = params.R;
              end
              if isfield(params, 'U')
                  obj.U = params.U;
              end
              
              % dimensionless parameters
              obj.params = params;
              obj.w = obj.config.to_omega_dim(obj.w);
              obj.R =  struct('x', obj.config.to_length_dim(obj.R(1)), ...
                              'y', obj.config.to_length_dim(obj.R(2)));
              obj.U = struct('max', obj.config.to_energy_dim(obj.U.max),...
                             't', obj.config.to_time_dim(obj.U.t));
              
          end
      end
   end
end