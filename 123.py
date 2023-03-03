import matplotlib.pyplot as plt
import numpy as np
from sklearn.cluster import KMeans, SpectralClustering
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

for i in range(4):
    # 生成5个随机点，这5个点都在以(x[i], y[i])为圆心、半径为1的圆内
    random_x = np.random.uniform(x[i]-1, x[i]+1, size=8)
    random_y = np.random.uniform(y[i]-1, y[i]+1, size=8)
    # 绘制这3个随机点
    # plt.scatter(random_x, random_y)
    # 把随机生成的点存储起来
    for j in range(8):
        temp.append(random_x[j])
        temp.append(random_y[j])
        vec.append(temp)
        #print(vec)
        temp = []

print(len(vec)) # 节点

#计算每个点到红绿灯距离
for i in range(len(vec)):
    for j in range(4):
        #print(vec[i][0],vec[i][1])
        distance = np.sqrt((vec[i][0] - x[j]) ** 2 + (vec[i][1] - y[j]) ** 2)
        distances.append(distance)

# 将distances列表转换为一个4x5的矩阵
distances_matrix = np.array(distances).reshape(32, 4)

# 调库 可以不指定，实际情况应该是多试几次，把最佳数量确定下来
sc = SpectralClustering(n_clusters=4)
X = np.array(vec)
y_pred = sc.fit_predict(X) # 聚类并完成分类，完事

plt.scatter(X[:,0], X[:,1], c=y_pred) #画图

plt.show()