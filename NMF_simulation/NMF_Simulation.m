%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code reads a set of images (the dataset) and performes OPNMF on them, 
% extracting the features that the algorithm finds. It uses the code from
% Aristidis Sotiras (https://github.com/asotiras/brainparts/blob/master/opnmf.m)
% 
% 2021 Aidinis George 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
clc;

cwd = dir;


% Give the path to the opnmf.m file:
% opnmf_path = uigetdir();
% addpath(opnmf_path);

% Give the data folder:
data_dir = uigetdir();
cd(data_dir);

d = dir;
s = size(d);

X = [];
for i = 3:s(1)
	name = d(i,1).name;
	Img = imread(name);
	% one-hot the image and append it to the rest of the data (D = 480 000)
	Img_one_hot = reshape(Img, [400*400*3, 1]);
	X = [X, Img_one_hot];
end
% Perform OPNMF:
[W H] = opnmf(X,10);


cd(cwd(1,1).folder);