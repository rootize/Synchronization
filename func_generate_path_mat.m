
function score_mat=func_generate_path_mat(video1_tracked,video2_tracked,thres)
if nargin<3
   thres=0.99; 
end

length_v1=length(video1_tracked);
length_v2=length(video2_tracked);

score_mat=zeros(length_v1,length_v2);
for i=1:1:length_v1
    
    for j=1:1:length_v2
       fprintf('generating Mat(%d,%d)\n',i,j);
    eff_rank=get_effective_rank([video1_tracked(i).ptx,video1_tracked(i).pty],thres);
    E_mat=[video1_tracked(i).ptx,video1_tracked(i).pty,video2_tracked(j).ptx,video2_tracked(j).pty];
    err_score=get_error(E_mat,eff_rank);
    
    score_mat(i,j)=err_score;
    
        
    end
    
end
