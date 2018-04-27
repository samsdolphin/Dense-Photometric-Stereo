function [normal] = getInitialNormal(images,light_dir)

[m,n,num_img] = size(images);
img_ranks = zeros(m,n,num_img);

for i = 1:m
    for j = 1:n
        [~,I] = sort(images(i,j,:));
        I = reshape(I,[num_img,1]);
        img_ranks(i,j,I) = 1:num_img;
    end
end

pointer = 0;
max = 0;
L = 0.7*num_img;
H = 0.9*num_img;

for i = 1:num_img
    count = 0;
    for x = 1:m
        for y = 1:n
            s = img_ranks(x,y,i);
            if s>L && s<H
                count = count+1;
            end
        end
    end
    if count>max
        pointer = i;
        max = count;
    end
end

disp(pointer);
deno_img = images(:,:,pointer);
images(:,:,pointer) = [];
deno_light = light_dir(pointer,:);
light_dir(pointer,:) = [];

normal = zeros(m,n,3);

for i = 1:m
    for j = 1:n
        I = reshape(images(i,j,:),[num_img-1,1]);
        A = deno_img(i,j).*light_dir - I*deno_light;
        [~,~,v] = svd(A,0);
        x = v(:,end);
        if x(3)<0
            x = -x;
        end
        normal(i,j,:) = x; % x is 3 by 1
    end
end

end