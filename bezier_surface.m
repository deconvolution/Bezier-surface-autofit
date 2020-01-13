function P=bezier_surface(K,u_interval,v_interval)
%%
[n,m,~]=size(K);
u=0:u_interval:1;
v=0:v_interval:1;
P=zeros(length(u),length(v),3);
%%
for k=1:length(u)
    for l=1:length(v)
        t=zeros(1,1,3);
        for i=1:n
            for j=1:m
                t=t+B(i,n,u(k))*B(j,m,v(l))*K(i,j,:);
            end
        end
        P(k,l,:)=t;
    end
end
end