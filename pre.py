'''
Author: jiazhuoGou goujz@qq.com
Date: 2023-03-03 16:32:35
LastEditors: jiazhuoGou goujz@qq.com
LastEditTime: 2023-03-03 21:06:29
FilePath: \clustring\pre.py
Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
'''
import matplotlib.pyplot as plt
import numpy as np
from sklearn.cluster import KMeans
from sklearn.datasets import make_blobs
from sklearn.metrics import pairwise_distances


# 计算相似度矩阵，这里使用公式(8)
def w(x, y, sigma=2.50):
    return np.exp(-1.0 * (x - y).T @ (x - y) /(2 * sigma**2)) # 高斯径向基核函数


# 生成4个点，这4个点的位置关系是一个正方形的4个顶点,模拟基站
x = [1, 1, 5, 5]
y = [1, 5, 5, 1]

# 绘制散点图，将4个点用红色标记
plt.scatter(x, y, color='red')

# 定义一个空列表，用于存储每个基准点周围的点与基准点之间的欧式距离
distances = []
matrix = []
temp = []
vec = []

'''
# 在每个基准点为圆心随机生成5个点，用蓝色标记
for i in range(4):
    # 生成5个随机点，这5个点都在以(x[i], y[i])为圆心、半径为1的圆内
    random_x = np.random.uniform(x[i]-1, x[i]+1, size=3)
    random_y = np.random.uniform(y[i]-1, y[i]+1, size=3)
    # 绘制这3个随机点
    # plt.scatter(random_x, random_y)
    # 把随机生成的点存储起来
    for j in range(3):
        temp.append(random_x[j])
        temp.append(random_y[j])
        vec.append(temp)
        #print(vec)
        temp = []
    #matrix.append(distances)
'''

'''
随机生成30个点

x1 = np.random.uniform(0, 6, size=30)
y1 = np.random.uniform(0, 6, size=30)
for i in range(30):
    temp.append(x1[i])
    temp.append(y1[i])
    vec.append(temp)
    #print(vec)
    temp = []
'''


#计算每个点到红绿灯距离
for i in range(len(vec)):
    for j in range(4):
        #print(vec[i][0],vec[i][1])
        distance = np.sqrt((vec[i][0] - x[j]) ** 2 + (vec[i][1] - y[j]) ** 2)
        distances.append(distance)

# 将distances列表转换为一个4x5的矩阵
distances_matrix = np.array(distances).reshape(30, 4)


print('--------------------------------')
# 调库

W = pairwise_distances(distances_matrix, metric=w)
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
k = 4
Q = eig_vec_sorted[:, :k] 
# 对新构成的Q矩阵进行聚类
k = 4
km = KMeans(n_clusters=k)
Q_abs = np.abs(Q)
# 对Q_abs的行向量聚类，并计算出每个样本所属的类
y_pred = km.fit_predict(Q_abs)

# 根据预测的标签画出所有的样本
#print(vec)
centers = [[-2, -8], [-1, 7], [6, 5], [9, 8], [0, 2.3]]
X, labels = make_blobs(n_samples=5, n_features=2, 
                    centers=centers, 
                    cluster_std=[0.2, 0.4, 0.6, 0.3, 0.3])

#print(vec)
arr = np.array(vec) # 
plt.scatter(arr[:,0], arr[:,1], c=y_pred)


# 添加坐标轴标签和标题
plt.xlabel('x')
plt.ylabel('y')
plt.title('Four Points')

plt.show()



# 生成包含3个样本和3个特征的数据集，中心点随机生成，特征范围在1-10之间
# matrix, y = make_blobs(n_samples=3, n_features=3, centers=None, 
                #center_box=(1, 10), shuffle=True,)
#print(matrix)
#W = pairwise_distances(matrix, metric=w)
