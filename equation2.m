function uvhat=equation2(Q,affinemat_hat,flow1)
%define Q n*1 vector, affinemat_hat 2*4 matrix representing affine
%projection, flow 3*N matrix representing movement in 1;
% output: uvhat 2*N flow in another sequence represneted by the first
% sequence
Qaffine=kron(Q.',affinemat_hat);
flow_column=reshape(flow1,size(flow1,2)*size(flow1,1),1);

uvhat=Qaffine*flow_column;
end