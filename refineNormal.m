function [refined_normal] = refineNormal(initial_normal,lambda,sigma)

[vertices,~] = icosphere(5);
vertices = vertices(vertices(:,3)>0,:);
[m,n,~] = size(initial_normal);
for i = 1:3
    normal(:,i) = reshape(initial_normal(:,:,i),[m*n,1]);
end
label = knnsearch(vertices,normal); % find the nearest neighbour for normal from vertices

h = GCO_Create(m*n,length(vertices)); % (NumSties, NumLabels)
GCO_SetLabeling(h,label');
datacost = int32(10000*pdist2(vertices,normal));
GCO_SetDataCost(h,datacost);
smoothnesscost = pdist2(vertices,vertices);
smoothnesscost = int32(10000*lambda*log10(1+smoothnesscost/(2*sigma*sigma)));
GCO_SetSmoothCost(h,smoothnesscost);

si = zeros((m-1)*n+(n-1)*m,1);
for i = 1:n
    for j = 1:m-1
        si(j+(i-1)*(m-1)) = j+(i-1)*m;
    end
end
for i = 1:n-1
    for j = 1:m
        si((m-1)*n+(i-1)*m+j) = j+(i-1)*m;
    end
end

sj = zeros((m-1)*n+(n-1)*m,1);
sv = ones((m-1)*n+(n-1)*m,1);

for i = 1:n
    for j = 1:m-1
        sj(j+(i-1)*(m-1)) = j+1+(i-1)*m;
    end
end
for i = 1:n-1
    for j = 1:m
        sj((m-1)*n+(i-1)*m+j) = j+i*m;
    end
end

S = sparse(si,sj,sv,m*n,m*n);
GCO_SetNeighbors(h,S);
GCO_Expansion(h);
labeling = GCO_GetLabeling(h);
GCO_Delete(h);

refined_normal = zeros(m,n,3);
for i = 1:m
    for j = 1:n
        refined_normal(i,j,:) = vertices(labeling((j-1)*m+i),:);
    end
end

end