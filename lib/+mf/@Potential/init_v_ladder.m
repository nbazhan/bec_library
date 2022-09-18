function init_v_ladder(obj)

      addprop(obj, 'n');
      if isfield(obj.params, 'n')
          obj.n = obj.params.n;
      else
          obj.n = 1;
      end


      addprop(obj, 'phi');
      if isfield(obj.params, 'phi')
          obj.phi = obj.params.phi;
      else
          obj.phi = (2*pi/obj.n)*(0 : obj.n - 1);
      end


      addprop(obj, 'rlim');
      if isfield(obj.params, 'rlim')
          obj.rlim = obj.model.to_length_dim(obj.params.rlim);
      else
          obj.rlim = [0, sqrt(obj.model.grid.L.x/2.^2 + obj.model.grid.L.y/2.^2)];
      end


end

