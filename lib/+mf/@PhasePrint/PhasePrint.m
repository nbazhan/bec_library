classdef PhasePrint
   properties
      grid;
   end
   methods
      function obj = PhasePrint(params)
          if nargin == 1
              if isfield(params, 'grid')
                  obj.grid = params.grid;
              end
          end
      end
   end
end