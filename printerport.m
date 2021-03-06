image = imread('img1.jpg');
% pararel
% imshow(a);
forbw = im2bw(image);
figure;imshow(image); hold on;
stats = [regionprops(forbw); regionprops(not(forbw))];
[~,idx] = sort([stats.Area],'desc');
stats = stats(idx);
imagearea = size(image, 1) * size(image, 2);

disp('');
start = 10;
stop = 400;
minimal = 0.9;
maximal = 1.22;

triP = [];

for i = start:stop %numel(stats)
    vmax = max(stats(i).BoundingBox(3),stats(i).BoundingBox(4));
    vmin = min(stats(i).BoundingBox(3),stats(i).BoundingBox(4));
%     if vmax/vmin < 1.5 || vmax / vmin >= 2.8
%         continue;
%     end
    if (vmax/vmin <= minimal || vmax / vmin >= maximal) %|| (stats(i).BoundingBox(3) > stats(i).BoundingBox(4))
        continue;
    end
    triP(end + 1, :) = [stats(i).BoundingBox(1)+stats(i).BoundingBox(3)/2, ...
        stats(i).BoundingBox(2)+stats(i).BoundingBox(4)/2];
end

triangle = [];
area = [];
sTri = size(triP, 1);
idx = 1;
for i=1:sTri-2
    for j=i+1:sTri-1
        for k=j+1:sTri
            lenA = sqrt((triP(i,1) - triP(j,1))^2 + (triP(i,2) - triP(j,2))^2);
            lenB = sqrt((triP(i,1) - triP(k,1))^2 + (triP(i,2) - triP(k,2))^2);
            lenC = sqrt((triP(k,1) - triP(j,1))^2 + (triP(k,2) - triP(j,2))^2);
            
            limit = (lenA + lenC + lenB) / 60;
            S = (lenA + lenB + lenC) / 2;
            are = sqrt(S * (S - lenA) * (S - lenB) * (S - lenC));
            
            if abs(lenA - lenB) < limit && abs(lenA - lenC) < limit && abs(lenB - lenC) < limit && are < imagearea * 0.02
                area(idx) = are;
                triangle(idx, 1, 1) = triP(i,1);
                triangle(idx, 1, 2) = triP(i,2);
                triangle(idx, 2, 1) = triP(j,1);
                triangle(idx, 2, 2) = triP(j,2);
                triangle(idx, 3, 1) = triP(k,1);
                triangle(idx, 3, 2) = triP(k,2);
                idx = idx + 1;
            end
        end
    end
end

%segment
seg_area = [area(1)];
seg_tri = [[triangle(1,:,:)] ];
for i=2:size(area, 1)
    found = false;
    for j=1:size(seg_area, 1)
        if abs(seg_area(j) - area(i)) < (seg_area(j) + area(i)) / 200
            touched = false;
            for k=1:size(seg_tri, 1)
                if isequal(seg_tri(j,k,1,:), triangle(i,1,:))
                    touched = true;
                end
                if isequal(seg_tri(j,k,2,:), triangle(i,1,:))
                    touched = true;
                end
                if isequal(seg_tri(j,k,3,:), triangle(i,1,:))
                    touched = true;
                end
                if isequal(seg_tri(j,k,1,:), triangle(i,2,:))
                    touched = true;
                end
                if isequal(seg_tri(j,k,2,:), triangle(i,2,:))
                    touched = true;
                end
                if isequal(seg_tri(j,k,3,:), triangle(i,2,:))
                    touched = true;
                end
                if isequal(seg_tri(j,k,1,:), triangle(i,3,:))
                    touched = true;
                end
                if isequal(seg_tri(j,k,2,:), triangle(i,3,:))
                    touched = true;
                end
                if isequal(seg_tri(j,k,3,:), triangle(i,3,:))
                    touched = true;
                end
            end
            if touched
                idx = size(seg_tri(j), 1);
                idx = idx + 1;
                seg_tri(j,idx,1,1) = triangle(i,1,1);
                seg_tri(j,idx,1,2) = triangle(i,1,2);
                seg_tri(j,idx,2,1) = triangle(i,2,1);
                seg_tri(j,idx,2,2) = triangle(i,2,2);
                seg_tri(j,idx,3,1) = triangle(i,3,1);
                seg_tri(j,idx,3,2) = triangle(i,3,2);
                seg_tri(j,idx)
                found = true;
            end
        end
        if found
            break;
        end
    end
    if ~found
        idx = size(seg_tri, 1);
        seg_tri(idx,1,1,1) = triangle(i,1,1);
        seg_tri(idx,1,1,2) = triangle(i,1,2);
        seg_tri(idx,1,2,1) = triangle(i,2,1);
        seg_tri(idx,1,2,2) = triangle(i,2,2);
        seg_tri(idx,1,3,1) = triangle(i,3,1);
        seg_tri(idx,1,3,2) = triangle(i,3,2);
        seg_area(idx) = area(i);
    end
end

klp = 1;
for i=1:size(seg_tri(klp),1)
    seg_tri(klp, i)
    plot([seg_tri(klp,i,1,1) seg_tri(klp,i,2,1)], [seg_tri(klp,i,1,2) seg_tri(klp,i,2,2)], '-');
    plot([seg_tri(klp,i,3,1) seg_tri(klp,i,2,1)], [seg_tri(klp,i,3,2) seg_tri(klp,i,2,2)], '-');
    plot([seg_tri(klp,i,1,1) seg_tri(klp,i,3,1)], [seg_tri(klp,i,1,2) seg_tri(klp,i,3,2)], '-');
end


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