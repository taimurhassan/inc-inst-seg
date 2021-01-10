% This is an optional script which applies pseudo-coloring and some
% post-processing to the output of the CIE-Net for the COCO
% dataset scans. Moreover, the segmentation coloring scheme of CIE-Net
% can also be changed by modifying the 'class_colors' list in
% 'codebase\data_utils\data_loader.py'.

clc
clear all
close all

% change this as per your system location
pn2 = 'testingDataset\segmentation_results\';
pn = 'testingDataset\test_images\';
pn3 = 'testingDataset\original\';

ext_img = [pn '*.png'];
a = dir(ext_img);
nfile = length(a);
proposals = {};
obj = [];

% update these color codes and categories as per your choice 
bg = [20 215 197];
airplane = [207 248 132];
person1 = [183 244 155];
person2 = [144 71 111];
person3 = [128 48 71];
person4 = [50 158 75];
person5 = [241 169 37];

ball1 = [214 110 120];
ball2 = [228 84 23];
elephant1 = [252 230 140];
elephant2 = [41 212 198];
elephant3 = [171 98 0];
elephant4 = [114 122 81];
tie = [166 42 182];
keyboard1 = [171 249 59];
keyboard2 = [8 124 97];
chair = [32 166 124];
teddy1 = [23 171 40];
teddy2 = [122 69 143];
teddy3 = [147 180 246];
teddy4 = [158 67 183];
snowboard = [214 205 16];

laptop1 = [244 104 161];
laptop2 = [31 133 226];
table = [149 154 55];
book = [46 227 147];
racket = [141 200 41];
bench = [133 16 95];
plant = [19 76 66];
cup = [45 35 243];

