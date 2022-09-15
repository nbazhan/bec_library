classdef Run < handle
   properties
      model; 
      model_nt;
      config;
      grid;
      grid_nt;
      
      dt = 2*10^-6;
      %dt = 5.474*10^-6; % time step
      dt_f; % time step (with gamma included)
      inv_td;
      ekk;
      
      dt_itp = 2.737*10^(-5); % time step for ITP (0.02)
      n_iter = 500;
      n_iter_fft = 10;
      
      sigma;

   end
   methods
      function obj = Run(params)
          if nargin == 1
              if isfield(params, 'model')
                  obj.model = params.model;
              end
              if isfield(params, 'dt')
                  obj.dt = params.dt;
              end
          end
          obj.config = obj.model.config;
          obj.grid = obj.model.grid;
          
          obj.inv_td = 1/(obj.config.td);
          
          obj.dt_itp = obj.config.to_time_dim(obj.dt_itp);
          
          obj.dt = obj.config.to_time_dim(obj.dt);
          %obj.dt = 0.004;
          obj.dt_f = obj.dt*1i/(1+1i*obj.config.gamma);% time step (with gamma included)
          
          obj.ekk = exp(-obj.grid.kk*obj.dt_f);
          
          obj.sigma = sqrt(obj.config.gamma*...
                          (obj.config.hbar*obj.config.kb*obj.config.T)/...
                          (obj.grid.dV*obj.dt));
          
          params = obj.grid.params;
          params.N = 2.*params.N;
          params.L = 2.*params.L;
          obj.grid_nt = gpe_dim.Grid(params);
          obj.model_nt = gpe_dim.Model(struct('config', obj.config, ...
                                              'grid', obj.grid_nt));
          
          len_Vts = size(obj.model.Vts, 2);
          len_Vbs = size(obj.model.Vbs, 2);
          
          if len_Vts
            for i  = 1 : len_Vts
                params = obj.model.Vts(i).params;
                obj.model_nt.addPotentialToroidal(params);
            end
          end
          
          if len_Vbs
            for i  = 1 : len_Vbs
                params = obj.model.Vbs(i).params;
                obj.model_nt.addPotentialVertical(params);
            end
          end
      end
      
      function res = shrink(obj, psi)
            nx = round(obj.grid.N.x/2);
            ny = round(obj.grid.N.y/2);
            if obj.config.D == 2
                res = psi(nx+1:3*nx,ny+1:3*ny);
            elseif obj.config.D == 3
                nz = round(obj.grid.N.z/2);
                res = psi(nx+1:3*nx,ny+1:3*ny,nz+1:3*nz);
            end
      end
      
      function res = extend(obj, psi)
            nx = round(obj.grid.N.x/2);
            ny = round(obj.grid.N.y/2);
            if obj.grid.D == 2
                res = zeros(4*nx, 4*ny);
                res(nx+1:3*nx,ny+1:3*ny) = psi;
            elseif obj.grid.D == 3
                nz = round(obj.grid.N.z/2);
                res = zeros(4*nx, 4*ny, 4*nz);
                res(nx+1:3*nx,ny+1:3*ny,nz+1:3*nz) = psi;
            end
      end
      
      function H = applyham(obj, psi, V)
           Hk = conj(psi).*ifftn(obj.grid.kk.*fftn(psi));
           Hi = conj(psi).*V.*psi;
           H = Hk + Hi;
      end
   end
end