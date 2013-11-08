function video_tracked=getTrackingSegments(video_name,frag_length,p_surf_oct,p_surf_scl,p_mv,p_del_pts)
% function getTrackingSegments(video_name,frag_length,p_surf_oct,p_surf_scl,p_mv,p_del_pts)
% give the video name and sub_video length , n sub_video tracking points.
% input: video_name: the name of input video
%        frag_length: user decide the length of every video fragment
%        length. The larger the length, the less probable the synchronization get in local minimal, but the tracking points might not be reliable
%        becase accroding to Tomasi Kanade, only small motion are assumed
%        p_surf_oct: surf detector parameter, number of octaves default is
%                     2
%        p_surf_scl: number of scale levels used in surf detector, default
%        is 5
%        p_mv:  threshold of moving per pixel in order to be preserver,
%        since surf gives a large amount of point, which might not be
%        moving at all. They are not valueable to our algorithm, we delete
%        the surf points wich moves within some pixel, default value is 4
%        p_del_pts: according to the paper, the constraints below should be
%        satisfied T > 2n (hat), where n(hat) is the rank of the matrix ptx
%        or pty, but if there are too many points tracked, the constraint
%        doesn't stand, we should deletet most of the points.


if nargin<6
    p_del_pts=0; % not delete any points if value is 1 make the pts the ceil(T/2)-1
end
if nargin<5
    p_mv=4 ;
end
if nargin<4
    
    p_surf_oct=2;
end
if nargin<3
    p_surf_scl=5;
end

videoObj=VideoReader(video_name);

video_length=videoObj.NumberOfFrames;
% video_length-frag_length+1
for startid=1:1:video_length-frag_length+1
    disp(sprintf( '%s_%d',videoObj.Name(1:end-4),startid));
    tracked_pts(startid)=loc_get_tracked_points(videoObj,startid,frag_length,p_surf_oct,p_surf_scl ,p_mv,p_del_pts);
    
end
video_tracked=tracked_pts;
end


function s_tracked_pts=loc_get_tracked_points(videoObj,startid,frag_length,p_surf_oct,p_surf_scl ,p_mv,p_del_pts)
% returns the tracked point sets in a length of frag_length frames
%%init using surf dtector

initFrame=  im2double(rgb2gray( read(videoObj,startid)));

initPtsObj=detectSURFFeatures(initFrame,'NumOctaves',p_surf_oct,'NumScaleLevels',p_surf_scl);
pointTracker=vision.PointTracker();
initialize(pointTracker,initPtsObj.Location,initFrame);

Px=zeros(initPtsObj.length,frag_length);
Py=Px;


%initializing the parameters used
points=initPtsObj.Location;
tracked_=ones(initPtsObj.length,1);
conf=tracked_;
Px(:,1)=points(:,1);
Py(:,1)=points(:,2);

for i=startid+1:1:startid+frag_length-1
    initFrame=im2double(rgb2gray(read(videoObj,i)));
    [points,conf]=step(pointTracker,initFrame);
    tracked_=tracked_ & conf;
    Px(:,i-startid+1)=points(:,1);
    Py(:,i-startid+1)=points(:,2);
end

Px=Px(tracked_,:);
Py=Py(tracked_,:);
% before transpose, the each row is a point across time, each column is a
% time step all points existing in
[Px,Py]=loc_rm_static_points(Px,Py,p_mv,p_del_pts);

Px_org=Px.';
Py_org=Py.';
Px=diff(Px,[],2);
Py=diff(Py,[],2);
Px=Px.';% the column of U is different point in x axes, row of U is the time step
Py=Py.';


s_tracked_pts.optx=Px_org;
s_tracked_pts.opty=Py_org;
s_tracked_pts.ptx=Px;
s_tracked_pts.pty=Py;

end


function [Px,Py]=loc_rm_static_points(Px,Py,mv_pix,p_del_pts)
% remove the static points that barely moves during movement

if nargin<3
    mv_pix=4;
end
dPx=diff(Px,[],2);
dPy=diff(Py,[],2);

total_mv_x=sum(dPx,2);
total_mv_y=sum(dPy,2);

total_mv_pts=sqrt(total_mv_x.*total_mv_x+total_mv_y.*total_mv_y);



if p_del_pts==1
    pre_pts=ceil(size(Px,2)/2)-1;
    [~,pts_idx]=sort(total_mv_pts,'descend');
     Px=Px(pts_idx(1:pre_pts),:);
    Py=Py(pts_idx(1:pre_pts),:);
else
    pts_preserved=(total_mv_pts/size(Px,2)) >mv_pix;
    Px=Px(pts_preserved,:);
    Py=Py(pts_preserved,:);
end


end
