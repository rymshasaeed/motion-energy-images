% Inter-Frame Differencing Method
clc, clearvars, close all

% Read the Video file 
obj = VideoReader('motions\jump.avi');

% Inilialize number of frames 'f' by 1
f = 1;

% Extract individual frames
while hasFrame(obj)
    % Read frames as grayscale
    frames(:,:,f) = rgb2gray(readFrame(obj)); 
    
    % Increment f by 1
    f = f+1;
end

% Total number of frames
f = f-1;

% Find inter-frame differences
for i = 2:f   
    % Absolute difference between two consective frames
    diff{i-1} = imabsdiff(frames(:,:,i), frames(:,:,i-1)); 
end

% Define MEI parameter w
w = 15;

% Start global loop for each frame
for i = 1:f-1
    % Get MEI array for each frame i.e. H(x,y,t,T)
    mei{i} = diff{i}.*w;
    
    % Begin looping through each pixel
    for y = 1:size(diff,1)
        for x = 1:size(diff,2)
            if mei{i}(y,x) == 255
                mei{i}(y,x) = w;
            else
                if mei{i}(y,x) > 1
                    mei{i}(y,x) = mei{i}(y,x) - 1;
                else
                    mei{i}(y,x) = 0;
                end
            end
        end
    end
    
    % Display motion
    figure(1);
    imshow(mei{i},[])    
    title(['Frame ',num2str(i)])
end
