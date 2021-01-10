clc
clear all
close all

model = 'model2.h5';
lgraph = importKerasLayers(model,'ImportWeights',true);

% NOTE: MATLAB create placeholderLayers for the keras layers which are 
% unsupported. So, if you get placeholderLayers in your lgraph then you 
% need to manually replace those placeholder layers with your custom layers 
% before assembling the network. The procedure to create and replace custom 
% layers is given at: https://www.mathworks.com/help/deeplearning/ref/importkeraslayers.html

net = assembleNetwork(lgraph);
save('model2','net');