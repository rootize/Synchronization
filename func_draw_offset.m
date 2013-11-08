function []=func_draw_offset(score_mat)


[~,min_cor]=min(score_mat,[],1);

figure;
plot(1:size(score_mat,2),min_cor,'r*');
end