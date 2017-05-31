function[x,y,score,Layer]= multi_scale(image,template,ndet,scale)
% Function to perform multi_scale detection
I=image;
done=0;
[t_height,t_width]=size(template);
m=8*t_height;
n=8*t_width;
level=1;

X=zeros(ndet,1);
Y=zeros(ndet,1);
score=zeros(ndet,1);
layer=zeros(ndet,1);
while (~done)  
  [xp,yp,score(:,level)] =detect(I,template,ndet);
  X(:,level)=floor(xp./(scale^(level-1)));
  Y(:,level)=floor(yp./(scale^(level-1)));
  layer(:,level)=zeros(ndet,1)+level;
  done=size(I,1)*scale<m & size(I,2)*scale<n;
  I=imresize(I,scale);
  level=level+1;
end
  % combine results
 [val,ind]=sort(score(:),'descend');
  X=X(:);
  Y=Y(:);
  layer=layer(:);
  x=zeros(ndet,1);
  y=zeros(ndet,1);
  Layer=zeros(ndet,1);
i = 1;
detcount = 1;
while detcount<=ndet && i<=ndet*level
  % check if this detection overlaps any detections which we've already added to the list
  % (e.g. check to see if the distance between this detection and the other detections
  %   collected in the arrays x,y is less than half the template width/height)
  overlap =0;
  if min(abs(y-Y(ind(i))))<=(size(template,1)*4)&& min(abs(x-X(ind(i))))<=(size(template,2)*4)
      overlap = 1;
  end
  % if no overlap, then add this detection location and score to the list we return
  if (~overlap)
    x(detcount)= X(ind(i));
    y(detcount)= Y(ind(i));
    score(detcount)=val(i);
    Layer(detcount)=layer(ind(i));
    detcount = detcount+1;
  end
  i = i + 1;
end

end