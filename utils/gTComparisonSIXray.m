clc
clear all 
close all

% change the paths accordingly as per your system location
pn= 'testingDataset\segmentation_results3\';
pn2 = 'testingDataset\test_images\';

load gtSIXray.mat

ext_img = [pn '*.png'];
a = dir(ext_img);
nfile = length(a);

% python color codes
knife1 = [183 244 155];
knife2 = [204 47 7];
knife3 = [31 133 226];
gun1 = [207 248 132];
gun2 = [222 181 51];
gun3 = [244 104 161];
gun4 = [217 218 62];
gun5 = [15 46 251];
gun6 = [125 53 214];
wrench1 = [144 71 111];
wrench2 = [56 176 31];
pliers1 = [224 14 210];
pliers2 = [146 64 152];
scissor1 = [115 136 175];
scissor2 = [251 52 182];
scissor3 = [142 102 15];
scissor4 = [14 167 196];
scissor5 = [174 81 113];
hammer1 = [12 153 252];

bBoxComparisonOnly = true;
maskComparisonOnly = ~bBoxComparisonOnly;
bothComparison = false;

for i=1:nfile
    fn = a(i).name; 
    im = imread([pn fn]);
    
    im2 = imread([pn2 fn]);
    oim2 = im2;
    
    if maskComparisonOnly == false || bothComparison == true 
        for j = 1:length(gt)
            if ~isempty(gt{j})
                [r,c,~] = size(im);
                strArray = gt{j};
                st = replace(strArray(1),"xml","png");
                if strcmp(st,fn)
                    item = strcat(strArray(2), ' GT');
                    h = str2num(strArray(3));
                    w = str2num(strArray(4));
                    minY = str2num(strArray(5));
                    minX = str2num(strArray(6)) ;
                    maxY = str2num(strArray(7));
                    maxX = str2num(strArray(8));
                    minY = minY / h * r;
                    minX = minX / w * c;
                    maxY = maxY / h * r;
                    maxX = maxX / w * c;
                    im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],item,'LineWidth',2,'Color','red','TextBoxOpacity',0.6);
                    imshow(im2)
                    im;
                end
            end
        end
    end
    
    [r,c,ch] = size(im);
    
    % TODO: Need to refactor and make it generic for any number of instances
    knife1M = zeros(r,c);
    knife2M = zeros(r,c);
    knife3M = zeros(r,c);
    gun1M = zeros(r,c);
    gun2M = zeros(r,c);
    gun3M = zeros(r,c);
	gun4M = zeros(r,c);
    gun5M = zeros(r,c);
    gun6M = zeros(r,c);
    wrench1M = zeros(r,c);
    wrench2M = zeros(r,c);
    pliers1M = zeros(r,c);
    pliers2M = zeros(r,c);
    scissor1M = zeros(r,c);
    scissor2M = zeros(r,c);
    scissor3M = zeros(r,c);
    scissor4M = zeros(r,c);
    scissor5M = zeros(r,c);
    hammer1M = zeros(r,c);
    
    isK1 = false;
    isK2 = false;
    isK3 = false;
    isG1 = false;
    isG2 = false;
    isG3 = false;
    isG4 = false;
    isG5 = false;
    isG6 = false;
    isW1 = false;
    isW2 = false;
    isP1 = false;
    isP2 = false;
    isS1 = false;
    isS2 = false;
    isS3 = false;
    isS4 = false;
    isS5 = false;
    isH1 = false;
    for k = 1:r
        for j = 1:c
            if im(k,j,1) == knife1(1) && im(k,j,2) == knife1(2) && im(k,j,3) == knife1(3)
                knife1M(k,j) = 1;
                isK1 = true;
            end
            
            if im(k,j,1) == knife2(1) && im(k,j,2) == knife2(2) && im(k,j,3) == knife2(3)
                knife2M(k,j) = 1;
                isK2 = true;
            end
            
            if im(k,j,1) == knife3(1) && im(k,j,2) == knife3(2) && im(k,j,3) == knife3(3)
                knife3M(k,j) = 1;
                isK3 = true;
            end
            
            if im(k,j,1) == gun1(1) && im(k,j,2) == gun1(2) && im(k,j,3) == gun1(3)
                gun1M(k,j) = 1;
                isG1 = true;
            end
            
            if im(k,j,1) == gun2(1) && im(k,j,2) == gun2(2) && im(k,j,3) == gun2(3)
                gun2M(k,j) = 1;
                isG2 = true;
            end
            
            if im(k,j,1) == gun3(1) && im(k,j,2) == gun3(2) && im(k,j,3) == gun3(3)
                gun3M(k,j) = 1;
                isG3 = true;
            end
            
            if im(k,j,1) == gun4(1) && im(k,j,2) == gun4(2) && im(k,j,3) == gun4(3)
                gun4M(k,j) = 1;
                isG4 = true;
            end
            
            if im(k,j,1) == gun5(1) && im(k,j,2) == gun5(2) && im(k,j,3) == gun5(3)
                gun5M(k,j) = 1;
                isG5 = true;
            end
            
            if im(k,j,1) == gun6(1) && im(k,j,2) == gun6(2) && im(k,j,3) == gun6(3)
                gun6M(k,j) = 1;
                isG6 = true;
            end
            
            if im(k,j,1) == wrench1(1) && im(k,j,2) == wrench1(2) && im(k,j,3) == wrench1(3)
                wrench1M(k,j) = 1;
                isW1 = true;
            end
            
            if im(k,j,1) == wrench2(1) && im(k,j,2) == wrench2(2) && im(k,j,3) == wrench2(3)
                wrench2M(k,j) = 1;
                isW2 = true;
            end
            
            if im(k,j,1) == pliers1(1) && im(k,j,2) == pliers1(2) && im(k,j,3) == pliers1(3)
                pliers1M(k,j) = 1;
                isP1 = true;
            end
            
            if im(k,j,1) == pliers2(1) && im(k,j,2) == pliers2(2) && im(k,j,3) == pliers2(3)
                pliers2M(k,j) = 1;
                isP2 = true;
            end
            
            if im(k,j,1) == scissor1(1) && im(k,j,2) == scissor1(2) && im(k,j,3) == scissor1(3)
                scissor1M(k,j) = 1;
                isS1 = true;
            end
            
            if im(k,j,1) == scissor2(1) && im(k,j,2) == scissor2(2) && im(k,j,3) == scissor2(3)
                scissor2M(k,j) = 1;
                isS2 = true;
            end
            
            if im(k,j,1) == scissor3(1) && im(k,j,2) == scissor3(2) && im(k,j,3) == scissor3(3)
                scissor3M(k,j) = 1;
                isS3 = true;
            end
            
            if im(k,j,1) == scissor4(1) && im(k,j,2) == scissor4(2) && im(k,j,3) == scissor4(3)
                scissor4M(k,j) = 1;
                isS4 = true;
            end
            
            if im(k,j,1) == scissor5(1) && im(k,j,2) == scissor5(2) && im(k,j,3) == scissor5(3)
                scissor5M(k,j) = 1;
                isS5 = true;
            end
            
            if im(k,j,1) == hammer1(1) && im(k,j,2) == hammer1(2) && im(k,j,3) == hammer1(3)
                hammer1M(k,j) = 1;
                isH1 = true;
            end
        end
    end
    
    % removing small blobs
    knife1M = imfill(bwareaopen(logical(knife1M),500),'holes');
    knife2M = imfill(bwareaopen(logical(knife2M),500),'holes');
    knife3M = imfill(bwareaopen(logical(knife3M),500),'holes');
    gun1M = imfill(bwareaopen(logical(gun1M),500),'holes');
    gun2M = imfill(bwareaopen(logical(gun2M),500),'holes');
    gun3M = imfill(bwareaopen(logical(gun3M),500),'holes');
	gun4M = imfill(bwareaopen(logical(gun4M),500),'holes');
    gun5M = imfill(bwareaopen(logical(gun5M),500),'holes');
    gun6M = imfill(bwareaopen(logical(gun6M),500),'holes');
    wrench1M = imfill(bwareaopen(logical(wrench1M),500),'holes');
    wrench2M = imfill(bwareaopen(logical(wrench1M),500),'holes');
    pliers1M = imfill(bwareaopen(logical(pliers1M),500),'holes');
    pliers2M = imfill(bwareaopen(logical(pliers2M),500),'holes');    
    scissor1M = imfill(bwareaopen(logical(scissor1M),500),'holes');
	scissor2M = imfill(bwareaopen(logical(scissor2M),500),'holes');
    scissor3M = imfill(bwareaopen(logical(scissor3M),500),'holes');
    scissor4M = imfill(bwareaopen(logical(scissor4M),500),'holes');
    scissor5M = imfill(bwareaopen(logical(scissor5M),500),'holes');
	hammer1M = imfill(bwareaopen(logical(hammer1M),500),'holes');

    knife1B = zeros(r,c);
    knife2B = zeros(r,c);
    knife3B = zeros(r,c);
    gun1B = zeros(r,c);
    gun2B = zeros(r,c);
    gun3B = zeros(r,c);
    gun4B = zeros(r,c);
    gun5B = zeros(r,c);
    gun6B = zeros(r,c);
    wrench1B = zeros(r,c);
    wrench2B = zeros(r,c);
    pliers1B = zeros(r,c);
    pliers2B = zeros(r,c);
    scissor1B = zeros(r,c);
    scissor2B = zeros(r,c);
    scissor3B = zeros(r,c);
    scissor4B = zeros(r,c);
    scissor5B = zeros(r,c);
    hammer1B = zeros(r,c);
       
    if maskComparisonOnly == false || bothComparison == true
        if isK1
            L = bwlabel(knife1M,8);
            for j = 1:max(max(L))
                [r,c] = find(knife1M == j);
                minX = min(c);
                minY = min(r);
                maxX = max(c);
                maxY = max(r);

                im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Knife','LineWidth',2,'Color','yellow','TextBoxOpacity',0.6);
                knife1B(r,c) = 1;
            end
        end

        if isK2
            L = bwlabel(knife2M,8);
            for j = 1:max(max(L))
                [r,c] = find(knife2M == j);
                minX = min(c);
                minY = min(r);
                maxX = max(c);
                maxY = max(r);

                im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Knife','LineWidth',2,'Color','yellow','TextBoxOpacity',0.6);
                knife2B(r,c) = 1;
            end
        end

        if isK3
            L = bwlabel(knife3M,8);
            for j = 1:max(max(L))
                [r,c] = find(knife3M == j);
                minX = min(c);
                minY = min(r);
                maxX = max(c);
                maxY = max(r);

                im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Knife','LineWidth',2,'Color','yellow','TextBoxOpacity',0.6);
                knife3B(r,c) = 1;
            end
        end

        if isG1 
            L = bwlabel(gun1M,8);
            for j = 1:max(max(L))
                [r,c] = find(gun1M == j);
                minX = min(c);
                minY = min(r);
                maxX = max(c);
                maxY = max(r);

                im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Gun','LineWidth',2,'Color','yellow','TextBoxOpacity',0.6,'TextColor','white');
                gun1B(r,c) = 1;
            end
        end

        if isG2
            L = bwlabel(gun2M,8);
            for j = 1:max(max(L))
                [r,c] = find(gun2M == j);
                minX = min(c);
                minY = min(r);
                maxX = max(c);
                maxY = max(r);

                im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Gun','LineWidth',2,'Color','yellow','TextBoxOpacity',0.6);
                gun2B(r,c) = 1;
            end
        end

        if isG3
            L = bwlabel(gun3M,8);
            for j = 1:max(max(L))
                [r,c] = find(gun3M == j);
                minX = min(c);
                minY = min(r);
                maxX = max(c);
                maxY = max(r);

                im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Gun','LineWidth',2,'Color','yellow','TextBoxOpacity',0.6);
                gun3B(r,c) = 1;
            end
        end

        if isG4
            L = bwlabel(gun4M,8);
            for j = 1:max(max(L))
                [r,c] = find(gun4M == j);
                minX = min(c);
                minY = min(r);
                maxX = max(c);
                maxY = max(r);

                im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Gun','LineWidth',2,'Color','yellow','TextBoxOpacity',0.6);
                gun4B(r,c) = 1;
            end
        end

        if isG5
            L = bwlabel(gun5M,8);
            for j = 1:max(max(L))
                [r,c] = find(gun5M == j);
                minX = min(c);
                minY = min(r);
                maxX = max(c);
                maxY = max(r);

                im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Gun','LineWidth',2,'Color','yellow','TextBoxOpacity',0.6);
                gun5B(r,c) = 1;
            end
        end

        if isG6
            L = bwlabel(gun6M,8);
            for j = 1:max(max(L))
                [r,c] = find(gun6M == j);
                minX = min(c);
                minY = min(r);
                maxX = max(c);
                maxY = max(r);

                im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Gun','LineWidth',2,'Color','yellow','TextBoxOpacity',0.6);
                gun6B(r,c) = 1;
            end
        end

        if isW1
            L = bwlabel(wrench1M,8);
            for j = 1:max(max(L))
                [r,c] = find(wrench1M == j);
                minX = min(c);
                minY = min(r);
                maxX = max(c);
                maxY = max(r);

                im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Wrench','LineWidth',2,'Color','yellow','TextBoxOpacity',0.6);
                wrench1B(r,c) = 1;
            end
        end

        if isW2
            L = bwlabel(wrench2M,8);
            for j = 1:max(max(L))
                [r,c] = find(wrench2M == j);
                minX = min(c);
                minY = min(r);
                maxX = max(c);
                maxY = max(r);

                im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Wrench','LineWidth',2,'Color','yellow','TextBoxOpacity',0.6);
                wrench2B(r,c) = 1;
            end
        end

        if isP1
            L = bwlabel(pliers1M,8);
            for j = 1:max(max(L))
                [r,c] = find(pliers1M == j);
                minX = min(c);
                minY = min(r);
                maxX = max(c);
                maxY = max(r);

                im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Pliers','LineWidth',2,'Color','yellow','TextBoxOpacity',0.6);
                pliers1B(r,c) = 1;
            end
        end

        if isP2
            L = bwlabel(pliers2M,8);
            for j = 1:max(max(L))
                [r,c] = find(pliers2M == j);
                minX = min(c);
                minY = min(r);
                maxX = max(c);
                maxY = max(r);

                im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Pliers','LineWidth',2,'Color','yellow','TextBoxOpacity',0.6);
                pliers2B(r,c) = 1;
            end
        end

        if isS1
            L = bwlabel(scissor1M,8);
            for j = 1:max(max(L))
                [r,c] = find(scissor1M == j);
                minX = min(c);
                minY = min(r);
                maxX = max(c);
                maxY = max(r);

                im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Scissor','LineWidth',2,'Color','yellow','TextBoxOpacity',0.6);
                scissor1B(r,c) = 1;
            end
        end

        if isS2
            L = bwlabel(scissor2M,8);
            for j = 1:max(max(L))
                [r,c] = find(scissor2M == j);
                minX = min(c);
                minY = min(r);
                maxX = max(c);
                maxY = max(r);

                im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Scissor','LineWidth',2,'Color','yellow','TextBoxOpacity',0.6);
                scissor2B(r,c) = 1;
            end
        end

        if isS3
            L = bwlabel(scissor3M,8);
            for j = 1:max(max(L))
                [r,c] = find(scissor3M == j);
                minX = min(c);
                minY = min(r);
                maxX = max(c);
                maxY = max(r);

                im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Scissor','LineWidth',2,'Color','yellow','TextBoxOpacity',0.6);
                scissor3B(r,c) = 1;
            end
        end

        if isS4
            L = bwlabel(scissor4M,8);
            for j = 1:max(max(L))
                [r,c] = find(scissor4M == j);
                minX = min(c);
                minY = min(r);
                maxX = max(c);
                maxY = max(r);

                im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Scissor','LineWidth',2,'Color','yellow','TextBoxOpacity',0.6);
                scissor4B(r,c) = 1;
            end
        end

        if isS5
            L = bwlabel(scissor5M,8);
            for j = 1:max(max(L))
                [r,c] = find(scissor5M == j);
                minX = min(c);
                minY = min(r);
                maxX = max(c);
                maxY = max(r);

                im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Scissor','LineWidth',2,'Color','yellow','TextBoxOpacity',0.6);
                scissor5B(r,c) = 1;
            end
        end

        if isH1
            L = bwlabel(hammer1M,8);
            for j = 1:max(max(L))
                [r,c] = find(hammer1M == j);
                minX = min(c);
                minY = min(r);
                maxX = max(c);
                maxY = max(r);

                im2 = insertObjectAnnotation(im2,'Rectangle',[minX,minY,maxX-minX,maxY-minY],'Hammer','LineWidth',2,'Color','yellow','TextBoxOpacity',0.6);
                hammer1B(r,c) = 1;
            end
        end
    end
    
    h=imshow(im2);
    if bBoxComparisonOnly == false || bothComparison == true
        hold on

        if isK1
            [r,c] = find(knife1M == 1);
            scatter(c,r,'r.','MarkerEdgeAlpha',0.07); 
            [r,c] = find(edge(knife1M,'canny') == 1);
            plot(c,r,'r.');
        end

        if isK2
            [r,c] = find(knife2M == 1);
            scatter1 = scatter(c,r,'g.','MarkerEdgeAlpha',0.07);
            [r,c] = find(edge(knife2M,'canny') == 1);
            plot(c,r,'g.');
        end

        if isK3
            [r,c] = find(knife3M == 1);
            scatter1 = scatter(c,r,'b.','MarkerEdgeAlpha',0.07);
            [r,c] = find(edge(knife3M,'canny') == 1);
            plot(c,r,'b.');
        end

        if isG1
            [r,c] = find(gun1M == 1);
            scatter1 = scatter(c,r,'k.','MarkerEdgeAlpha',0.07);
            [r,c] = find(edge(gun1M,'canny') == 1);
            plot(c,r,'k.');
        end

        if isG2
            [r,c] = find(gun2M == 1);
            scatter1 = scatter(c,r,'m.','MarkerEdgeAlpha',0.07);
            [r,c] = find(edge(gun2M,'canny') == 1);
            plot(c,r,'m.');
        end

        if isG3
            [r,c] = find(gun3M == 1);
            scatter1 = scatter(c,r,'c.','MarkerEdgeAlpha',0.07);
            [r,c] = find(edge(gun3M,'canny') == 1);
            plot(c,r,'c.');
        end

        if isG4
            [r,c] = find(gun4M == 1);
            scatter1 = scatter(c,r,'c.','MarkerEdgeAlpha',0.07);
            [r,c] = find(edge(gun4M,'canny') == 1);
            plot(c,r,'g.');
        end

        if isG5
            [r,c] = find(gun5M == 1);
            scatter1 = scatter(c,r,'c.','MarkerEdgeAlpha',0.07);
            [r,c] = find(edge(gun5M,'canny') == 1);
            plot(c,r,'b.');
        end

        if isG6
            [r,c] = find(gun6M == 1);
            scatter1 = scatter(c,r,'c.','MarkerEdgeAlpha',0.07);
            [r,c] = find(edge(gun6M,'canny') == 1);
            plot(c,r,'r.');
        end

        if isW1
            [r,c] = find(wrench1M == 1);
            scatter1 = scatter(c,r,'y.','MarkerEdgeAlpha',0.07);
            [r,c] = find(edge(wrench1M,'canny') == 1);
            plot(c,r,'y.');
        end

        if isW2
            [r,c] = find(wrench2M == 1);
            scatter1 = scatter(c,r,'y.','MarkerEdgeAlpha',0.07);
            [r,c] = find(edge(wrench2M,'canny') == 1);
            plot(c,r,'k.');
        end

        if isS1
            [r,c] = find(scissor1M == 1);
            scatter1 = scatter(c,r,'y.','MarkerEdgeAlpha',0.07);
            [r,c] = find(edge(scissor1M,'canny') == 1);
            plot(c,r,'r.');
        end

        if isS2
            [r,c] = find(scissor2M == 1);
            scatter1 = scatter(c,r,'y.','MarkerEdgeAlpha',0.07);
            [r,c] = find(edge(scissor2M,'canny') == 1);
            plot(c,r,'g.');
        end

        if isS3
            [r,c] = find(scissor3M == 1);
            scatter1 = scatter(c,r,'y.','MarkerEdgeAlpha',0.07);
            [r,c] = find(edge(scissor3M,'canny') == 1);
            plot(c,r,'y.');
        end

        if isS4
            [r,c] = find(scissor4M == 1);
            scatter1 = scatter(c,r,'y.','MarkerEdgeAlpha',0.07);
            [r,c] = find(edge(scissor4M,'canny') == 1);
            plot(c,r,'b.');
        end

        if isS5
            [r,c] = find(scissor5M == 1);
            scatter1 = scatter(c,r,'y.','MarkerEdgeAlpha',0.07);
            [r,c] = find(edge(scissor5M,'canny') == 1);
            plot(c,r,'k.');
        end

        if isP1
            [r,c] = find(pliers1M == 1);
            scatter1 = scatter(c,r,'y.','MarkerEdgeAlpha',0.07);
            [r,c] = find(edge(pliers1M,'canny') == 1);
            plot(c,r,'m.');
        end

        if isP2
            [r,c] = find(pliers2M == 1);
            scatter1 = scatter(c,r,'y.','MarkerEdgeAlpha',0.07);
            [r,c] = find(edge(pliers2M,'canny') == 1);
            plot(c,r,'c.');
        end

        if isH1
            [r,c] = find(hammer1M == 1);
            scatter1 = scatter(c,r,'y.','MarkerEdgeAlpha',0.07);
            [r,c] = find(edge(hammer1M,'canny') == 1);
            plot(c,r,'y.');
        end
        
        axis off tight
        hold off
        
        if maskComparisonOnly
            saveas(gcf,['results\sixray\maskResults\' fn],'png');
        end
    end
    
    if bBoxComparisonOnly
        imwrite(im2,['results\sixray\comparison_with_original_bboxes\' fn],'PNG');
    end
end