
function [x,y,score] = detect(I,template,ndet)
%
% return top ndet detections found by applying template to the given image.
%   x,y should contain the coordinates of the detections in the image
%   score should contain the scores of the detections
%


% compute the feature map for the image
f = hog(I);

nori = size(f,3);

% cross-correlate template with feature map to get a total response
R = zeros(size(f,1),size(f,2));
for i = 1:nori
  R = R +conv2(f(:,:,i),fliplr(template(:,:,i)),'same');
end

% now return locations of the top ndet detections

% sort response from high to low
[val,ind] = sort(R(:),'descend');
x = zeros(ndet,1);
y = zeros(ndet,1);
score=zeros(ndet,1);
% this is the non-maximum suppression loop.
% work down the sorted list of responses, 
% only add a detection if it doesn't overlap previously selected detections
i = 1;
detcount = 1;
while ((detcount <= ndet) && (i <= length(ind)))
  % convert ind(i) back to (i,j) values to get coordinates of the block
  if mod(ind(i),size(f,1))==0
      yblock=size(f,1);
  else
      yblock = mod(ind(i),size(f,1));
  end
  xblock= ceil(ind(i)/size(f,1));

  assert(val(i)==R(yblock,xblock)); %make sure we did the indexing correctly

  % now convert yblock,xblock to pixel coordinates 
  ypixel = 8*yblock;
  xpixel = 8*xblock;

  % check if this detection overlaps any detections which we've already added to the list
  % (e.g. check to see if the distance between this detection and the other detections
  %   collected in the arrays x,y is less than half the template width/height)
  overlap =0;
  if min(abs(y-ypixel))<=(size(template,1)*4)& min(abs(x-xpixel))<=(size(template,2)*4)
      overlap = 1;
  end
  % if no overlap, then add this detection location and score to the list we return
  if (~overlap)
    x(detcount) = xpixel;
    y(detcount) = ypixel;
    score(detcount) =val(i);
    detcount = detcount+1;
  end
  i = i + 1;
end
end


