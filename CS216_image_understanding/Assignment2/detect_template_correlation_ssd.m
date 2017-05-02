

image=imread('dilbert1.jpg');
image=im2double(image);
%ginput% obtain corrdinates to extract templates

% compute an averaged template
template=(image(141:158,35:52)+image(161:178,380:397)+image(177:194,668:685))/3;
% flip the template
template=fliplr(template);

colormap gray
imagesc(template)% display the template
% Using squared-difference to detect objects which align with our template
correlation = conv2(image,template,'same');
Tsquared = sum(sum(correlation.^2));
Isquared = conv2(image.^2,ones(size(template)),'same');
squareddiff = (Isquared - 2*correlation + Tsquared);
figure;
colormap gray
imagesc(-squareddiff)


L = squareddiff(2:end-1,2:end-1) < squareddiff(2:end-1,1:end-2); % bigger than our neighbor to the left?
R = squareddiff(2:end-1,2:end-1) < squareddiff(2:end-1,3:end); % bigger than our neighbor to the right?
UL= squareddiff(2:end-1,2:end-1) < squareddiff(1:end-2,1:end-2);% bigger than our neighbor to the upper-left?
UR= squareddiff(2:end-1,2:end-1) < squareddiff(1:end-2,3:end);% bigger than our neighbor to the upper-right?
U=  squareddiff(2:end-1,2:end-1) < squareddiff(1:end-2,2:end-1);% bigger than our neighbor above?
BL= squareddiff(2:end-1,2:end-1) < squareddiff(3:end,1:end-2);% bigger than our neighbor to the bottom-left?
BR= squareddiff(2:end-1,2:end-1) < squareddiff(3:end,3:end);% bigger than our neighbor to the bottom-right?
B=  squareddiff(2:end-1,2:end-1) < squareddiff(3:end,2:end-1);% bigger than our neighbor below?
T = correlation(2:end-1,2:end-1) < 0.206e+3; %above detection threshold?
maxima = R & L & UL & UR & U & BR & BL & B & T;


figure;
imshow(image);
hold on;
%plot the rectangle on the original image based on above thresholding
[k,l] = size(template);
[m,n] = size(maxima);
for i = 1:m
   for j = 1:n
      if maxima(i,j) == 1 
          rectangle('Position',[j+1,i+1,k/5,l/5],'LineWidth',1,'EdgeColor','r');
      end
   end
end




