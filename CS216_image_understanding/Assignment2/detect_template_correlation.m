

image=imread('dilbert1.jpg');
image=im2double(image);
%ginput% obtain corrdinates to extract templates

% compute an averaged template
template=(image(141:158,35:52)+image(161:178,380:397)+image(177:194,668:685))/3;
% flip the template
template=fliplr(template);

colormap gray
imagesc(template)% display the template
% Using correlation to detect objects which align with our chosen
% template
correlation=conv2(image,template,'same');
figure;
colormap gray
imagesc(correlation)% plot the cross-correlation

% thresholding the correlation
threshold=215;



L = correlation(2:end-1,2:end-1) > correlation(2:end-1,1:end-2); % bigger than our neighbor to the left?
R = correlation(2:end-1,2:end-1) > correlation(2:end-1,3:end); % bigger than our neighbor to the right?
UL= correlation(2:end-1,2:end-1) > correlation(1:end-2,1:end-2);% bigger than our neighbor to the upper-left?
UR= correlation(2:end-1,2:end-1) > correlation(1:end-2,3:end);% bigger than our neighbor to the upper-right?
U=  correlation(2:end-1,2:end-1) > correlation(1:end-2,2:end-1);% bigger than our neighbor above?
BL= correlation(2:end-1,2:end-1) > correlation(3:end,1:end-2);% bigger than our neighbor to the bottom-left?
BR= correlation(2:end-1,2:end-1) > correlation(3:end,3:end);% bigger than our neighbor to the bottom-right?
B=  correlation(2:end-1,2:end-1) > correlation(3:end,2:end-1);% bigger than our neighbor below?
T = correlation(2:end-1,2:end-1) > threshold; %above detection threshold?
maxima = R & L & T & UL & UR & U & BR & BL & B;


figure;
imshow(image);
hold on;
%plot the rectangle upon the original image based on above thresholding
[k,l] = size(template);
[m,n] = size(maxima);
for i = 1:m
   for j = 1:n
      if maxima(i,j) == 1 
          rectangle('Position',[j+1,i+1,k/5,l/5],'LineWidth',1,'EdgeColor','r');
      end
   end
end

