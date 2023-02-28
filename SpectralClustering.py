import os

import matplotlib
import matplotlib.pyplot as plt
import numpy as np
from sklearn.cluster import KMeans, SpectralClustering
from sklearn.datasets import make_blobs
from sklearn.metrics import pairwise_distances

# 生成样本数据
# centers=[[1, 0, 0, 2, 1], [0, 2, 0, 1, 0], [2, 8, 0, 1, 8], [10, 2, 3, 8, 2], [9, 1, 2, 3, 0]]
centers = [[-2, -8], [-1, 7], [6, 5], [9, 8], [0, 2.3]]
X, labels = make_blobs(n_samples=300, n_features=2, centers=centers, cluster_std=[0.2, 0.4, 0.6, 0.3, 0.3])

# 计算相似度矩阵，这里使用公式(8)
def w(x, y, sigma=2.50):
    return np.exp(-1.0 * (x - y).T @ (x - y) /(2 * sigma**2)) # 高斯径向基核函数

# 按照高斯径向基核函数计算样本之间的距离
W = pairwise_distances(X, metric=w)

# 计算度矩阵
D = np.diag(W.sum(axis=1))

# 计算拉普拉斯矩阵
L = D - W
# 拉普拉斯矩阵规范化，不计算也行
L_norm = np.sqrt(np.linalg.inv(D)) @ L @ np.sqrt(np.linalg.inv(D))

# 特征分解，np.linalg.eig()默认按照特征值升序排序了。
eigenvals, eigvector = np.linalg.eig(L_norm)

# 如果没有升序排序，可以这样做
# 将特征值按照升序排列
ind = np.argsort(eigenvals)
eig_vec_sorted = eigvector[:,ind] #对应的特征向量也要相应调整顺序

# 取出前k个最小的特征值对应的特征向量，注意这里的k和要聚类的簇数一样
k = 5
Q = eig_vec_sorted[:, :k] 

# 对新构成的Q矩阵进行聚类
k = len(centers)
km = KMeans(n_clusters=k)
Q_abs = np.abs(Q)  

# 对Q_abs的行向量聚类，并计算出每个样本所属的类
y_pred = km.fit_predict(Q_abs)

# 根据预测的标签画出所有的样本
plt.scatter(X[:,0], X[:,1], c=y_pred)

x = np.arange(0, 5, 0.1)
y = np.sin(x)
plt.plot(x, y)
matplotlib.pyplot.show()