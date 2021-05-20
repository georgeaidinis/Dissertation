%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code reads a set of images (the dataset) and performes OPNMF on them, 
% extracting the features that the algorithm finds. It uses the code from
% Aristidis Sotiras (https://github.com/asotiras/brainparts)
% Requires image processing toolbox.
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
d=d(~ismember({d.name},{'.','..','.DS_Store'}));
s = size(d);

X = [];
for i = 1:s(1)
	name = d(i,1).name;
	img = imread(name);
	gray_img = rgb2gray( img );
	Img = im2double(gray_img);
	% one-hot the image and append it to the rest of the data (D = 151 875)
	Img_one_hot = reshape(Img, [100*100, 1]);
	X = [X, Img_one_hot];
end
cd(cwd(1,1).folder);

norms = [0 0 0 0 0];

% Perform OPNMF:
mkdir NMF_2_component;
cd NMF_2_component;
[W H] = opnmf_mem(X,2);
norms(1) = norm(X - W*H,'fro');
h = H.';
sum_of_distances = [];
for j = 2:2:10
	[idx, t, sumd] = kmeans(h, j);
	sum_of_distances = [sum_of_distances sum(sumd)];
	correct = 0;
	text = "Sample name, Source, Atrophy Level, Category Assigned" + newline;

	for i = 1:1000
		full_name = d(i,1).name;
		if contains(full_name, 'A')
			source = "A";
			if idx(i) == 1
				correct = correct + 1;
			end
		end
		if contains(full_name, 'B')
			source = "B";
			if idx(i) == 2
				correct = correct + 1;
			end
		end
		if contains(full_name, "_R1_")
			atrophy = "R1";
		end
		if contains(full_name, "_R1R2_")
			atrophy = "R1R2";
		end
		if contains(full_name, "_R1R2R3_")
			atrophy = "R1R2R3";
		end

		text = text + full_name + "," + source + "," + atrophy + "," + string(idx(i)) + newline;
	end

	fid = fopen(strcat('Results for 2-component, ',string(j),'-means Clustering.csv'),'w');
	fprintf(fid, text);
	fclose(fid);
end
figure('visible','off'); 
plot([2 4 6 8 10], sum_of_distances, 'LineWidth', 2, 'Marker', 'o');
title('Total Distance Error');
xlabel('k');
ylabel('Error');
saveas(gcf, 'Kmeans_Distance_Error.jpeg');
clear gcf;
for i = 1:2
	w = reshape(W(:,i), [100,100]);
	w = rescale(w, 0, 255);
	figure('visible','off'); 
	imagesc(w); 
	colorbar; 
	saveas(gcf, strcat('NMF_2_component_',string(i),'.jpeg'));
	clear gcf;
end
cd ..;


mkdir NMF_4_component;
cd NMF_4_component;
[W H] = opnmf_mem(X,4);
norms(2) = norm(X - W*H,'fro');
h = H.';
sum_of_distances = [];
for j = 2:2:10
	[idx, t, sumd] = kmeans(h, j);
	sum_of_distances = [sum_of_distances sum(sumd)];

	text = "Sample name, Source, Atrophy Level, Category Assigned" + newline;
	for i = 1:1000
		full_name = d(i,1).name;
		if contains(full_name, 'A')
			source = "A";
		end
		if contains(full_name, 'B')
			source = "B";
		end
		if contains(full_name, "_R1_")
			atrophy = "R1";
		end
		if contains(full_name, "_R1R2_")
			atrophy = "R1R2";
		end
		if contains(full_name, "_R1R2R3_")
			atrophy = "R1R2R3";
		end

		text = text + full_name + "," + source + "," + atrophy + "," + string(idx(i)) + newline;
	end

	fid = fopen(strcat('Results for 4-component, ',string(j),'-means Clustering.csv'),'w');
	fprintf(fid, text);
	fclose(fid);
end
figure('visible','off'); 
plot([2 4 6 8 10], sum_of_distances, 'LineWidth', 2, 'Marker', 'o');
title('Total Distance Error');
xlabel('k');
ylabel('Error');
saveas(gcf, 'Kmeans_Distance_Error.jpeg');
for i = 1:4
	w = reshape(W(:,i), [100,100]);
	w = rescale(w, 0, 255);
	figure('visible','off'); 
	imagesc(w); 
	colorbar; 
	saveas(gcf, strcat('NMF_4_component_',string(i),'.jpeg'));
	clear gcf;
end
cd ..;


mkdir NMF_6_component;
cd NMF_6_component;
[W H] = opnmf_mem(X,6);
norms(3) = norm(X - W*H,'fro');
h = H.';
sum_of_distances = [];
for j = 2:2:10
	[idx, t, sumd] = kmeans(h, j);
	sum_of_distances = [sum_of_distances sum(sumd)];

	text = "Sample name, Source, Atrophy Level, Category Assigned" + newline;
	for i = 1:1000
		full_name = d(i,1).name;
		if contains(full_name, 'A')
			source = "A";
		end
		if contains(full_name, 'B')
			source = "B";
		end
		if contains(full_name, "_R1_")
			atrophy = "R1";
		end
		if contains(full_name, "_R1R2_")
			atrophy = "R1R2";
		end
		if contains(full_name, "_R1R2R3_")
			atrophy = "R1R2R3";
		end

		text = text + full_name + "," + source + "," + atrophy + "," + string(idx(i)) + newline;
	end

	fid = fopen(strcat('Results for 6-component, ',string(j),'-means Clustering.csv'),'w');
	fprintf(fid, text);
	fclose(fid);
end
figure('visible','off'); 
plot([2 4 6 8 10], sum_of_distances, 'LineWidth', 2, 'Marker', 'o');
title('Total Distance Error');
xlabel('k');
ylabel('Error');
saveas(gcf, 'Kmeans_Distance_Error.jpeg');
for i = 1:6
	w = reshape(W(:,i), [100,100]);
	w = rescale(w, 0, 255);
	figure('visible','off'); 
	imagesc(w); 
	colorbar; 
	saveas(gcf, strcat('NMF_6_component_',string(i),'.jpeg'));
	clear gcf;
end
cd ..;


mkdir NMF_8_component;
cd NMF_8_component;
[W H] = opnmf_mem(X,8);
norms(4) = norm(X - W*H,'fro');
h = H.';
sum_of_distances = [];
for j = 2:2:10
	[idx, t, sumd] = kmeans(h, j);
	sum_of_distances = [sum_of_distances sum(sumd)];

	text = "Sample name, Source, Atrophy Level, Category Assigned" + newline;
	for i = 1:1000
		full_name = d(i,1).name;
		if contains(full_name, 'A')
			source = "A";
		end
		if contains(full_name, 'B')
			source = "B";
		end
		if contains(full_name, "_R1_")
			atrophy = "R1";
		end
		if contains(full_name, "_R1R2_")
			atrophy = "R1R2";
		end
		if contains(full_name, "_R1R2R3_")
			atrophy = "R1R2R3";
		end

		text = text + full_name + "," + source + "," + atrophy + "," + string(idx(i)) + newline;
	end

	fid = fopen(strcat('Results for 8-component, ',string(j),'-means Clustering.csv'),'w');
	fprintf(fid, text);
	fclose(fid);
end
figure('visible','off'); 
plot([2 4 6 8 10], sum_of_distances, 'LineWidth', 2, 'Marker', 'o');
title('Total Distance Error');
xlabel('k');
ylabel('Error');
saveas(gcf, 'Kmeans_Distance_Error.jpeg');
for i = 1:8
	w = reshape(W(:,i), [100,100]);
	w = rescale(w, 0, 255);
	figure('visible','off'); 
	imagesc(w); 
	colorbar; 
	saveas(gcf, strcat('NMF_8_component_',string(i),'.jpeg'));
	clear gcf;
end
cd ..;


mkdir NMF_10_component;
cd NMF_10_component;
[W H] = opnmf_mem(X,10);
norms(5) = norm(X - W*H,'fro');
h = H.';
sum_of_distances = [];
for j = 2:2:10
	[idx, t, sumd] = kmeans(h, j);
	sum_of_distances = [sum_of_distances sum(sumd)];

	text = "Sample name, Source, Atrophy Level, Category Assigned" + newline;
	for i = 1:1000
		full_name = d(i,1).name;
		if contains(full_name, 'A')
			source = "A";
		end
		if contains(full_name, 'B')
			source = "B";
		end
		if contains(full_name, "_R1_")
			atrophy = "R1";
		end
		if contains(full_name, "_R1R2_")
			atrophy = "R1R2";
		end
		if contains(full_name, "_R1R2R3_")
			atrophy = "R1R2R3";
		end

		text = text + full_name + "," + source + "," + atrophy + "," + string(idx(i)) + newline;
	end

	fid = fopen(strcat('Results for 10-component, ',string(j),'-means Clustering.csv'),'w');
	fprintf(fid, text);
	fclose(fid);
end
figure('visible','off'); 
plot([2 4 6 8 10], sum_of_distances, 'LineWidth', 2, 'Marker', 'o');
title('Total Distance Error');
xlabel('k');
ylabel('Error');
saveas(gcf, 'Kmeans_Distance_Error.jpeg');
for i = 1:10
	w = reshape(W(:,i), [100,100]);
	w = rescale(w, 0, 255);
	figure('visible','off'); 
	imagesc(w); 
	colorbar; 
	saveas(gcf, strcat('NMF_10_component_',string(i),'.jpeg'));
	clear gcf;
end
cd ..;

figure('visible','off'); 
scatter([2 4 6 8 10], norms, 200, 'filled');
title('OPNMF Reconstruction Error');
xlabel('Number of Components');
ylabel('Error');
saveas(gcf, 'OPNMF_Reconstruction_Error.jpeg');
clear gcf;





