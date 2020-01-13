function z=nearest(x,y,neighbor)
% x is true_model
[d,e,f]=size(y);
X=x';
Y=reshape(y,[d*e,f]);
loc=knnsearch(X(:,1:2),Y(:,1:2),'K',neighbor,'distance','euclidean');
z=X(loc,:);
end