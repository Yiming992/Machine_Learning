
I=rgb2gray(imread('zebra1.jpg'));
I=imresize(I,[800,600]);


filtered_I=filterBanks(I);

figure;

imshow(filtered_I.filter_1),title('Horizontal,sigma=1');

figure;
imshow(filtered_I.filter_2),title('Horizontal,sigma=2');

figure;
imshow(filtered_I.filter_3),title('Horizontal,sigma=4');

figure;
imshow(filtered_I.filter_4),title('Vertical,sigma=1');


figure;
imshow(filtered_I.filter_5),title('Vertical,sigma=2');

figure;
imshow(filtered_I.filter_6),title('Vertical,sigma=4');


figure;

imshow(filtered_I.filter_7),title('Difference,G2-G1');


figure
imshow(filtered_I.filter_8),title('Difference,G4-G2');


function[filtered]=filterBanks(image)
% function to filter a given image with a filterbank which consists of
% eight filters on grayscale
% Input:
% image: a image matrix
% Output:
% filtered: a structure array consists of filtered images, in order of
% Horizontal filtering with guassian that has sigma=1,2 and 4, Vertical
% filtering with gaussian that has sigma=1,2 and 4, and filtering with
% filters constructed by differencing two gaussian filters

I=im2double(image);

filter1=fspecial('gaussian',[1 3],1);
filter2=fspecial('gaussian',[1 6],2);
filter3=fspecial('gaussian',[1 12],4);
filter4=fspecial('gaussian',[3,1],1);
filter5=fspecial('gaussian',[6,1],2);
filter6=fspecial('gaussian',[12,1],4);

% Horizontal filtering with different sigma
filtered1=imfilter(I,filter1);
filtered2=imfilter(I,filter2);
filtered3=imfilter(I,filter3);
% Vertical filtering
filtered4=imfilter(I,filter4);
filtered5=imfilter(I,filter5);
filtered6=imfilter(I,filter6);
% Difference filtering
filtered7=imfilter(I,fspecial('gaussian',[6 6],2))-imfilter(I,fspecial('gaussian',[3 3],1));
filtered8=imfilter(I,fspecial('gaussian',[12 12],4))-imfilter(I,fspecial('gaussian',[6 6],2));


filtered=struct('filter_1',filtered1,'filter_2',filtered2,'filter_3',filtered3,'filter_4',filtered4,'filter_5',filtered5,'filter_6',filtered6,'filter_7',filtered7,'filter_8',filtered8);
end