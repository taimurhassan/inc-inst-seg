clc
clear all
close all

pn = 'C:\inc-inst-seg\testingDataset\test_images\';

imagefiles = dir([pn '*.png']);

nfiles = length(imagefiles);    

for ii=1:1:nfiles

    fn = imagefiles(ii).name;
    img=imread([pn fn]);
    
%     if ismatrix(img) == false
%         img = img(:,:,2);
%     end
    
%     if(size(img,3) ~= 3)
%         img = cat(3,img,img,img);
%     end

    img = imresize(img,[240 320],'bilinear');
    fn = replace(fn,'.png','');
    imwrite(img,[pn 'resized\' fn '.png'],'PNG');

end