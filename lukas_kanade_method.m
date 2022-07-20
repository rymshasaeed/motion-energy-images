% Lukas-Kanade Optical Flow Estimate
clc, clearvars, close all

% Read the Video file 
obj = VideoReader('motions/jump.avi');

% Number of frames
n = obj.NumFrames;
     
% Extract individual frames
for k = 1:n
    frame(:,:,k) = im2double(rgb2gray(read(obj, k)));
end 

% Define the window size for Lucas-Kanade method
window = 40;

% Temporal width
w = round(window/2);

% Implement Lucas Kanade Method
for i = 2:n
    % Scaling factor
    r = 2;
    
    % Reduce size of the frames by scaling factor and find corner points
    cp = r*corner(imresize(frame(:,:,i), 1/r));
    
    % Discard corners near frame margin
    k = 1;
    for j = 1:size(cp,1)
        % Select the corners
        p = cp(j,2);
        q = cp(j,1);
        
        % Choose valid corner points
        if (p-w)>=1 && (q-w)>=1 && (p+w)<=size(frame(:,:,i-1),1)-1 && (q+w)<=size(frame(:,:,i-1),2)-1
            Corners(k,:) = cp(j,:);
            k = k+1;
        end
    end
            
    % Lukas-Kanade Method
    X = conv2(frame(:,:,i-1),[-1 1; -1 1],'valid');
    Y = conv2(frame(:,:,i-1),[-1 -1; 1 1],'valid');
    T = conv2(frame(:,:,i-1),ones(2),'valid')+conv2(frame(:,:,i),-ones(2),'valid');
    
    % Initialize vectors to store optical flow vectors
    u = zeros(length(Corners),1);
    v = zeros(length(Corners),1);
    
    % Within window ww * ww
    for k = 1:length(Corners(:,2))
        % Select the corners
        p = Corners(k,2);
        q = Corners(k,1);
        
        % Get frame coordinates
        Wx = X(p-w:p+w, q-w:q+w);
        Wy = Y(p-w:p+w, q-w:q+w);
        Wt = T(p-w:p+w, q-w:q+w);
        
        % Solve for linear system: Ax = b
        b = -Wt(:);
        A = [Wx(:) Wy(:)];
        x = pinv(A)*b;
        
        % Store eigen values as optical flow vectors
        u(k) = x(1);
        v(k) = x(2);
    end
    
    % Plot corners on the frames
    figure(1)
    subplot(1,2,1)
    imshow(frame(:,:,i),[])
    hold on
    plot(Corners(:,1), Corners(:,2), 'r*');
    title('Corners')
    hold off
    
    % Draw the optical flow vectors
    figure(1)
    subplot(1,2,2)
    imshow(frame(:,:,i))
    hold on
    quiver(Corners(:,1), Corners(:,2), u,v, 1,'r')
    title('Optical Fow Vectors')  
    hold off
    sgtitle(['Frame ',num2str(i)])
end
