function make_video(FolderPics, FolderVideo, FrameRate)

disp('Making video...')
video = VideoWriter([FolderVideo '.avi']);
video.FrameRate = FrameRate;
open(video);

drc = dir([FolderPics '/*.png']);

FileName = drc(1).name(1:end-5);
for i = 1:numel(drc)
    Film = imread([FolderPics FileName num2str(i) '.png']);
    writeVideo(video, Film);
end
close(video);

%save([FolderVideo 'Film' 'film.mat'],'Film');
%%
disp('finish');