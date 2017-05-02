

% Magnitude spectrum for signal with single pulse with height
% 1 at middle
single=(1:100)*0;
single(50)=1;
y=fftshift(fft(single));
mag=abs(y);
freq=(-49:50);
figure;
subplot(2,3,1)
plot(freq,mag);
xlabel('Frequency')
ylabel('Magnitude')
title('Magnitude');


% box-function signal with signal width 5, and
% height 1
box=(1:100)*0;
box(48:52)=1;
y=fftshift(fft(box));
mag=abs(y);
subplot(2,3,2);
plot(freq,mag);
xlabel('Frequency')
ylabel('Magnitude')
title('Magnitude');




%% box-function signal with signal width 10, and
% height 1

box2=(1:100)*0;
box2(45:54)=1;
y=fftshift(fft(box2));
mag=abs(y);
subplot(2,3,3)
plot(freq,mag);
xlabel('Frequency')
ylabel('Magnitude')
title('Magnitude');

%Guassian signal with sigma 1
time=-1:1/100:1;
gauss1=normpdf(time,0,1);
y1=fftshift(fft2(gauss1));
mag1=abs(y1);
f1 =(-length(y1)/2:length(y1)/2-1)*100/length(y1); 
subplot(2,3,4)
plot(f1,mag1);
xlabel('Frequency');
ylabel('Magnitude');
title('Magnitude');


%Guassian signal with sigma 2
time=-1:1/100:1;
gauss2=normpdf(time,0,2);
y2=fftshift(fft(gauss2));
mag2=abs(y2);
f2 =(-length(y2)/2:length(y2)/2-1)*100/length(y2); 
subplot(2,3,5)
plot(f2,mag2);
xlabel('Frequency');
ylabel('Magnitude');
title('Magnitude');


% 2D DFT on zebra1.jpg 

% display the original image
zebra1=imread('zebra1.jpg');
zebra1=imresize(zebra1,[640,360]);% resize the image
zebra1=im2double(zebra1);
figure;
imshow(zebra1)
DF1=fftshift(fft2(zebra1));
phase1=angle(DF1);
mag1=abs(DF1);

% 2D DFT on zebra2.jpg 
% display the original image
zebra2=imread('zebra2.jpg');
zebra2=imresize(zebra2,[640,360]);% resize the image
zebra2=im2double(zebra2);
figure;
imshow(zebra2)
DF2=fftshift(fft2(zebra2));
phase2=angle(DF2);
mag2=abs(DF2);

%Swap the magnitude of zebra1 and zebra2 to produce two new images
newImage1 = mag2.* exp(phase1 .*1i);
newImage1 = ifft2(newImage1);
imwrite(newImage1,'zebra3.jpg','JPEG');
figure;
imshow(newImage1)


newImage2 = mag1.* exp(phase2 .*1i);
newImage2 = ifft2(newImage2);
imwrite(newImage2,'zebra4.jpg','JPEG');
figure;
imshow(newImage2)


% Explore the DFT on Beta pdf function
time=0:1/100:10;
beta=betapdf(time,4,4);
y=fftshift(fft(beta));
mag=abs(y);
f =(-length(y)/2:length(y)/2-1)*100/length(y); 
figure;
subplot(1,2,1)
plot(f,mag);
xlabel('Frequency');
ylabel('Magnitude');
title('Magnitude');


time=0:1/100:10;
beta=betapdf(time,5,1);
y=fftshift(fft(beta));
mag=abs(y);
f =(-length(y)/2:length(y)/2-1)*100/length(y); 
subplot(1,2,2)
plot(f,mag);
xlabel('Frequency');
ylabel('Magnitude');
title('Magnitude');







