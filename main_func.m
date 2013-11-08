%1 read file pairs
clear;
video_folder='./syn_sam_basketball';
 video1_name='camera1_1.avi';

video2_name='camera1_2_s.avi';
% video1=VideoReader(fullfile(  video_folder ,video1_name));
% video2=VideoReader(fullfile(  video_folder ,video2_name));

% set length of every sub_sequence
frag_l=50;

 p_surf_oct=3;
 p_surf_scl=4;
 p_mv=4;
 p_de=0;
video1_tracked=getTrackingSegments(fullfile(video_folder ,video1_name),frag_l,p_surf_oct,p_surf_scl,p_mv,p_de);
video2_tracked=getTrackingSegments(fullfile(video_folder ,video2_name),frag_l,p_surf_oct,p_surf_scl,p_mv,p_de);
 score_mat=func_generate_path_mat(video1_tracked,video2_tracked);
 func_draw_offset(score_mat);
 save(sprintf('result_l_%d_12s.mat',frag_l),'video1_tracked','video2_tracked','score_mat');
