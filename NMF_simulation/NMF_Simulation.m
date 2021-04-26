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
for i = 3:s(1)
	name = d(i,1).name;
	img = imread(name);
	Img = im2double(img);
	% one-hot the image and append it to the rest of the data (D = 151 875)
	Img_one_hot = reshape(Img, [225*225*3, 1]);
	X = [X, Img_one_hot];
end
cd(cwd(1,1).folder);



% Perform OPNMF:
mkdir NMF_1_component;
cd NMF_1_component;
[W H] = opnmf_mem(X,1);
w = reshape(W, [225,225,3]);
w = rescale(w,0,255);
imwrite(w, 'NMF_1_component.jpeg', 'JPEG');
cd ..;

mkdir NMF_2_component;
cd NMF_2_component;
[W H] = opnmf_mem(X,2);
for i = 1:2
	w = reshape(W(:,i), [225,225,3]);
	w = rescale(w,0,255);
	imwrite(w, strcat('NMF_2_component_',string(i),'.jpeg'), 'JPEG');
end
cd ..;


mkdir NMF_3_component;
cd NMF_3_component;
[W H] = opnmf_mem(X,3);
for i = 1:3
	w = reshape(W(:,i), [225,225,3]);
	w = rescale(w,0,255);
	imwrite(w, strcat('NMF_3_component_',string(i),'.jpeg'), 'JPEG');
end
cd ..;

mkdir NMF_4_component;
cd NMF_4_component;
[W H] = opnmf_mem(X,4);
for i = 1:4
	w = reshape(W(:,i), [225,225,3]);
	w = rescale(w,0,255);
	imwrite(w, strcat('NMF_4_component_',string(i),'.jpeg'), 'JPEG');
end
cd ..;

mkdir NMF_5_component;
cd NMF_5_component;
[W H] = opnmf_mem(X,5);
for i = 1:5
	w = reshape(W(:,i), [225,225,3]);
	w = rescale(w,0,255);
	imwrite(w, strcat('NMF_5_component_',string(i),'.jpeg'), 'JPEG');
end
cd ..;

mkdir NMF_7_component;
cd NMF_7_component;
[W H] = opnmf_mem(X,7);
for i = 1:7
	w = reshape(W(:,i), [225,225,3]);
	w = rescale(w,0,255);
	imwrite(w, strcat('NMF_7_component_',string(i),'.jpeg'), 'JPEG');
end
cd ..;

mkdir NMF_10_component;
cd NMF_10_component;
[W H] = opnmf_mem(X,10);
for i = 1:10
	w = reshape(W(:,i), [225,225,3]);
	w = rescale(w,0,255);
	imwrite(w, strcat('NMF_10_component_',string(i),'.jpeg'), 'JPEG');
end
cd ..;


mkdir NMF_15_component;
cd NMF_15_component;
[W H] = opnmf_mem(X,15);
for i = 1:15
	w = reshape(W(:,i), [225,225,3]);
	w = rescale(w,0,255);
	imwrite(w, strcat('NMF_15_component_',string(i),'.jpeg'), 'JPEG');
end
cd ..;


mkdir NMF_20_component;
cd NMF_20_component;
[W H] = opnmf_mem(X,20);
for i = 1:20
	w = reshape(W(:,i), [225,225,3]);
	w = rescale(w,0,255);
	imwrite(w, strcat('NMF_20_component_',string(i),'.jpeg'), 'JPEG');
end
cd ..;


