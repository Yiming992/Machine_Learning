% pick positive and negative patches from one image
NPos = 5; % number of positive examples
NNeg = 100; % number of negative example

% load a training example image
Itrain = im2double(rgb2gray(imread('test1.jpg')));
figure(1); clf;
imshow(Itrain);

% pick positive patches
positivePatch = cell(NPos,1);
negativePatch = cell(NNeg,1);
height = zeros(NPos+NNeg,1);
width = zeros(NPos+NNeg,1);
boxes=zeros(4,NPos);

for i = 1:NPos+NNeg
    disp(i);
    rect = getrect(figure(1));
    x = floor(rect(1));
    y = floor(rect(2));
    width(i) = floor(rect(3));
    height(i) = floor(rect(4));
    patch = Itrain(y:y+height(i),x:x+width(i));
    if i <= NPos
        positivePatch{i} = patch;
        boxes(:,i)=[x,y,width(i),height(i)];
    else
        negativePatch{i - NPos} = patch;
    end
    
end

% Compute appropraite width and height for image patches
[Rwidth,Rheight]=average_boxes(boxes);
templateHeight=Rheight/8;
templateWidth=Rwidth/8;
% resize positive patches
RPosPatch = zeros(Rheight,Rwidth,NPos);
for i = 1:NPos
    RPosPatch(:,:,i) = imresize(positivePatch{i},[Rheight,Rwidth]);
end

% resize negative patches
RNegPatch = zeros(Rheight,Rwidth,NNeg);
for i = 1:NNeg
    RNegPatch(:,:,i) = imresize(negativePatch{i},[Rheight,Rwidth]);
end  

% Build template
PositiveTemplate = zeros(templateHeight,templateWidth,9,NPos);
NegativeTemplate = zeros(templateHeight,templateWidth,9,NNeg);
PositiveTemplate_sum = zeros(templateHeight,templateWidth,9);
NegativeTemplate_sum = zeros(templateHeight,templateWidth,9);
for i = 1:NPos
    PositiveTemplate(:,:,:,i) = hog(RPosPatch(:,:,i));
    PositiveTemplate_sum = PositiveTemplate_sum + PositiveTemplate(:,:,:,i);
end
for i = 1:NNeg
    NegativeTemplate(:,:,:,i) = hog(RNegPatch(:,:,i));
    NegativeTemplate_sum = NegativeTemplate_sum + NegativeTemplate(:,:,:,i);
end


template = PositiveTemplate_sum/NPos - NegativeTemplate_sum/NNeg;
if NNeg==0
    template = PositiveTemplate_sum/NPos;
end
    


% load a test image
%
Itest= im2double(rgb2gray(imread('test3.jpg')));


% find top 5 detections in Itest
ndet = 5;
[x,y,score] = detect(Itest,template,ndet);

%display top ndet detections
figure(3); clf; imshow(Itest);
for i = 1:ndet
  % draw a rectangle.  use color to encode confidence of detection
  %  top scoring are green, fading to red
  hold on; 
  h = rectangle('Position',[x(i)-Rwidth/2 y(i)-Rheight/2 Rwidth Rheight],'EdgeColor',[(i/ndet) ((ndet-i)/ndet)  0],'LineWidth',3,'Curvature',[0.3 0.3]); 
  hold off;
end