for i=1:nfile
    fn = a(i).name; 
    img = imread([pn fn]);
    img2 = imread([pn2 fn]);
    
    [r,c,ch] = size(img2);
    im = uint8(zeros(r,c,3));
    im(:,:,1) = 0;
    im(:,:,2) = 0;
    im(:,:,3) = 0;
    
    im3 = im;
    
    airplanem = zeros(r,c,3);
    person1m = zeros(r,c,3);
    person2m = zeros(r,c,3);
    person3m = zeros(r,c,3);
    person4m = zeros(r,c,3);
    person5m = zeros(r,c,3);
    
    ball1m = zeros(r,c,3);
    
    laptop1m = zeros(r,c,3);
    laptop2m = zeros(r,c,3);
    tablem = zeros(r,c,3);
    
    ball2m = zeros(r,c,3);
    elephant1m = zeros(r,c,3);
    elephant2m = zeros(r,c,3);
    
    bookm = zeros(r,c,3);
    
    elephant3m = zeros(r,c,3);
    elephant4m = zeros(r,c,3);
    
    racket1m = zeros(r,c,3);
    
    tiem = zeros(r,c,3);
	
    bench1m = zeros(r,c,3);
    
    chairm = zeros(r,c,3);
    teddy1m = zeros(r,c,3);
    
    plant1m = zeros(r,c,3);
    cup1m = zeros(r,c,3);
    
	teddy2m = zeros(r,c,3);
	teddy3m = zeros(r,c,3);
	teddy4m = zeros(r,c,3);
	snowboardm = zeros(r,c,3);
    
    for i = 1:r
        for j = 1:c
            if img2(i,j,1) == airplane(1) && img2(i,j,2) == airplane(2) && img2(i,j,3) == airplane(3)
                airplanem(i,j,1) = airplane(1);
                airplanem(i,j,2) = airplane(2);
                airplanem(i,j,3) = airplane(3);
            elseif img2(i,j,1) == person1(1) && img2(i,j,2) == person1(2) && img2(i,j,3) == person1(3)
                person1m(i,j,1) = person1(1);
                person1m(i,j,2) = person1(2);
                person1m(i,j,3) = person1(3);
            elseif img2(i,j,1) == person2(1) && img2(i,j,2) == person2(2) && img2(i,j,3) == person2(3)
                person2m(i,j,1) = person2(1);
                person2m(i,j,2) = person2(2);
                person2m(i,j,3) = person2(3);
            elseif img2(i,j,1) == person3(1) && img2(i,j,2) == person3(2) && img2(i,j,3) == person3(3)
                person3m(i,j,1) = person3(1);
                person3m(i,j,2) = person3(2);
                person3m(i,j,3) = person3(3);
            elseif img2(i,j,1) == person4(1) && img2(i,j,2) == person4(2) && img2(i,j,3) == person4(3)
                person4m(i,j,1) = person4(1);
                person4m(i,j,2) = person4(2);
                person4m(i,j,3) = person4(3);
            elseif img2(i,j,1) == person5(1) && img2(i,j,2) == person5(2) && img2(i,j,3) == person5(3)
                person5m(i,j,1) = person5(1);
                person5m(i,j,2) = person5(2);
                person5m(i,j,3) = person5(3);
            elseif img2(i,j,1) == ball1(1) && img2(i,j,2) == ball1(2) && img2(i,j,3) == ball1(3)
                ball1m(i,j,1) = ball1(1);
                ball1m(i,j,2) = ball1(2);
                ball1m(i,j,3) = ball1(3);
            elseif img2(i,j,1) == laptop1(1) && img2(i,j,2) == laptop1(2) && img2(i,j,3) == laptop1(3)
                laptop1m(i,j,1) = laptop1(1);
                laptop1m(i,j,2) = laptop1(2);
                laptop1m(i,j,3) = laptop1(3);
            elseif img2(i,j,1) == keyboard1(1) && img2(i,j,2) == keyboard1(2) && img2(i,j,3) == keyboard1(3)
                laptop1m(i,j,1) = laptop1(1);
                laptop1m(i,j,2) = laptop1(2);
                laptop1m(i,j,3) = laptop1(3);
            elseif img2(i,j,1) == laptop2(1) && img2(i,j,2) == laptop2(2) && img2(i,j,3) == laptop2(3)
                laptop2m(i,j,1) = laptop2(1);
                laptop2m(i,j,2) = laptop2(2);
                laptop2m(i,j,3) = laptop2(3);
            elseif img2(i,j,1) == keyboard2(1) && img2(i,j,2) == keyboard2(2) && img2(i,j,3) == keyboard2(3)
                laptop2m(i,j,1) = laptop2(1);
                laptop2m(i,j,2) = laptop2(2);
                laptop2m(i,j,3) = laptop2(3);
            elseif img2(i,j,1) == table(1) && img2(i,j,2) == table(2) && img2(i,j,3) == table(3)
                tablem(i,j,1) = table(1);
                tablem(i,j,2) = table(2);
                tablem(i,j,3) = table(3);
            elseif img2(i,j,1) == ball2(1) && img2(i,j,2) == ball2(2) && img2(i,j,3) == ball2(3)
                ball2m(i,j,1) = ball2(1);
                ball2m(i,j,2) = ball2(2);
                tablem(i,j,3) = ball2(3);
            elseif img2(i,j,1) == elephant2(1) && img2(i,j,2) == elephant2(2) && img2(i,j,3) == elephant2(3)
                elephant2m(i,j,1) = elephant2(1);
                elephant2m(i,j,2) = elephant2(2);
                elephant2m(i,j,3) = elephant2(3);
            elseif img2(i,j,1) == book(1) && img2(i,j,2) == book(2) && img2(i,j,3) == book(3)
                bookm(i,j,1) = book(1);
                bookm(i,j,2) = book(2);
                bookm(i,j,3) = book(3);
            elseif img2(i,j,1) == elephant3(1) && img2(i,j,2) == elephant3(2) && img2(i,j,3) == elephant3(3)
                elephant3m(i,j,1) = elephant3(1);
                elephant3m(i,j,2) = elephant3(2);
                elephant3m(i,j,3) = elephant3(3);
            elseif img2(i,j,1) == elephant4(1) && img2(i,j,2) == elephant4(2) && img2(i,j,3) == elephant4(3)
                elephant4m(i,j,1) = elephant4(1);
                elephant4m(i,j,2) = elephant4(2);
                elephant4m(i,j,3) = elephant4(3);
            elseif img2(i,j,1) == tie(1) && img2(i,j,2) == tie(2) && img2(i,j,3) == tie(3)
                tiem(i,j,1) = tie(1);
                tiem(i,j,2) = tie(2);
                tiem(i,j,3) = tie(3);
            elseif img2(i,j,1) == chair(1) && img2(i,j,2) == chair(2) && img2(i,j,3) == chair(3)
                chairm(i,j,1) = chair(1);
                chairm(i,j,2) = chair(2);
                chairm(i,j,3) = chair(3);
            elseif img2(i,j,1) == teddy1(1) && img2(i,j,2) == teddy1(2) && img2(i,j,3) == teddy1(3)
                teddy1m(i,j,1) = teddy1(1);
                teddy1m(i,j,2) = teddy1(2);
                teddy1m(i,j,3) = teddy1(3);
            elseif img2(i,j,1) == elephant1(1) && img2(i,j,2) == elephant1(2) && img2(i,j,3) == elephant1(3)
                elephant1m(i,j,1) = elephant1(1);
                elephant1m(i,j,2) = elephant1(2);
                elephant1m(i,j,3) = elephant1(3);
            elseif img2(i,j,1) == bench(1) && img2(i,j,2) == bench(2) && img2(i,j,3) == bench(3)
                bench1m(i,j,1) = bench(1);
                bench1m(i,j,2) = bench(2);
                bench1m(i,j,3) = bench(3);
            elseif img2(i,j,1) == cup(1) && img2(i,j,2) == cup(2) && img2(i,j,3) == cup(3)
                cup1m(i,j,1) = cup(1);
                cup1m(i,j,2) = cup(2);
                cup1m(i,j,3) = cup(3);
            elseif img2(i,j,1) == plant(1) && img2(i,j,2) == plant(2) && img2(i,j,3) == plant(3)
                plant1m(i,j,1) = plant(1);
                plant1m(i,j,2) = plant(2);
                plant1m(i,j,3) = plant(3);
            elseif img2(i,j,1) == racket(1) && img2(i,j,2) == racket(2) && img2(i,j,3) == racket(3)
                racket1m(i,j,1) = racket(1);
                racket1m(i,j,2) = racket(2);
                racket1m(i,j,3) = racket(3);
            elseif img2(i,j,1) == teddy2(1) && img2(i,j,2) == teddy2(2) && img2(i,j,3) == teddy2(3)
                teddy2m(i,j,1) = teddy2(1);
                teddy2m(i,j,2) = teddy2(2);
                teddy2m(i,j,3) = teddy2(3);
            elseif img2(i,j,1) == teddy3(1) && img2(i,j,2) == teddy3(2) && img2(i,j,3) == teddy3(3)
                teddy3m(i,j,1) = teddy3(1);
                teddy3m(i,j,2) = teddy3(2);
                teddy3m(i,j,3) = teddy3(3);
            elseif img2(i,j,1) == teddy4(1) && img2(i,j,2) == teddy4(2) && img2(i,j,3) == teddy4(3)
                teddy4m(i,j,1) = teddy4(1);
                teddy4m(i,j,2) = teddy4(2);
                teddy4m(i,j,3) = teddy4(3);
            elseif img2(i,j,1) == snowboard(1) && img2(i,j,2) == snowboard(2) && img2(i,j,3) == snowboard(3)
                snowboardm(i,j,1) = snowboard(1);
                snowboardm(i,j,2) = snowboard(2);
                snowboardm(i,j,3) = snowboard(3);
            end
        end
    end
    
    threshold = 600;
    
    g1 = bwareaopen(imbinarize(rgb2gray(airplanem),0.1),threshold);
    g2 = imfill(imdilate(bwareaopen(imbinarize(rgb2gray(person1m),0.1),threshold),strel('disk',3)),'holes');
    g3 = bwareaopen(imbinarize(rgb2gray(person2m),0.1),threshold-300);
    g4 = bwareaopen(imbinarize(rgb2gray(person3m),0.1),threshold);
    g5 = bwareaopen(imbinarize(rgb2gray(person4m),0.1),threshold);
    g6 = bwareaopen(imbinarize(rgb2gray(person5m),0.1),threshold);
    k1 = bwareaopen(imbinarize(rgb2gray(ball1m),0.1),threshold-500);
    k2 = imdilate(bwareaopen(imbinarize(rgb2gray(laptop1m),0.1),threshold), strel('disk',3));
    k3 = imdilate(bwareaopen(imbinarize(rgb2gray(laptop2m),0.1),threshold), strel('disk',3));
    s1 = bwareaopen(imbinarize(rgb2gray(tablem),0.1),threshold);
    s2 = bwareaopen(imbinarize(rgb2gray(ball2m),0.1),threshold-500);
    r1 = bwareaopen(imbinarize(rgb2gray(elephant2m),0.1),threshold);
    r2 = bwareaopen(imbinarize(rgb2gray(bookm),0.1),threshold+1500);
    w1 = bwareaopen(imbinarize(rgb2gray(elephant3m),0.1),threshold);
    w2 = bwareaopen(imbinarize(rgb2gray(elephant4m),0.1),threshold);
    sc1 = bwareaopen(imbinarize(rgb2gray(tiem),0.1),threshold-500);
    p1 = bwareaopen(imbinarize(rgb2gray(chairm),0.1),threshold+15500);
    p2 = bwareaopen(imbinarize(rgb2gray(teddy1m),0.1),threshold);
    
    p3 = bwareaopen(imbinarize(rgb2gray(teddy2m),0.1),threshold);
    p4 = bwareaopen(imbinarize(rgb2gray(teddy3m),0.1),threshold);
    p5 = bwareaopen(imbinarize(rgb2gray(teddy4m),0.1),threshold);
    p6 = bwareaopen(imbinarize(rgb2gray(snowboardm),0.1),threshold);
    
    st1 = bwareaopen(imbinarize(rgb2gray(elephant1m),0.1),threshold);
    scr1 = bwareaopen(imbinarize(rgb2gray(bench1m),0.1),threshold+15500);
    po1 = bwareaopen(imbinarize(rgb2gray(cup1m),0.1),threshold-500);
    h1 = bwareaopen(imbinarize(rgb2gray(plant1m),0.1),threshold-500);
    a1 = bwareaopen(imbinarize(rgb2gray(racket1m),0.1),threshold);
    
    airplanem = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(airplanem),0.1),threshold),'canny'),'skel');
    person1m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(person1m),0.1),threshold),'canny'),'skel');
    person2m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(person2m),0.1),threshold-500),'canny'),'skel');
    person3m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(person3m),0.1),threshold),'canny'),'skel');
    person4m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(person4m),0.1),threshold),'canny'),'skel');
    person5m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(person5m),0.1),threshold),'canny'),'skel');
    ball1m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(ball1m),0.1),threshold-500),'canny'),'skel');
