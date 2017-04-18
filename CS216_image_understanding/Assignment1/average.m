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