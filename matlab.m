image = imread('img1.jpg');
a = im2bw(image);
s = regionprops(a,'centroid');
figure;
imshow(s); title('input image');
b = imcomplement(a);
% figure;
imshow(b); title('complement image');
[L,NUM] = bwlabel(b,4);
%for i=1:NUM
%   figure;
    %imshow(L==i), title(i);
    %pause(1);
%end
fprintf('jumlah lingkaran yang ditemukan : %d',NUM);
% disp(' ');printf('jumlah lingkaran yang ditemukan : %d',NUM);
disp(' ');