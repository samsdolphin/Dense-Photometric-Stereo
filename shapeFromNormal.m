function [recsurf] = shapeFromNormal(normal,scale,I)

[m,n,~] = size(normal);
slant = zeros(m,n);
tilt = zeros(m,n);

for i = 1:m
    for j = 1:n
        T = squeeze(normal(m+1-i,j,:));
        x = T(1);
        y = T(2);
        z = T(3);
        slant(i,j) = acos(z);
        if y>=0
            tilt(i,j) = acos(x);
        elseif y<0
            tilt(i,j) = -acos(x);
        end
    end
end

recsurf = shapeletsurf(slant,tilt,8,1,2,'slanttilt');
recsurf = recsurf/scale;
[x,y] = meshgrid(1:n, 1:m);

figure;
%surf(x,y,recsurf,'FaceColor','cyan','EdgeColor','none');
surf(x,y,recsurf,I,'EdgeColor','none');
camlight left;
lighting phong;
axis equal;
axis vis3d;
axis off;

end