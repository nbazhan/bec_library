classdef Run < handle
   properties
      model; 

      dt = 2*10^-6;
      dt_f; % time step (with gamma included)
      inv_td;
      ekk;

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
          
          obj.inv_td = 1/(obj.model.config.td);
          
          obj.dt = obj.config.to_time_dim(obj.dt);
          obj.dt_f = obj.dt*1i/(1 + 1i*obj.model.config.gamma);% time step (with gamma included)
          
          obj.ekk = exp(-obj.model.grid.kk*obj.dt_f);
          
          obj.sigma = sqrt(obj.model.config.gamma*...
                          (obj.model.config.hbar*obj.model.config.kb*obj.model.config.T)/...
                          (obj.model.grid.dV*obj.dt));
      end
   end
end