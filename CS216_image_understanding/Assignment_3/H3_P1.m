
% Kmean clustering with k=2
image=Kmeans('Bird.jpg',2);
figure;
imshow(image),title('K=2');



% Kmean clustering with k=5
image=Kmeans('Bird.jpg',5);
figure;
imshow(image),title('K=5');




% Kmean clustering with k=10
image=Kmeans('Bird.jpg',10);
figure;
imshow(image),title('K=10');

%
% Kmean clustering with k=2, on image with blue channel scaled by 1000
image=scaled_Kmeans('Bird.jpg',2);
figure;
imshow(image),title('scaled,K=2');



% Kmean clustering with k=5, on image with blue channel scaled by 1000
image=scaled_Kmeans('Bird.jpg',5);
figure;
imshow(image),title('scaled,K=5');




% Kmean clustering with k=10, on image with blue channel scaled by 1000
image=scaled_Kmeans('Bird.jpg',10);
figure;
imshow(image),title('scaled,K=10');

function[new_image]=Kmeans(image,K)
% function to perform Kmean clustering
% Input:
% image: a image matrix
% K: number of cluster
% output:
% new_image: new image in which individual pixel value is replaced with the
% cluster centers

I=im2double(imread(image));
[nrows,ncols,ncolors]=size(I);
data=reshape(I,nrows*ncols,3);
[index,centers]=kmeans(data,K);
results=reshape(index,nrows,ncols);
 
 new_image=zeros(nrows,ncols,ncolors);
 for i=1:nrows
     for j=1:ncols
         for k=1:K
             if results(i,j)==k
                 new_image(i,j,:)=centers(k,:);
             end
         end    
     end
 end

end





function[new_image]=scaled_Kmeans(image,K)
% Same function as previous one. Only differece is blue channel is scaled
% by 1000 before clustering
I=im2double(imread(image));
[nrows,ncols,ncolors]=size(I);
data=reshape(I,nrows*ncols,3);
data(:,3)=1000*data(:,3);
[index,centers]=kmeans(data,K);
results=reshape(index,nrows,ncols);
 
 new_image=zeros(nrows,ncols,ncolors);
 for i=1:nrows
     for j=1:ncols
         for k=1:K
             if results(i,j)==k
                 new_image(i,j,:)=centers(k,:);
             end
         end    
     end
 end
 new_image(:,:,3)=new_image(:,:,3)/1000;

end













