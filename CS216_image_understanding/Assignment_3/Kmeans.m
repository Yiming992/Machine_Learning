function[new_image]=Kmeans(image,K)

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
