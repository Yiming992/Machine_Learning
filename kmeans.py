import numpy as np
def kmeans(A, k, epsilon):
  stop=False
  m=A.shape[1]
  n=A.shape[0]
  # randomly pick initial centroids
  idx=np.random.randint(n,size=k)
  centroids=A[idx]
  while not stop:
    cnetroids_dict={}
    for i in range(k):
      centroids_dict[i]=centroids[i]
    point_assign={key:[] for key in range(k)}
    assignment=[]
    # assign points to their respective centroids based on distance metric
    for i in range(n):
      distance=np.inf
      assign=0
      for key in centroids_dict.keys():
        centroid=centroids_dict[key]
        if np.linalg.norm(A[i]-centroid)<=distance:
          distance=np.linalg.norm(A[i]-centroid)
          assign=key
      assignment.append(assign)
      point_assign[assign].append(A[i])
    # find new centroids
    new_centroids=[]
    for i in range(k):
      center_arrays=np.asarray(point_assign[i])
      new_centroids.append(np.sum(center_arrays,axis=0)/center_arrays.shape[0])
    new_centroids=np.stack(new_centroids)
    #check stop condition i.e. frobenius norm between new centroids and old centroids
    compare=np.linalg.norm(new_centroids-centroids)
    if compare<epsilon:
      stop=True
      cluster_center=new_centroids
      assignment=np.asarray(assignment)
    else:# reaasign centroids and repeat above process should the stop condition not met
      centroids=new_centroids
  return cluster_center,assignment
