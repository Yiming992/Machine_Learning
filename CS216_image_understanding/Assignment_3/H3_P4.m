
I=rgb2gray(imread('zebra1.jpg'));% load image
I=imresize(I,[800,600]);
[nrows,ncols]=size(I);
filtered_I=filterBanks(I);
data=zeros(nrows*ncols,8);


data(:,1)=reshape(filtered_I.filter_1,nrows*ncols,1);
data(:,2)=reshape(filtered_I.filter_2,nrows*ncols,1);
data(:,3)=reshape(filtered_I.filter_3,nrows*ncols,1);
data(:,4)=reshape(filtered_I.filter_4,nrows*ncols,1);
data(:,5)=reshape(filtered_I.filter_5,nrows*ncols,1);
data(:,6)=reshape(filtered_I.filter_6,nrows*ncols,1);
data(:,7)=reshape(filtered_I.filter_7,nrows*ncols,1);
data(:,8)=reshape(filtered_I.filter_8,nrows*ncols,1);

K=20;


[index,centers]=kmeans(data,K,'MaxIter',1000);

results=reshape(index,nrows,ncols);

colormap jet
imagesc(results)