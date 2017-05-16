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