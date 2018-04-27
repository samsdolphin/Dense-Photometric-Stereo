path = 'data08/';
[resampled_images,light_direction] = uniformResampling(path);
initial_normal = getInitialNormal(resampled_images,light_direction);
%surf = shapeFromNormal(initial_normal,2);
refined_normal = refineNormal(initial_normal,0.5,0.6);
surf = shapeFromNormal(refined_normal,6,I);

%some parameters
%           lambda   sigma   scale   pointer
% data02      0.5     0.6     2        947
% data04      0.5     0.6     6        607
% data05      0.5     0.6     4        
% data06      0.5     0.8     4        
% data07      0.5     0.4     8        
% data08      0.5     0.4     6        1377
% data09      0.4     0.6     4        
% data09      0.5     0.6     4    
%image_files = dir(fullfile(path,'*.bmp'));
%I = imread(fullfile(path,image_files(947).name));
%I = flip(I,1);