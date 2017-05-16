

I=rgb2gray(imread('zebra_small.jpg'));
imshow(I)
%ginput
% single out the neck region, grass region and leaves region
Neck=I(51:80,76:105);
Grass=I(201:230,14:43);
Leaves=I(8:37,141:170);
filtered_I=filterBanks(I);


% Mean responses on neck region
Neck1=sum(sum(abs(filtered_I.filter_1(51:80,76:105))))/(30*30);
Neck2=sum(sum(abs(filtered_I.filter_2(51:80,76:105))))/(30*30);
Neck3=sum(sum(abs(filtered_I.filter_3(51:80,76:105))))/(30*30);
Neck4=sum(sum(abs(filtered_I.filter_4(51:80,76:105))))/(30*30);
Neck5=sum(sum(abs(filtered_I.filter_5(51:80,76:105))))/(30*30);
Neck6=sum(sum(abs(filtered_I.filter_6(51:80,76:105))))/(30*30);
Neck7=sum(sum(abs(filtered_I.filter_7(51:80,76:105))))/(30*30);
Neck8=sum(sum(abs(filtered_I.filter_8(51:80,76:105))))/(30*30);

%Mean responses on grass region
Grass1=sum(sum(abs(filtered_I.filter_1(201:230,14:43))))/(30*30);
Grass2=sum(sum(abs(filtered_I.filter_2(201:230,14:43))))/(30*30);
Grass3=sum(sum(abs(filtered_I.filter_3(201:230,14:43))))/(30*30);
Grass4=sum(sum(abs(filtered_I.filter_4(201:230,14:43))))/(30*30);
Grass5=sum(sum(abs(filtered_I.filter_5(201:230,14:43))))/(30*30);
Grass6=sum(sum(abs(filtered_I.filter_6(201:230,14:43))))/(30*30);
Grass7=sum(sum(abs(filtered_I.filter_7(201:230,14:43))))/(30*30);
Grass8=sum(sum(abs(filtered_I.filter_8(201:230,14:43))))/(30*30);

% Mean responses on leaves region
Leaves1=sum(sum(abs(filtered_I.filter_1(8:37,141:170))))/(30*30);
Leaves2=sum(sum(abs(filtered_I.filter_2(8:37,141:170))))/(30*30);
Leaves3=sum(sum(abs(filtered_I.filter_3(8:37,141:170))))/(30*30);
Leaves4=sum(sum(abs(filtered_I.filter_4(8:37,141:170))))/(30*30);
Leaves5=sum(sum(abs(filtered_I.filter_5(8:37,141:170))))/(30*30);
Leaves6=sum(sum(abs(filtered_I.filter_6(8:37,141:170))))/(30*30);
Leaves7=sum(sum(abs(filtered_I.filter_7(8:37,141:170))))/(30*30);
Leaves8=sum(sum(abs(filtered_I.filter_8(8:37,141:170))))/(30*30);


% Print out the all mean responses
Neck=[Neck1,Neck2,Neck3,Neck4,Neck5,Neck6,Neck7,Neck8]

Grass=[Grass1,Grass2,Grass3,Grass4,Grass5,Grass6,Grass7,Grass8]

Leaves=[Leaves1,Leaves2,Leaves3,Leaves4,Leaves5,Leaves6,Leaves7,Leaves8]



function[filtered]=filterBanks(image)

I=im2double(image);

filter1=fspecial('gaussian',[1 3],1);
filter2=fspecial('gaussian',[1 6],2);
filter3=fspecial('gaussian',[1 12],4);
filter4=fspecial('gaussian',[3,1],1);
filter5=fspecial('gaussian',[6,1],2);
filter6=fspecial('gaussian',[12,1],4);

filtered1=imfilter(I,filter1);
filtered2=imfilter(I,filter2);
filtered3=imfilter(I,filter3);
filtered4=imfilter(I,filter4);
filtered5=imfilter(I,filter5);
filtered6=imfilter(I,filter6);
filtered7=imfilter(I,fspecial('gaussian',[6 6],2))-imfilter(I,fspecial('gaussian',[3 3],1));
filtered8=imfilter(I,fspecial('gaussian',[12 12],4))-imfilter(I,fspecial('gaussian',[6 6],2));


filtered=struct('filter_1',filtered1,'filter_2',filtered2,'filter_3',filtered3,'filter_4',filtered4,'filter_5',filtered5,'filter_6',filtered6,'filter_7',filtered7,'filter_8',filtered8);
end








