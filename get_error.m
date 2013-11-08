function err_score=get_error(E_mat,e_rank)

S=svd(E_mat);

if 3*e_rank+1>length(S)
   err_score=100;
else
    err_score=sum(S(3*e_rank+1:end));
    
end



end