%     laptop1m = imdilate(bwmorph(edge(bwareaopen(imbinarize(rgb2gray(laptop1m),0.1),threshold),'canny'),'skel'),strel('disk',5));
%     laptop2m = imdilate(bwmorph(edge(bwareaopen(imbinarize(rgb2gray(laptop2m),0.1),threshold),'canny'),'skel'),strel('disk',5));
    tablem = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(tablem),0.1),threshold),'canny'),'skel');
    ball2m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(ball2m),0.1),threshold-500),'canny'),'skel');
    elephant2m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(elephant2m),0.1),threshold),'canny'),'skel');
    bookm = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(bookm),0.1),threshold-500),'canny'),'skel');
    elephant3m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(elephant3m),0.1),threshold),'canny'),'skel');
    elephant4m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(elephant4m),0.1),threshold),'canny'),'skel');
    tiem = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(tiem),0.1),threshold-500),'canny'),'skel');
    chairm = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(chairm),0.1),threshold),'canny'),'skel');
    teddy1m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(teddy1m),0.1),threshold),'canny'),'skel');
    
    teddy2m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(teddy2m),0.1),threshold),'canny'),'skel');
    teddy3m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(teddy3m),0.1),threshold),'canny'),'skel');
    teddy4m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(teddy4m),0.1),threshold),'canny'),'skel');
    snowboardm = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(snowboardm),0.1),threshold),'canny'),'skel');
    
    elephant1m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(elephant1m),0.1),threshold),'canny'),'skel');
	bench1m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(bench1m),0.1),threshold),'canny'),'skel');
    cup1m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(cup1m),0.1),threshold-500),'canny'),'skel');
    plant1m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(plant1m),0.1),threshold),'canny'),'skel');
    racket1m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(racket1m),0.1),threshold),'canny'),'skel');
    
    im(:,:,1) = im(:,:,1) + airplane(1) * uint8(g1);
    im(:,:,2) = im(:,:,2) + airplane(2) * uint8(g1);
    im(:,:,3) = im(:,:,3) + airplane(3) * uint8(g1);
    
    im(:,:,1) = im(:,:,1) + person1(1) * uint8(g2);
    im(:,:,2) = im(:,:,2) + person1(2) * uint8(g2);
    im(:,:,3) = im(:,:,3) + person1(3) * uint8(g2);
    
    im(:,:,1) = im(:,:,1) + person2(1) * uint8(g3);
    im(:,:,2) = im(:,:,2) + person2(2) * uint8(g3);
    im(:,:,3) = im(:,:,3) + person2(3) * uint8(g3);
    
    im(:,:,1) = im(:,:,1) + person3(1) * uint8(g4);
    im(:,:,2) = im(:,:,2) + person3(2) * uint8(g4);
    im(:,:,3) = im(:,:,3) + person3(3) * uint8(g4);
    
    im(:,:,1) = im(:,:,1) + person4(1) * uint8(g5);
    im(:,:,2) = im(:,:,2) + person4(2) * uint8(g5);
    im(:,:,3) = im(:,:,3) + person4(3) * uint8(g5);
    
    im(:,:,1) = im(:,:,1) + person5(1) * uint8(g6);
    im(:,:,2) = im(:,:,2) + person5(2) * uint8(g6);
    im(:,:,3) = im(:,:,3) + person5(3) * uint8(g6);
    
    im(:,:,1) = im(:,:,1) + ball1(1) * uint8(k1);
    im(:,:,2) = im(:,:,2) + ball1(2) * uint8(k1);
    im(:,:,3) = im(:,:,3) + ball1(3) * uint8(k1);
    
    im(:,:,1) = im(:,:,1) + laptop1(1) * uint8(k2);
    im(:,:,2) = im(:,:,2) + laptop1(2) * uint8(k2);
    im(:,:,3) = im(:,:,3) + laptop1(3) * uint8(k2);
    
    im(:,:,1) = im(:,:,1) + laptop2(1) * uint8(k3);
    im(:,:,2) = im(:,:,2) + laptop2(2) * uint8(k3);
    im(:,:,3) = im(:,:,3) + laptop2(3) * uint8(k3);
    
    im(:,:,1) = im(:,:,1) + table(1) * uint8(s1);
    im(:,:,2) = im(:,:,2) + table(2) * uint8(s1);
    im(:,:,3) = im(:,:,3) + table(3) * uint8(s1);
    
    im(:,:,1) = im(:,:,1) + ball2(1) * uint8(s2);
    im(:,:,2) = im(:,:,2) + ball2(2) * uint8(s2);
    im(:,:,3) = im(:,:,3) + ball2(3) * uint8(s2);
    
    im(:,:,1) = im(:,:,1) + elephant2(1) * uint8(r1);
    im(:,:,2) = im(:,:,2) + elephant2(2) * uint8(r1);
    im(:,:,3) = im(:,:,3) + elephant2(3) * uint8(r1);
    
    im(:,:,1) = im(:,:,1) + book(1) * uint8(r2);
    im(:,:,2) = im(:,:,2) + book(2) * uint8(r2);
    im(:,:,3) = im(:,:,3) + book(3) * uint8(r2);
    
    im(:,:,1) = im(:,:,1) + elephant3(1) * uint8(w1);
    im(:,:,2) = im(:,:,2) + elephant3(2) * uint8(w1);
    im(:,:,3) = im(:,:,3) + elephant3(3) * uint8(w1);
    
    im(:,:,1) = im(:,:,1) + elephant4(1) * uint8(w2);
    im(:,:,2) = im(:,:,2) + elephant4(2) * uint8(w2);
    im(:,:,3) = im(:,:,3) + elephant4(3) * uint8(w2);
    
    im(:,:,1) = im(:,:,1) + tie(1) * uint8(sc1);
    im(:,:,2) = im(:,:,2) + tie(2) * uint8(sc1);
    im(:,:,3) = im(:,:,3) + tie(3) * uint8(sc1);
    
    im(:,:,1) = im(:,:,1) + chair(1) * uint8(p1);
    im(:,:,2) = im(:,:,2) + chair(2) * uint8(p1);
    im(:,:,3) = im(:,:,3) + chair(3) * uint8(p1);
    
    im(:,:,1) = im(:,:,1) + teddy1(1) * uint8(p2);
    im(:,:,2) = im(:,:,2) + teddy1(2) * uint8(p2);
    im(:,:,3) = im(:,:,3) + teddy1(3) * uint8(p2);
    
    im(:,:,1) = im(:,:,1) + teddy2(1) * uint8(p3);
    im(:,:,2) = im(:,:,2) + teddy2(2) * uint8(p3);
    im(:,:,3) = im(:,:,3) + teddy2(3) * uint8(p3);
    
    im(:,:,1) = im(:,:,1) + teddy3(1) * uint8(p4);
    im(:,:,2) = im(:,:,2) + teddy3(2) * uint8(p4);
    im(:,:,3) = im(:,:,3) + teddy3(3) * uint8(p4);
    
    im(:,:,1) = im(:,:,1) + teddy4(1) * uint8(p5);
    im(:,:,2) = im(:,:,2) + teddy4(2) * uint8(p5);
    im(:,:,3) = im(:,:,3) + teddy4(3) * uint8(p5);
    
    im(:,:,1) = im(:,:,1) + snowboard(1) * uint8(p6);
    im(:,:,2) = im(:,:,2) + snowboard(2) * uint8(p6);
    im(:,:,3) = im(:,:,3) + snowboard(3) * uint8(p6);
    
    im(:,:,1) = im(:,:,1) + elephant1(1) * uint8(st1);
    im(:,:,2) = im(:,:,2) + elephant1(2) * uint8(st1);
    im(:,:,3) = im(:,:,3) + elephant1(3) * uint8(st1);
    
    im(:,:,1) = im(:,:,1) + bench(1) * uint8(scr1);
    im(:,:,2) = im(:,:,2) + bench(2) * uint8(scr1);
    im(:,:,3) = im(:,:,3) + bench(3) * uint8(scr1);
    
    im(:,:,1) = im(:,:,1) + cup(1) * uint8(po1);
    im(:,:,2) = im(:,:,2) + cup(2) * uint8(po1);
    im(:,:,3) = im(:,:,3) + cup(3) * uint8(po1);
    
    im(:,:,1) = im(:,:,1) + plant(1) * uint8(h1);
    im(:,:,2) = im(:,:,2) + plant(2) * uint8(h1);
    im(:,:,3) = im(:,:,3) + plant(3) * uint8(h1);
    
    im(:,:,1) = im(:,:,1) + racket(1) * uint8(a1);
    im(:,:,2) = im(:,:,2) + racket(2) * uint8(a1);
    im(:,:,3) = im(:,:,3) + racket(3) * uint8(a1);
    
    imwrite(im,[pn2 'results4\' fn],'PNG');
    
    fn2 = replace(fn,'png','jpg');
    
    % this is to display the output of the proposed framework on the
    % original scans
    if exist([pn3 fn])
        im2 = imread([pn3 fn]);
    else
        im2 = imread([pn3 fn2]);
    end
    
    
    if max(max(snowboardm)) ~= 0
        [r,c] = find(p6 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
                
        im2 = imoverlay(im2,p6,snowboard/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'snowboard','FontSize',28,'LineWidth',4);
%         for k = 1:length(ab)
            
%         end
    end
    
    if max(max(airplanem)) ~= 0
        [r,c] = find(g1 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
        
        im2 = imoverlay(im2,g1,airplane/255);
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'airplane','FontSize',28,'LineWidth',4);
    end
    
    
    if max(max(tablem)) ~= 0
        [r,c] = find(s1 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
        
        im2 = imoverlay(im2,s1,table/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'dining table','FontSize',28,'LineWidth',4);
    end
    
    
    if max(max(person1m)) ~= 0
        [r,c] = find(g2 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
        
        im2 = imoverlay(im2,g2,person1/255);
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'person','FontSize',28,'LineWidth',4);
    end
    
    if max(max(person2m)) ~= 0
        [r,c] = find(g3 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
        
        im2 = imoverlay(im2,g3,person2/255);
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'person','FontSize',28,'LineWidth',4);
    end
    
    if max(max(person3m)) ~= 0
        [r,c] = find(g4 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
        
        im2 = imoverlay(im2,g4,person3/255);
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'person','FontSize',28,'LineWidth',4);
    end
    
    if max(max(person4m)) ~= 0
        [r,c] = find(g5 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
        
        im2 = imoverlay(im2,g5,person4/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'person','FontSize',28,'LineWidth',4);
    end
    
    if max(max(person5m)) ~= 0
        [r,c] = find(g6 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
        
        im2 = imoverlay(im2,g6,person5/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'person','FontSize',28,'LineWidth',4);
    end
    
    if max(max(ball1m)) ~= 0
        [r,c] = find(k1 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];

        im2 = imoverlay(im2,k1,ball1/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'sports ball','FontSize',28,'LineWidth',4);
    end
    
    if max(max(laptop1m)) ~= 0
        [r,c] = find(k2 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
        
        im2 = imoverlay(im2,k2,laptop1/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'laptop','FontSize',28,'LineWidth',4);        
    end
    
    if max(max(laptop2m)) ~= 0
        [r,c] = find(k3 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
        
        im2 = imoverlay(im2,k3,laptop2/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'laptop','FontSize',28,'LineWidth',4);
    end
    
    if max(max(ball2m)) ~= 0
        [r,c] = find(s2 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];

        im2 = imoverlay(im2,s2,ball2/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'sports ball','FontSize',28,'LineWidth',4);        
    end
    
    if max(max(elephant2m)) ~= 0
        [r,c] = find(r1 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
        
        im2 = imoverlay(im2,r1,elephant2/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'elephant','FontSize',28,'LineWidth',4);
    end
    
    if max(max(bookm)) ~= 0
        [r,c] = find(r2 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
        
        im2 = imoverlay(im2,r2,book/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'book','FontSize',28,'LineWidth',4);
%         for k = 1:length(ab)
            
%         end
    end
    
    if max(max(elephant3m)) ~= 0
        [r,c] = find(w1 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
     
        im2 = imoverlay(im2,w1,elephant3/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'elephant','FontSize',28,'LineWidth',4);
    end
    
    if max(max(elephant4m)) ~= 0
        [r,c] = find(w2 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
        
        im2 = imoverlay(im2,w2,elephant4/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'elephant','FontSize',28,'LineWidth',4);
    end
    
    if max(max(tiem)) ~= 0
        [r,c] = find(sc1 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
        
        im2 = imoverlay(im2,sc1,tie/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'tie','FontSize',28,'LineWidth',4);
    end
    
    if max(max(chairm)) ~= 0
        [r,c] = find(p1 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
        
        im2 = imoverlay(im2,p1,chair/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'chair','FontSize',28,'LineWidth',4);
    end
    
    if max(max(teddy1m)) ~= 0
        [r,c] = find(p2 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
        
        im2 = imoverlay(im2,p2,teddy1/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'teddy bear','FontSize',28,'LineWidth',4);
    end
    
    if max(max(teddy2m)) ~= 0
        [r,c] = find(p3 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
        
        im2 = imoverlay(im2,p3,teddy2/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'teddy bear','FontSize',28,'LineWidth',4);
    end
    
    if max(max(teddy3m)) ~= 0
        [r,c] = find(p4 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
                
        im2 = imoverlay(im2,p4,teddy3/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'teddy bear','FontSize',28,'LineWidth',4);
    end
    
    if max(max(teddy4m)) ~= 0
        [r,c] = find(p5 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
                
        im2 = imoverlay(im2,p5,teddy4/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'teddy bear','FontSize',28,'LineWidth',4);
    end
    
    if max(max(elephant1m)) ~= 0
        [r,c] = find(st1 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
                
        im2 = imoverlay(im2,st1,elephant1/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'elephant','FontSize',28,'LineWidth',4);
    end
    
    if max(max(bench1m)) ~= 0
        [r,c] = find(scr1 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
                
        im2 = imoverlay(im2,scr1,bench/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'bench','FontSize',28,'LineWidth',4);
    end
    
    if max(max(cup1m)) ~= 0
        [r,c] = find(po1 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
                
        im2 = imoverlay(im2,po1,cup/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'cup','FontSize',28,'LineWidth',4);
    end
    
    if max(max(plant1m)) ~= 0
        [r,c] = find(h1 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
                
        im2 = imoverlay(im2,h1,plant/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'potted plant','FontSize',28,'LineWidth',4);
    end
    
    if max(max(racket1m)) ~= 0
        [r,c] = find(a1 == 1);
        
        minX = min(c);
        minY = min(r);
        maxX = max(c);
        maxY = max(r);
            
        ab = [minX,minY,maxX-minX,maxY-minY];
                
        im2 = imoverlay(im2,a1,racket/255);        
        im2 = insertObjectAnnotation(im2,'rectangle',ab,'tennis racket','FontSize',28,'LineWidth',4);
    end
    
    imshow(im2)
    
    imwrite(im2,[pn2 'results\' fn],'PNG');
end