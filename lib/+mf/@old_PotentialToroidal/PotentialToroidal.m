classdef PotentialToroidal
   properties
      params;
      %w = struct('x', 2*pi*0.5*10^(3), ...
      %           'y', 2*pi*0.5*10^(3), ...
      %           'z', 2*pi*1.58*10^(3));
      w;
      l;
      tof = struct('start', 1, ...
                   'end', 1.1);


      
      R = 19.23*10^(-6);
      grid;
      config; 
   end
   methods
      function obj = PotentialToroidal(params)
          if nargin == 1
              if isfield(params, 'w')
                  w = params.w;
              end
              if isfield(params, 'R')
                  obj.R = params.R;
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
              obj.R = obj.config.to_length_dim(obj.R);
              obj.tof.start = obj.config.to_time_dim(obj.tof.start);
              obj.tof.end = obj.config.to_time_dim(obj.tof.end);
          end
      end
   end
end