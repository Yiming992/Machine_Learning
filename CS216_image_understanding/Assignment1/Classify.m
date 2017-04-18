

% Load Training data and convert data to double type
train1=load('data_batch_1.mat');
train1.data=im2double(train1.data);
train2=load('data_batch_2.mat');
train2.data=im2double(train2.data);
train3=load('data_batch_3.mat');
train3.data=im2double(train3.data);
train4=load('data_batch_4.mat');
train4.data=im2double(train4.data);
train5=load('data_batch_5.mat');
train5.data=im2double(train5.data);

% Training set with all training data
traindata=[train1.data;train2.data;train3.data;train4.data;train5.data];
traindata=im2double(traindata);
trainlabel=[train1.labels;train2.labels;train3.labels;train4.labels;train5.labels];
Train=struct('data',traindata,'labels',trainlabel);

% Load Test data 
test=load('test_batch.mat');
test.data=im2double(test.data);
%display the first plane in test data
plane_index=find(test.labels==0);
plane=test.data(plane_index(1),:);
plane=reshape(plane,32,32,3);
plane=imresize(plane,[100,100]);%resize for better view
figure
imshow(plane)


% Run NN classifier with Euclidean distance
P1=NNClassifier(Train,test,1,'Euclidiean');

correction1=(P1==test.labels');
rate1=sum(correction1)/10000;%Classification correction rate
rate1;


% Run Knn classifier with K=3, using Euclidean distance
P2=NNClassifier(Train,test,3,'Euclidiean');

correction2=(P2==test.labels');
rate2=sum(correction2)/10000;%Classification correction rate
rate2;


% Run Knn classifier with K=5, using Euclidean distance
P3=NNClassifier(Train,test,5,'Euclidiean');

correction3=(P3==test.labels');
rate3=sum(correction3)/10000;%Classification correction rate
rate3;


% Run nn classifier with Cosine distance
P4=NNClassifier(Train,test,1,'Cosine');

correction4=(P4==test.labels');
rate4=sum(correction4)/10000;%Classification correction rate
rate4;


% Run Knn classifier with K=3, using Cosine distance
P5=NNClassifier(Train,test,3,'Cosine');

correction5=(P5==test.labels');
rate5=sum(correction5)/10000;%Classification correction rate
rate5;


% Run Knn classifier with K=5, using Cosine distance
P6=NNClassifier(Train,test,5,'Cosine');

correction6=(P6==test.labels');
rate6=sum(correction6)/10000;%Classification correction rate
rate6;



% Confusion matrix for k=1, Euclidean distance
confusion1=zeros(10,10);
for i=0:9
    index=find(test.labels==i);
    pred=P1(index);
    for j=0:9
         confusion1(i+1,j+1)=sum(pred==j)/length(pred);
    end
end
 
figure;
colormap bone
imagesc(confusion1);
colorbar;
title('k=1,confusion matrix, Euclidean');
ave_rate1=(sum(sum(confusion1))-trace(confusion1))/90;%average misclassification rate
ave_diag=trace(confusion1)/10;%average of diagonal values




% Confusion matrix for k=5, Euclidean distance
confusion2=zeros(10,10);
for i=0:9
    index=find(test.labels==i);
    pred=P3(index);
    for j=0:9
         confusion2(i+1,j+1)=sum(pred==j)/length(pred);
    end
end
 
figure;
colormap bone
imagesc(confusion2);
colorbar;
title('k=5,confusion matrix, Euclidean');
ave_rate2=(sum(sum(confusion2))-trace(confusion2))/90;%average misclassification rate


% Confusion matrix for k=5, Cosine distance
confusion3=zeros(10,10);
for i=0:9
    index=find(test.labels==i);
    pred=P6(index);
    for j=0:9
         confusion3(i+1,j+1)=sum(pred==j)/length(pred);
    end
end
 
figure;
colormap bone
imagesc(confusion3);
colorbar;
title('k=5,confusion matrix, Cosine');
ave_rate3=(sum(sum(confusion3))-trace(confusion3))/90;%average misclassification rate

% Extract misclassified images
ind=find(test.labels==1);
pr=P6(ind);
ind2=find(pr==8);
in2=ind2([4,32,113,200]);
miss=ind(in2);
miss_image=test.data(miss,:);
miss_image1=imresize(reshape(miss_image(1,:),32,32,3),[100,100]);
miss_image2=imresize(reshape(miss_image(2,:),32,32,3),[100,100]);
miss_image3=imresize(reshape(miss_image(3,:),32,32,3),[100,100]);
miss_image4=imresize(reshape(miss_image(4,:),32,32,3),[100,100]);
subplot(2,2,1)
imshow(miss_image1)
subplot(2,2,2)
imshow(miss_image2)
subplot(2,2,3)
imshow(miss_image3)
subplot(2,2,4)
imshow(miss_image4)




function[prediction]=NNClassifier(train,test,K,Distance)
% Function to perform Knn classification
% input:
% train: a structure array containing training data and labels
% test: a structure array containing test data
% K: number of neighbors which will be considered in classification
% Distance: type distance to use in the classification, can be 'Euclidean'
% or 'Cosine'
% output:
% an array containing predicted labels for the test data
[M,~]=size(test.data);
prediction= [1:M]*0;
if strcmp(Distance,'Euclidiean')
    distance=pdist2(train.data,test.data);
    for i =1:M
        [~,L]=sort(distance(:,i));
         n=train.labels(L(1:K));
        [prediction(i),F]=mode(n);
        if K~=1
            n=n(n~=mode(n));
            [~,F2]=mode(n);
            if F2==F % if there is tie, use the label of the nearest neighbor
               prediction(i)=train.labels(L(1));
            end
        end
    end
elseif strcmp(Distance, 'Cosine')
    norm1=sqrt(sum(train.data.*train.data,2));
    for i=1:M
        dot=train.data*transpose(test.data(i,:));
        norm2=sqrt(sum(test.data(i,:).*test.data(i,:)));
        distance=dot./(norm1*norm2);
        [~,L]=sort(distance,'descend');
        n=train.labels(L(1:K));
        [prediction(i),F]= mode(n);
        if K~=1
            n=n(n~=mode(n));
            [~,F2]=mode(n);
            if F2==F % if there is tie, use the label of the nearest neighbor
               prediction(i)=train.labels(L(1));
            end
        end  
    end
end    
end

