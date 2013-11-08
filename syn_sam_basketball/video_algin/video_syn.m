clear;
%% read from video
video_folder='/Users/zijunwei/Dev/Synchronization/Code/LWolf-Crspfree/Synchronization/syn_sam_basketball';
video1_name='camera1_1.avi';
video2_name='camera1_2.avi';

video1Obj=VideoReader(fullfile(video_folder,video1_name));
video2Obj=VideoReader(fullfile(video_folder,video2_name));
v_l=video1Obj.NumberOfFrames;
%% begin
v1=30;
videoO=VideoWriter(fullfile( pwd,'fail.avi'));
videoO.FrameRate=5;
open(videoO);
for i=1:1:30
   fprintf('processing %d th image\n',i);
%    v1_frame=read(video1Obj,i);
%    v2_frame=read(video2Obj,i);
      v1_frame=imread(fullfile('/Users/zijunwei/Dev/Synchronization/Code/LWolf-Crspfree/Synchronization/test_imgs_fail',sprintf('video1_%.05d.png',i)));
      v2_frame=imread(fullfile('/Users/zijunwei/Dev/Synchronization/Code/LWolf-Crspfree/Synchronization/test_imgs_fail',sprintf('video2_%.05d.png',i)));

    v_syn=ImgSyn(v1_frame,v2_frame,'h');
    writeVideo(videoO,v_syn);
end
close(videoO);