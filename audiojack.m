function res = audiojack(dir)
image = imread(dir);

% imshow(a);
forbw = im2bw(image);
% [x,y,z] = size(image);
% newimage = imresize(image,[x,y].*0.2);
% imshow(newimage);
% imshow(image); 
% stats = [regionprops(forbw); regionprops(not(forbw))];
% [~,idx] = sort([stats.Area],'descend');
% stats = stats(idx);
start = 10;
stop = 24;
minimal = 1.5;
maximal = 2.8;
gray_image = rgb2gray(image);
% imshow(gray_image);
[centers,radii] = imfindcircles(image,[20 25],'ObjectPolarity','dark', ...
    'Sensitivity',0.94);
length(centers);
res = [centers radii];
% imshow(image);
% h = viscircles(centers,radii);
% for i = start:stop %numel(stats)
% %     vmax = max(stats(i).BoundingBox(3),stats(i).BoundingBox(4));
% %     vmin = min(stats(i).BoundingBox(3),stats(i).BoundingBox(4));
% %     if vmax/vmin < 1.5 || vmax / vmin >= 2.8
% %         continue;
% %     end
% %     if (vmax/vmin <= minimal || vmax / vmin >=  maximal) %&& (stats(i).BoundingBox(3) > stats(i).BoundingBox(4))
% %         continue;
% %     end
% %     rectangle('Position', stats(i).BoundingBox, ...
% %     'Linewidth', 1, 'EdgeColor', 'r', 'LineStyle', '-');
% end


% for i = start:stop
% %     vmax = max(stats(i).BoundingBox(3),stats(i).BoundingBox(4));
% %     vmin = min(stats(i).BoundingBox(3),stats(i).BoundingBox(4));
% %     if vmax/vmin < 1.5 || vmax / vmin >= 2.8
% %         continue;
% %     end
% %     if (vmax/vmin <= minimal || vmax / vmin >= maximal) %&& (stats(i).BoundingBox(3) > stats(i).BoundingBox(4))
% %         continue;
% %     end
%     
% %     subplot(3,5,i-start+1);
% %     temp = imcrop(image,stats(i).BoundingBox);
% %     imshow(temp);
% end
% canny = edge(a,'Canny');
% hsv = rgb2hsv(image);
% hsv(:,:,2) = hsv(:,:,2).*3;
% image = hsv2rgb(hsv);
% a = image();
% canny10 = edge(a,'Canny',[],10);
% prewitt10 = edge(a,'Prewitt');
% roberts = edge(a,'Roberts');
% sobel = edge(a,'Sobel');
% zerocross = edge(a,'zerocross');
% log = edge(a,'log');
% step_size = 0.0;
% newimage = ((hsv(:,:,2)+hsv(:,:,3))/2);
% bw = newimage > 0.35;
% imshow(bw);
% imshow((hsv(:,:,2)+hsv(:,:,3))/2);

% s = regionprops(BW,'centroid');
% centroids = cat(1,s.Centroid);
% imshow(BW)
% hold on
% plot(centroids(:,1),centroids(:,2),'b*')
% hold off

% stats = regionprops('table',bw,'Centroid',
%     'MajorAxisLength','MinorAxisLength')
% centers = stats.Centroid;
% diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
% radii = diameters/2; 
end