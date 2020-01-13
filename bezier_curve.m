function B=bezier_curve(P,interval)
%%
n=size(P,2);
c=zeros(size(P,2),1);

t=0:interval:1;
B=zeros(3,length(t));
for k=1:length(t)
    for i=1:size(c,1)
        c(i)=nchoosek(n-1,i-1)*t(k)^(i-1)*(1-t(k))^(n-i);
    end
    B(:,k)=c'*P';
end
end