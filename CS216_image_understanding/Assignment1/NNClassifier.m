function[prediction]=NNClassifier(train,test,K,Distance)
% Function to perform Knn classification
% input:
% train: a structure array containing training data and labels
% test: a structure array containing test data
% K: number of neighbors which will be considered in classification
% Distance: type of distance to use in the classification, can be 'Euclidean'
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