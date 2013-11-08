function idx=get_effective_rank(M,per)
% get the effiective rank 
% based on the threshold suggested in paper, if the sum of first singular
% values is larger than the 99% percent of the sum all the sigular values,we get the
if nargin<2
    per=0.99;
end
S=svd(M);
idx=1;
l_singular=length(S);
thresholdS=per*sum(S);
for i=l_singular:-1:1
    if sum(S(1:i))<=thresholdS
       idx=i+1;
       break;
    end
end
idx=ceil(idx/2);
% if idx*2>size(M,1);
%     idx=ceil(size(M,1)/2)-1;
% end
end