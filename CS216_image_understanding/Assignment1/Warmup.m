
% Read in the image
Image=rgb2gray(imread('C:\Users\caesarliu\Desktop\figures\Ringed.jpg'));
Image=imresize(Image,[100,100]);
A=im2double(Image);
figure
imshow(A);



% Sort intensity in A
intensity=Sort(A);

% Plot the sorted intensity
figure
subplot(1,2,1)
plot([1:10000],intensity)
ylabel('Color Intensity Value')
title('Problem 2a')



% Histogram of the sorted inetnsity
nbins=35;
subplot(1,2,2)
hist(intensity,nbins)
xlabel('Color Intensity Value')
title('Problem 2b')



%Display a image, which is white wherever the intensity in A is greater
%than the mean intensity of A, black otherwise
meanA=mean(intensity);
B=[];
for i = 1:100
   for j=1:100;
        if A(j,i)>meanA
            B(j,i)=1;
        else
            B(j,i)=0;
        end
    end
end
figure
subplot(1,2,1)
imshow(B)
title('Problem 2c')



%Display the bottom right quadrant
RQ= A(51:100,51:100);
subplot(1,2,2)
imshow(RQ)
colorbar
title('Problem 2d')

% Display a image same size as A, but with A's mean intensity value
% subtracted from each pixel, and negative values are set to 0
C=[];
for i=1:100
    for j=1:100
        if (A(j,i)-meanA)>0
            C(j,i)=A(j,i)-meanA;
        else
            C(j,i)=0;
        end
    end
end
figure
subplot(1,2,1)
imshow(C)
title('Problem 2e')



% Flip the image
flipA=flip(A,2);
subplot(1,2,2)
imshow(flipA)
colorbar
title('Problem 2f')

% Find the single minimum value in matrix A, and its corresponding row and
% column
x=min(min(A));
[M,I]=min(A(:));
[r,c]=ind2sub(size(A),I);


%Compute the number of unique values in vector V
V=[1 8 8 2 1 3 9 8];
length(unique(V))


function[intensity]= Sort(A)
  [m,n]= size(A);
  intensity=[1:m*n]*0;
  l=1;
  for i=1:n
      intensity(l:(l+m-1))=A(:,i);
      l=l+m;
  end
  intensity=sort(intensity);
end
  

  
  

