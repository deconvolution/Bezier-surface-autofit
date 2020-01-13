function z=B(i,n,u)
z=zeros(size(i));
for k=1:length(i)
    z(k)=nchoosek(n-1,i(k)-1).*u.^(i(k)-1).*(1-u).^(n-i(k));
end
end