function init_v_toroidal(obj)
      
      addprop(obj, 'w');
      if isfield(obj.params, 'w')
          w = obj.params.w;
      else
          w = 2*pi*[200, 600];
      end
      obj.w = struct('r', w(1), 'z', w(2));


      addprop(obj, 'l');
      l = sqrt(obj.model.config.hbar/obj.model.config.M./w);
      obj.l = struct('r', l(1), 'z', l(2));


      addprop(obj, 'R');
      if isfield(obj.params, 'R')
          R = obj.params.R;
      else
          R = [19.23*10^(-6), 19.23*10^(-6)];
      end
      R = obj.model.to_length_dim(R);
      obj.R = struct('x', R(1), 'y', R(2));


      addprop(obj, 'W');
      if isfield(obj.params, 'W')
          obj.W = obj.model.to_omega_dim(obj.params.W);
      else
          obj.W = 0;
      end
      

      addprop(obj, 'tof');
      if isfield(obj.params, 'tof')
          tof = obj.params.tof;
      else
          tof = [1, 1.1];
      end
      obj.tof = obj.model.to_time_dim(tof);


      addprop(obj, 'c');
      c = struct('xy', [0, 0], ...
                 'r', [0, 0], 'w', 0);
      if isfield(obj.params, 'c')
          c = util.add_struct(c, obj.params.c);
      end
      c.xy = obj.model.to_length_dim(c.xy);
      c.r = obj.model.to_length_dim(c.r);
      c.w = obj.model.to_omega_dim(c.w);
      obj.c = struct('x', c.xy(1), 'y', c.xy(2), ...
                     'rx', c.r(1), 'ry', c.r(2), 'w', c.w);
      

end

