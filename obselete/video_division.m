
% Questions 1. How to divide videos into different fragments
%           2. How long  should a sub_sequence be?
%           3. How we make the points in a sequence smaller but more
%           precise to describe the moving objects
function points_array=video_division(video_name,frag_length)
% video_folder='./video_sets/';
% video_name='RA049_2012_07_31_canon_child_rabc.mp4';

if nargin<2
   frag_length=30; 
   
end

videoObj=VideoReader(video_name);
nFrames=videoObj.NumberOfFrames;




for idx=1:1:nFrames-frag_length
initFrame= rgb2gray( read(videoObj,idx));
initPtsObj=detectSURFFeatures(initFrame,'NumOctaves',2,'NumScaleLevels',5);
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

for i=idx+1:1:idx+frag_length-1
    initFrame=rgb2gray(read(videoObj,i));
    [points,conf]=step(pointTracker,initFrame);
    tracked_=tracked_ & conf;
    Px(:,i-idx)=points(:,1);
    Py(:,i-idx)=points(:,2);
end

Px=Px(tracked_,:);
Py=Py(tracked_,:);
Px=Px.';% the column of U is different point in x axes, row of U is the time step
Py=Py.';

dPx=diff(Px,[],1);
dPy=diff(Py,[],1);

points_array(idx).dptx=dPx;
points_array(idx).dpty=dPy;
end

end
