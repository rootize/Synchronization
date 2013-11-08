% track the features
% 
% im=imread('test.jpg');
% im=im2double(rgb2gray(im));
% % s = [1 ;1];
% % dx = [1, -1];
% % dy = [1;-1];
% % gx = conv2(conv2(I,dx,'same'),s,'same');
% % gy = conv2(conv2(I,dy,'same'),s','same');
% 
% initPtsObj=detectSURFFeatures(im,'NumOctaves',1,'NumScaleLevels',3);
% im=img(im);
% imshow(im);
% hold on
% location=initPtsObj.Location;
% plot(location(:,1),location(:,2),'r*');
% hold off

% test drawed points on the video
frag_length=30;
test_result_folder='test_imgs';
test_full_path=fullfile(pwd, test_result_folder);
if ~exist(fullfile(pwd,test_result_folder),'dir')
    
   mkdir(fullfile(pwd,test_result_folder)); 
end

%% 
video_folder=fullfile(pwd,'syn_sam_basketball');
video1_name='camera1_1.avi';
videoObject=VideoReader(fullfile(video_folder,video1_name));
figure ;
set(gcf,'Visible','off');
for i=1:1:frag_length
    im=im2double(rgb2gray(read(videoObject,i)));
    imshow(im);
    hold on;
    plot(video1_tracked.ptx(i,:),video1_tracked.pty(i,:),'r*');
    hold off;
    saveas(gcf,fullfile(   test_full_path,sprintf('video1_%.05d.png',i)),'png');
    
end