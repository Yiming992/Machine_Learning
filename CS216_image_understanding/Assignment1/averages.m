

srcFiles2 = dir('C:\Users\caesarliu\Desktop\avg\set2\*.jpg');

srcFiles1 = dir('C:\Users\caesarliu\Desktop\avg\set1\*.jpg');

% For set1
gray_array=cell(1,57);
for i = 1 : length(srcFiles1)
  filename = strcat('C:\Users\caesarliu\Desktop\avg\set1\',srcFiles1(i).name);
  I =rgb2gray(imread(filename));
  I=imresize(I,[300,215]);
  I=im2double(I);
  gray_array{i}=I;
end







% average image in grayscale
ave1=average(gray_array,'gray');
figure
subplot(1,3,1)
imshow(ave1)




Color_array=cell(1,57);
for i = 1 : length(srcFiles1)
  filename = strcat('C:\Users\caesarliu\Desktop\avg\set1\',srcFiles1(i).name);
  I = imread(filename);
  I=imresize(I,[300,215]);
  I=im2double(I);
  Color_array{i}=I;
end
% average image in RGB
ave2=average(Color_array,'RGB');
subplot(1,3,2)
imshow(ave2)


%Randomly flip set1
Color_flip=random_flip(Color_array)
% average image after the flip operations
ave3=average(Color_flip,'RGB');
subplot(1,3,3)
imshow(ave3)




% For set2
gray_array2=cell(1,100);
for i = 1 : length(srcFiles2)
  filename = strcat('C:\Users\caesarliu\Desktop\avg\set2\',srcFiles2(i).name);
  I =rgb2gray(imread(filename));
  I=imresize(I,[300,215]);
  I=im2double(I);
  gray_array2{i}=I;
end

% average image in grayscale
ave4=average(gray_array2,'gray');
figure
subplot(1,3,1)
imshow(ave4)






Color_array2=cell(1,100);
for i = 1 : length(srcFiles2)
  filename = strcat('C:\Users\caesarliu\Desktop\avg\set2\',srcFiles2(i).name);
  I = imread(filename);
  I=imresize(I,[300,215]);
  I=im2double(I);
  Color_array2{i}=I;
end

% average image in RGB
ave5=average(Color_array2,'RGB');
subplot(1,3,2)
imshow(ave5)


%Randomly flip set2
Color_flip2=random_flip(Color_array2)
% average image after the flip operations
ave6=average(Color_flip2,'RGB');
subplot(1,3,3)
imshow(ave6)


% average function used in above computation
function[average_im]=average(I,c)
% Funtion to produce an averaged version of multiple images
% input:
% I: a cell array with dimension 1*N, N is the number of images
% c: a string indicating whether the image is colored or not, can be either
% 'RGB' or 'gray'
% output:
% a matrix containing the pixel values 
%
[M,N] =size(I);
if strcmp(c,'gray')
    [m,n]=size(I{1});
    average_im=zeros(m,n);
    for j=1:N
        average_im=average_im+I{j};
    end
    average_im=average_im/N;
else
    [m,n,o]=size(I{1}(:,:,:));
    average_im=zeros(m,n,o);
    for i =1:3
        for j=1:N
            average_im(:,:,i)=average_im(:,:,i)+I{j}(:,:,i);
        end
        average_im(:,:,i)=average_im(:,:,i)/N;
    end
end
end

function[image_array]=random_flip(I)
% Function to randomly horizontally flip a collection of images
% input:
% I: a cell array with dimension 1*N, N is the number of images
% output:
% a cell array after the flip operations
[M,N]=size(I);
image_array=I;
for i=1:N
    ran=binornd(1,0.5);
    if ran==1
        image_array{i}=flip(I{i},2);
    else
        image_array{i}=I{i};
    end
end
end
