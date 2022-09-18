classdef Config < handle
   properties
       D = 3; % dimensions 
       
       hbar = 1.054571800e-34; % Planck constant
       kb = 1.38064852e-23; % Boltzmann constant
       amu = 1.660539040e-27; % atomic mass unit
       a0 = 5.2917721067e-11; % Bohr radius
       
       %td = 0;
       td = 10; %sec, time of decay
       gamma = 0.05; %dissipation parameter
       T = 0; %temperature
       N = 1.4*10^5;
       mu;
       M;
       as;
       
       l = struct('r', 1e-6, 'z', 0.5e-6);
       w;
       g;

   end
   methods
      function obj = Config(params)
          if nargin == 1
              if isfield(params, 'N')
                  obj.N = params.N;
              end
              if isfield(params, 'mu')
                  obj.mu = params.mu;
              end
              if isfield(params, 'D')
                  obj.D = params.D;
              end
              if isfield(params, 'ChE')
                  if params.ChE == 'Na23'
                      obj.M = 22.9897692809*obj.amu; % mass of sodium-23 atom
                      obj.as = 2.75e-9; % scattering length of sodium-23
                  elseif params.ChE == 'Rb87'
                      obj.M = 86.909180527*obj.amu; % mass of rhubidium-87 atom
                      obj.as = 100.87*obj.a0; %5.77e-9; % scattering length of rhubidium-87
                  end
              end
              if isfield(params, 'gamma')
                  obj.gamma = params.gamma;
              end
              if isfield(params, 'td')
                  obj.td = params.td;
              end
              if isfield(params, 'T')
                  obj.T = params.T;
              end
              if isfield(params, 'w')
                  obj.w = struct('r', params.w(1), ...
                                 'z', params.w(2));
              end
              if ~isempty(obj.w)
                  obj.l.r = sqrt(obj.hbar/(obj.M*obj.w.r));
                  obj.l.z = sqrt(obj.hbar/(obj.M*obj.w.z));
              else
                  obj.w.r = obj.hbar/(obj.M*obj.l.r^2);
                  obj.w.z = obj.hbar/(obj.M*obj.l.z^2);
              end
              
              if obj.D == 2
                  obj.g = sqrt(8*pi)*obj.as/obj.l.z;
              elseif obj.D == 3
                  obj.g = 4*pi*obj.as/obj.l.r;
              end
              
              obj.T = obj.to_temp_dim(obj.T);
              obj.td = obj.to_time_dim(obj.td);
              obj.mu = obj.to_energy_dim(obj.mu);
          end 
      end
   end
end