X=[];
Y=[];
A=[1 1 3;4 1 6;7 1 9]
[m,n]=size(A);
for i=1:m
    for j=1:n
        if A(i,j)==1
            X=[X,i];
            Y=[Y,j];
        end
    end
end
C=X
B=Y
G = digraph(X,Y);
plot(G,'Layout','force');