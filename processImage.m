function processImage(dir, tabGroup)
    
    % Tempat Function
    img = imread(dir);
    rectlan = lan(dir);
    [rectx,recty] = size(rectlan)
    
    
    
    
    % eh Tempat Show
    for i = 1 : rectx
        rectlan(i,:)
      rectangle('Position', rectlan(i,:), ...
     'Linewidth', 1, 'EdgeColor', 'r', 'LineStyle', '-'); 
    end
    imshow(img);
end

