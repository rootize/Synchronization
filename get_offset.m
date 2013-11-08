function offset=get_offset(points_v1,points_v2)

l1=length(points_v1);
l2=length(points_v2);
for i=1:1:l1
   
    UV=[points_v1(i).dptx,points_v1(i).dptx];
    
    nhat=get_effective_rank(UV);
    
    for j=1:1:l2
       E=[UV,points_v2(j).dptx,points_v2(j).dpty];
       S=svd(E);
       
       if 3*nhat<length(S)
       gerror(i,j)= sum(S(3*nhat:end));
       
       end
    end
    
    
    
end

% if we do judgement here, it will be extremly slow!
[v1_offset,v2_offset]=find(gerror==min(gerror(:)));
offset=v1_offset-v2_offset;
end