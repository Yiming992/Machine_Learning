%load first test image
im = imread('segtest1.jpg');
image = imread('segtest1.jpg');
%Obtain seed points for foreground and background
imshow(im);
[x,y]=ginput(2);
x=floor(x);
y=floor(y);
im = double(im);
%initialize foreground and background with points at close vicinity of
%selected seed points
fore_R=sum(sum(im((y(1)-1):(y(1)+1),(x(1)-1):(x(1)+1),1)))/9;
fore_G=sum(sum(im((y(1)-1):(y(1)+1),(x(1)-1):(x(1)+1),2)))/9;
fore_B=sum(sum(im((y(1)-1):(y(1)+1),(x(1)-1):(x(1)+1),3)))/9;

foreground=[fore_R,fore_G,fore_B];


back_R=sum(sum(im((y(2)-1):(y(2)+1),(x(2)-1):(x(2)+1),1)))/9;
back_G=sum(sum(im((y(2)-1):(y(2)+1),(x(2)-1):(x(2)+1),2)))/9;
back_B=sum(sum(im((y(2)-1):(y(2)+1),(x(2)-1):(x(2)+1),3)))/9;

background=[back_R,back_G,back_B];



%compute difference between pixels and background or frontground color
[H,W,D] = size(im);
N = H*W;
Pixel = reshape(im,N,3);
Foreground_dis = sqrt(sum((Pixel - repmat(foreground,[N,1])).^2,2));
Background_dis = sqrt(sum((Pixel - repmat(background,[N,1])).^2,2));


lambda = 1e-3;
segclass = zeros(N,1);
pairwise = sparse(N,N);

% Define binary classification problem
labelcost = [0 1;1 0]*lambda;
unary = [Foreground_dis, Background_dis]';

%add all horizontal links
for i = 1:W-1
  for j= 1:H
    node  = 1 + (j-1) + (i-1)*H;
    right = 1 + (j-1) + i*H;
    distance = norm(Pixel(node,:)- Pixel(right,:));
    pairwise(node,right) = distance;
    pairwise(right,node) = distance;
  end
end

%add all vertical nbr links
for i = 1:W
  for j = 1:H-1
    node = 1 + (j-1) + (i-1)*H;
    down = 1 + j + (i-1)*H;
    distance = norm(Pixel(node,:)- Pixel(down,:));
    pairwise(node,down) = distance;
    pairwise(down,node) = distance;
  end
end

[labels,E,Eafter] = GCMex(segclass, single(unary), pairwise, single(labelcost),0);

subplot(211);
imagesc(image);
title('Original image');
hold on;
plot(x,y,'r*','LineWidth',2);
subplot(212);
imagesc(reshape(labels,[H W]));
title('Min-cut');
