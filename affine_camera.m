% affine cameras: points at infinity are still mapped to infinity

function uv= affine_camera(dP)
cameramat=[a1,a2,a3,a4;b1,b2,b3,b4];

uv=cameramat(:,1:3)*dP;


end