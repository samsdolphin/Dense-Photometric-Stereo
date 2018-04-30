path = 'data02/';
[resampled_images,light_direction] = uniformResampling(path,1);
initial_normal = getInitialNormal(resampled_images,light_direction);
ini_surf = shapeFromNormal(initial_normal,2,I);
imshow((-1/sqrt(3)*initial_normal(:,:,1) + 1/sqrt(3)*initial_normal(:,:,2) + 1/sqrt(3)*initial_normal(:,:,3))/1.1);
refined_normal = refineNormal(initial_normal,0.5,0.6);
ref_surf = shapeFromNormal(refined_normal,2,I);
imshow((-1/sqrt(3)*refined_normal(:,:,1) + 1/sqrt(3)*refined_normal(:,:,2) + 1/sqrt(3)*refined_normal(:,:,3))/1.1);


% some parameters
%           lambda   sigma   scale   denominator_image
% data02      0.5     0.6     2             641
% data04      0.5     0.6     6             769
% data05      0.5     0.6     4        
% data06      0.5     0.8     4        
% data07      0.5     0.4     8             2227
% data08      0.5     0.4     6             950  
% data09      0.4     0.6     4             707
% data10      0.5     0.6     4             2034


% image_files = dir(fullfile(path,'*.bmp'));
% I = imread(fullfile(path,image_files(641).name));
% I = flip(I,1);
