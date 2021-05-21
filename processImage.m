function processImage(dir, tabGroup)
    
    % Tempat Function
    img = imread(dir);
    rectlan = lan(dir);
    circle = audiojack(dir);
    rectusb = usbdetector(dir);
    
    
    
    % eh Tempat Show
    Children = get(tabGroup, 'children');
    h = (findobj(Children, 'Type', 'axes'));
    if ~isempty(h)
        for i=1:length(h), delete(h(i));end
    end
    tabGroup.AutoResizeChildren = 'off';
    
    ax = axes(tabGroup);
    
    set(ax, 'Units', 'Pixels');
    imshow(img, 'Parent', ax);
    hold(ax, 'on');
    for i = 1 : size(rectlan, 1)
      rectangle(ax, 'Position', rectlan(i,:), ...
     'Linewidth', 1, 'EdgeColor', 'r', 'LineStyle', '-'); 
    end
    for i = 1 : size(rectusb, 1)
      rectangle(ax, 'Position', rectusb(i,:), ...
     'Linewidth', 1, 'EdgeColor', 'r', 'LineStyle', '-'); 
    end
    viscircles(ax, circle(:,1:2),circle(:,3),'Linewidth', 1, 'EdgeColor', 'r', 'LineStyle', '-', 'EnhanceVisibility',false);
    hold(ax, 'off');
end

