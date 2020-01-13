function A=transform_K(X,translation,rx,ry,rz)
[a,b,c]=size(X);
t=reshape(X,[a*b,c]);
A=t';
%%
A=[1,0,0;
    0,cos(rx),-sin(rx);
    0,sin(rx),cos(rx)]*A;
A=[cos(ry),0,sin(ry);
    0,1,0;
    -sin(ry),0,cos(ry)]*A;
A=[cos(rz),-sin(rz),0;
    sin(rz),cos(rz),0;
    0,0,1]*A;
%%
A=reshape(A,[a,b,c]);
end