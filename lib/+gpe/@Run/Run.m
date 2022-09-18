classdef Run
   properties
      model; 
      config;
      grid;
      
      dt = 5*10^-6; % time step
      dt_f; % time step (with gamma included)
      inv_td;
      ekk;
      
      dt_itp = 2*10^(-5); % time step for ITP
      n_iter = 500;
      
      sigma;

   end
   methods
      function obj = Run(params)
          if nargin == 1
              if isfield(params, 'model')
                  obj.model = params.model;
              end
          end
          obj.config = obj.model.config;
          obj.grid = obj.model.grid;
          
          obj.dt_f = obj.dt*1i/(1+1i*obj.config.gamma);% time step (with gamma included)
          obj.ekk = exp(-0.5 *(obj.config.hbar/obj.config.M) * ...
                        obj.grid.kk*obj.dt_f);
          obj.inv_td = 1/(obj.config.td);
          
          obj.sigma = sqrt(obj.config.gamma*...
                          (obj.config.hbar*obj.config.kb*obj.config.T)/...
                          (obj.grid.dV*obj.dt));
      end
   end
end