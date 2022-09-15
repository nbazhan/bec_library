classdef Model < handle
   properties
       config;
       grid;
       
       tof;
       M = []; %initial topological charge
       
       Vts;% array with all Toroidal Potentials
       Vbs;% array with all Vertical Potentials
       Vls;% array with all Ladder Potentials
       Vcs;% array with all Cosine Potentials
   end
   methods
      function obj = Model(params)
          if nargin == 1
              if isfield(params, 'config')
                  obj.config = params.config;
              end
              if isfield(params, 'grid')
                  obj.grid = params.grid;
              end
              if isfield(params, 'tof')
                  obj.tof = params.tof;
              end
              if isfield(params, 'M')
                  obj.M = params.M;
              end
          end
      end
      
      function H = applyham(obj, psi, V)
           Hk = conj(psi).*ifftn(obj.grid.kk.*fftn(psi));
           Hi = conj(psi).*V.*psi;
           H = Hk + Hi;
      end
   end
end