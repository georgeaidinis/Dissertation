%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code reads a set of images (the dataset) and performes OPNMF on them, 
% extracting the features that the algorithm finds. It uses the code from
% Aristidis Sotiras (https://github.com/asotiras/brainparts)
% 
% 
% 2021 Aidinis George 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
for i = 5:s(1)-1
	name = d(i,1).name;
	img = imread(name);
	gray_img = rgb2gray( img );
	Img = im2double(gray_img);
	% one-hot the image and append it to the rest of the data (D = 151 875)
	Img_one_hot = reshape(Img, [100*100, 1]);
	X = [X, Img_one_hot];
end
cd(cwd(1,1).folder);



% Perform OPNMF:
mkdir NMF_2_component;
cd NMF_2_component;
[W H] = opnmf_mem(X,2);
for i = 1:2
	w = reshape(W(:,i), [100,100]);
	w = rescale(w,0,255);
	imwrite(w, strcat('NMF_2_component_',string(i),'.jpeg'), 'JPEG');
end
cd ..;


mkdir NMF_4_component;
cd NMF_4_component;
[W H] = opnmf_mem(X,4);
for i = 1:4
	w = reshape(W(:,i), [100,100]);
	w = rescale(w,0,255);
	imwrite(w, strcat('NMF_4_component_',string(i),'.jpeg'), 'JPEG');
end
cd ..;


mkdir NMF_6_component;
cd NMF_6_component;
[W H] = opnmf_mem(X,6);
for i = 1:6
	w = reshape(W(:,i), [100,100]);
	w = rescale(w,0,255);
	imwrite(w, strcat('NMF_6_component_',string(i),'.jpeg'), 'JPEG');
end
cd ..;


mkdir NMF_8_component;
cd NMF_8_component;
[W H] = opnmf_mem(X,8);
for i = 1:8
	w = reshape(W(:,i), [100,100]);
	w = rescale(w,0,255);
	imwrite(w, strcat('NMF_8_component_',string(i),'.jpeg'), 'JPEG');
end
cd ..;


mkdir NMF_10_component;
cd NMF_10_component;
[W H] = opnmf_mem(X,10);
for i = 1:10
	w = reshape(W(:,i), [100,100]);
	w = rescale(w,0,255);
	imwrite(w, strcat('NMF_10_component_',string(i),'.jpeg'), 'JPEG');
end
cd ..;






