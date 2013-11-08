clear;
score_mat=load('result08-Nov-2013.mat');
score_mat=score_mat(1).score_mat;

[~,min_cor]=min(score_mat,[],1);

figure;
plot(1:size(score_mat,2),min_cor,'r*');