clc
clear all 
close all

% Configure these parameters as per the application.
% These are the default settings.
K = 2; % max number of instances
pn = ['testingDataset\segmentation_results' num2str(K) '\']; % path to K-instance segmentation results
pnO = 'testingDataset\test_images\'; % path to original test images

% python color codes
knife = [183 244 155];
gun = [207 248 132];
chip = [144 71 111];
razor = [50 158 75];
shuriken = [128 48 71];
bg = [20 215 197];


ext_img = [pn '*.png'];
a = dir(ext_img);
nfile = length(a);

for i=1:nfile
    fn = a(i).name; 
    
    im = imread([pn fn]); 
    
    [r,c,ch] = size(im);
    
	im2 = imread([pnO fn]); % original test image
    oim2 = im2;
    
    % removing background
    for k = 1:r
        for j = 1:c
            if im(k,j,1) == bg(1) && im(k,j,2) == bg(2) && im(k,j,3) == bg(3)
                im(k,j,1) = 0;
                im(k,j,2) = 0;
                im(k,j,3) = 0;
            end
        end
    end
        
    [r,c,ch] = size(im);
    
    knifeM1 = zeros(r,c);
    knifeM2 = zeros(r,c);
    knifeM3 = zeros(r,c);
    gunM1 = zeros(r,c);
    gunM2 = zeros(r,c);
    gunM3 = zeros(r,c);
    chipM1 = zeros(r,c);
    chipM2 = zeros(r,c);
    chipM3 = zeros(r,c);
    razorM1 = zeros(r,c);
    razorM2 = zeros(r,c);
    razorM3 = zeros(r,c);
    shurikenM1 = zeros(r,c);
    shurikenM2 = zeros(r,c);
    shurikenM3 = zeros(r,c);
    
    isK1 = false;
    isC1 = false;
    isR1 = false;
    isG1 = false;
    isS1 = false;
    
    i1 = im(:,:,1);
    i2 = im(:,:,2);
    i3 = im(:,:,3);
    
    knifeM1(i1 == knife(1)) = 1;
    knifeM2(i2 == knife(2)) = 1;
    knifeM3(i3 == knife(3)) = 1;
    knifeM = knifeM1 & knifeM2 & knifeM3;
    if ~isempty(knifeM)
        isK1 = true;
    end
    
    gunM1(i1 == gun(1)) = 1;
    gunM2(i2 == gun(2)) = 1;
    gunM3(i3 == gun(3)) = 1;
    gunM = gunM1 & gunM2 & gunM3;
    if ~isempty(gunM)
        isG1 = true;
    end
    
    chipM1(i1 == chip(1)) = 1;
    chipM2(i2 == chip(2)) = 1;
    chipM3(i3 == chip(3)) = 1;
    chipM = chipM1 & chipM2 & chipM3;
    if ~isempty(chipM)
        isC1 = true;
    end
    
    razorM1(i1 == razor(1)) = 1;
    razorM2(i2 == razor(2)) = 1;
    razorM3(i3 == razor(3)) = 1;
    razorM = razorM1 & razorM2 & razorM3;
    if ~isempty(razorM)
        isR1 = true;
    end
    
    shurikenM1(i1 == shuriken(1)) = 1;
    shurikenM2(i2 == shuriken(2)) = 1;
    shurikenM3(i3 == shuriken(3)) = 1;
    shurikenM = shurikenM1 & shurikenM2 & shurikenM3;
    if ~isempty(shurikenM)
        isS1 = true;
    end
    
    knifeM = imfill(bwareaopen(logical(knifeM),3300),'holes');
    gunM = imfill(bwareaopen(logical(gunM),3300),'holes');
    chipM = imfill(bwareaopen(logical(chipM),3300),'holes');
    razorM = imfill(bwareaopen(logical(razorM),3300),'holes');
    
    knifeB = zeros(r,c);
    gunB = zeros(r,c);
    laptopB = zeros(r,c);
    razorB = zeros(r,c);
    shurikenB = zeros(r,c);
            
    if isK1
        L = bwlabel(knifeM,8);
        for j = 1:max(max(L))
            [r,c] = find(knifeM == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Knife','LineWidth',2,'Color','red','TextBoxOpacity',0.6);
            knifeB(r,c) = 1;
        end
    end
    
    if isC1
        L = bwlabel(chipM,8);
        for j = 1:max(max(L))
            [r,c] = find(chipM == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Chip','LineWidth',2,'Color','green','TextBoxOpacity',0.6);
            laptopB(r,c) = 1;
        end
    end
    
    if isR1
        L = bwlabel(razorM,8);
        for j = 1:max(max(L))
            [r,c] = find(razorM== j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Razor','LineWidth',2,'Color','blue','TextBoxOpacity',0.6);
            razorM(r,c) = 1;
        end
    end
    
    if isG1 
        L = bwlabel(gunM,8);
        for j = 1:max(max(L))
            [r,c] = find(gunM == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Gun','LineWidth',2,'Color','blue','TextBoxOpacity',0.6,'TextColor','white');
            gunB(r,c) = 1;
        end
    end
    
    if isS1 
        L = bwlabel(shurikenM,8);
        for j = 1:max(max(L))
            [r,c] = find(shurikenM == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Shuriken','LineWidth',2,'Color','blue','TextBoxOpacity',0.6,'TextColor','white');
            shurikenB(r,c) = 1;
        end
    end
    
    h=imshow(im2);
    hold on
    
    if isK1
        [r,c] = find(knifeM == 1);
        scatter(c,r,'r.','MarkerEdgeAlpha',0.07); 
        [r,c] = find(edge(knifeM,'canny') == 1);
        plot(c,r,'r.');
    end
    
    if isC1
        [r,c] = find(chipM == 1);
        scatter1 = scatter(c,r,'g.','MarkerEdgeAlpha',0.07);
        [r,c] = find(edge(chipM,'canny') == 1);
        plot(c,r,'g.');
    end
    
    if isG1
        [r,c] = find(gunM == 1);
        scatter1 = scatter(c,r,'b.','MarkerEdgeAlpha',0.07);
        [r,c] = find(edge(gunM,'canny') == 1);
        plot(c,r,'b.');
    end
    
    if isR1
        [r,c] = find(razorM == 1);
        scatter1 = scatter(c,r,'y.','MarkerEdgeAlpha',0.07);
        [r,c] = find(edge(razorM,'canny') == 1);
        plot(c,r,'y.');
    end
    
    
    if isS1
        [r,c] = find(shurikenM == 1);
        scatter1 = scatter(c,r,'m.','MarkerEdgeAlpha',0.07);
        [r,c] = find(edge(shurikenM,'canny') == 1);
        plot(c,r,'m.');
    end
    
    axis off tight
    hold off
    
    saveas(gcf,['results\gdxray\examples\' fn],'png');
end