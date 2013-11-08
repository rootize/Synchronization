%1 read file pairs
clear;
video_folder='./syn_sam_basketball';
video1_name='camera1_1.avi';
video1=VideoReader(fullfile(  video_folder ,video1_name));
%nFrames=video1.NumberOfFrames;
frag_l=30;
% next step
video1_tracked=getTrackingSegments(fullfile(video_folder ,video1_name),frag_l)%,p_surf_oct,p_surf_scl,p_mv,p_del_pts);


