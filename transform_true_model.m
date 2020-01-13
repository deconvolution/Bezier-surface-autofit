function A=transform_true_model(X,translation,rx,ry,rz)
A=X+translation;
A=[1,0,0;
    0,cos(rx),-sin(rx);
    0,sin(rx),cos(rx)]*A;
A=[cos(ry),0,sin(ry);
    0,1,0;
    -sin(ry),0,cos(ry)]*A;
A=[cos(rz),-sin(rz),0;
    sin(rz),cos(rz),0;
    0,0,1]*A;
end