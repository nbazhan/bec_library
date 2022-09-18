classdef Potential < dynamicprops
   properties
      params;
      model;
      typ; % type of potential: toroidal, ladder, cosine, vertical
        
      U = struct('max', 10e-30, ...
                 't', [0, 0.02, 0.04, 0.06]); % amplitude and protocol

   end
   methods
      function obj = Potential(params)
          if nargin == 1
              obj.params = params;
              
              obj.model = params.model;
              obj.typ = params.typ;

              if strcmp(obj.typ, 'toroidal')
                  obj.init_v_toroidal();
              elseif strcmp(obj.typ, 'vertical')
                  obj.init_v_vertical();
              elseif strcmp(obj.typ, 'cosine')
                  obj.init_v_cosine();
              elseif strcmp(obj.typ, 'ladder')
                  obj.init_v_ladder();
              end

              if isfield(params, 'U')
                  obj.U = util.add_struct(obj.U, params.U);
              end
              
              obj.U = struct('max', obj.model.to_energy_dim(obj.U.max),...
                             't', obj.model.to_time_dim(obj.U.t));
              
          end
      end

      function v = get_v(obj, t)
          if strcmp(obj.typ, 'toroidal')
              v = obj.get_v_toroidal(t);
          elseif strcmp(obj.typ, 'vertical')
              v = obj.get_v_vertical(t);
          elseif strcmp(obj.typ, 'cosine')
              v = obj.get_v_cosine(t);
          elseif strcmp(obj.typ, 'ladder')
              v = obj.get_v_ladder(t);
          end
      end
   end
end