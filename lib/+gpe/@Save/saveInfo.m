function saveInfo(obj)
    info = obj.getInfo();
    f = fopen([obj.Data 'INFO.txt'],'w');
    fprintf(f, info);
    fclose(f);
end

