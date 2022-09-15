classdef Save < handle
   properties
      model;
      grid;
      config; 
      
      Folder;
      Pictures;
      Ills;
      IllsFourier;
      Data;
      PsiMat;
      Config;
      Video;

      ts;
      ls;
      Ubs;
      Uls;
      Uts;
      Us;
      Es;
      mus;

   end
   methods
      function obj = Save(params)
          if nargin == 1
              if isfield(params, 'model')
                  obj.model = params.model;
              end
              if isfield(params, 'Folder')
                  obj.Folder = [params.Folder, '/'];
                  util.createFolder(obj.Folder);
              end
          end
          
          if ~isempty(obj.Folder)
              obj.Pictures = [obj.Folder, 'Pictures/'];
              util.createFolder(obj.Pictures);
              
              obj.Data = [obj.Folder, 'Data/'];
              util.createFolder(obj.Data);
              
              obj.PsiMat = [obj.Folder, 'Psi/'];
              util.createFolder(obj.PsiMat);
              
              obj.Ills = [obj.Folder, 'Ills/'];
              util.createFolder(obj.Ills);
              
              obj.Config = [obj.Folder, 'Config/'];
              util.createFolder(obj.Config);
              
              obj.Video = [obj.Folder, 'Video/'];
              util.createFolder(obj.Video);

              obj.IllsFourier = [obj.Folder, 'IllsFourier/'];

              obj.config = obj.model.config;
              obj.grid = obj.model.grid;
          end
      end
   end
end