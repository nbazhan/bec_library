function saveInfo(obj)
    disp('Saving info...');
    info = obj.getInfo();
    f = fopen([obj.Config 'INFO.txt'],'w');
    fprintf(f, info);
    fclose(f);
end

