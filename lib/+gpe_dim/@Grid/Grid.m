classdef Grid
   properties
       params;
       config;
       GPU = 1; 
       L;
       N;
             
       r = struct();
       k = struct();
       h = struct();
       X;
       Y;
       Z;
       dV;
       kk;
   end
   methods
      function obj = Grid(params)
          if nargin == 1
              if isfield(params, 'GPU')
                  obj.GPU = params.GPU;
              end
              if isfield(params, 'config')
                  obj.config = params.config;
              end
              if isfield(params, 'L')
                  L = params.L;
              end
              if isfield(params, 'N')
                  N = params.N;
              end
          end
          obj.params = params;
          
          obj.L = struct('x', obj.config.to_length_dim(L(1)), ...
                         'y', obj.config.to_length_dim(L(2)), ...
                         'z', obj.config.to_length_dim(L(3)));
          obj.N = struct('x', N(1), 'y', N(2), 'z', N(3));
          [obj.r, obj.h, obj.dV] = obj.initR();
          if obj.config.D == 2
              [obj.X, obj.Y] = obj.initXY();
          else
              [obj.X, obj.Y, obj.Z] = obj.initXYZ();
          end
          [obj.k, obj.kk] = obj.initKK();
      end
   end
end