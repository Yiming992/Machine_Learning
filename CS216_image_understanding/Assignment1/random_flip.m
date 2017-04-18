function[image_array]=random_flip(I)
% Function to randomly horizontally flip a collection of images
% input:
% I: a cell array with dimension 1*N, N is the number of images
% output:
% a cell array after the flip operations
[M,N]=size(I);
image_array=I;
for i=1:N
    ran=binornd(1,0.5);
    if ran==1
        image_array{i}=flip(I{i},2);
    else
        image_array{i}=I{i};
    end
end
end