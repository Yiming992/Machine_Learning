

G=edge('simpsons.jpg',1);% sigma=1 case
figure;
subplot(2,2,1)
colormap jet
imagesc(G.Horizontal);% Show horizontal gradient
subplot(2,2,2)
colormap jet
imagesc(G.Vertical);% Show vertical gradient
subplot(2,2,3)
colormap jet
imagesc(G.Magnitude);% Show magnitude of gradient
subplot(2,2,4)
colormap jet
imagesc(G.Angle);% Show orientation of gradient


G=edge('simpsons.jpg',0.2);% sigma=0.2 case
figure;
subplot(2,2,1)
colormap jet
imagesc(G.Horizontal);% Show horizontal gradient
subplot(2,2,2)
colormap jet
imagesc(G.Vertical);% Show vertical gradient
subplot(2,2,3)
colormap jet
imagesc(G.Magnitude);% Show magnitude of gradient
subplot(2,2,4)
colormap jet
imagesc(G.Angle);% Show orientation of gradient



function[Gradient]=edge(image,sigma)
% Function to compute the gradient of an gray scale image
% Input:
% image: an image file
% sigma: parameter used in the gaussian filter
% output:
% Gradient: a structure array containing Horizontal gradient, Vertical
% gradient, Magnitude of gradient and Orientation of gradient

original=imread(image);
original=rgb2gray(original);
original=im2double(original);

[m,n]=size(original);
Smoothed=imgaussfilt(original,sigma);

% Using a Sobel filter
X_filter=[-1 0 1; -2 0 2;-1 0 1];
Y_filter=[1 2 1; 0 0 0; -1 -2 -1];

H_der=conv2(Smoothed,X_filter,'same');
V_der=conv2(Smoothed,Y_filter,'same');

magnitude=zeros(m,n);
angle=zeros(m,n);

for i= 1:m
    for j=1:n
        magnitude(i,j)=sqrt(H_der(i,j)^2+V_der(i,j)^2);
        angle(i,j)=atan(H_der(i,j)/V_der(i,j));
    end
end
Gradient=struct('Horizontal',H_der,'Vertical',V_der,'Magnitude',magnitude,'Angle',angle);
end
