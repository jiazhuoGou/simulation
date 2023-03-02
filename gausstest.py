'''
Author: jiazhuoGou goujz@qq.com
Date: 2023-03-01 16:38:39
LastEditors: jiazhuoGou goujz@qq.com
LastEditTime: 2023-03-02 16:43:26
FilePath: \clustring\gausstest.py
Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
'''


import numpy as np

# 生成两个随机矩阵
matrix1 = np.random.rand(3, 3)
matrix2 = np.random.rand(3, 3)
print(matrix1)
print('--------------------------------\n')
print(matrix2)

# 计算欧氏距离
euclidean_distance = np.linalg.norm(matrix1 - matrix2)

# 计算曼哈顿距离
manhattan_distance = np.sum(np.abs(matrix1 - matrix2))

# 计算余弦相似度
cosine_similarity = np.dot(matrix1.flatten(), matrix2.flatten()) / (np.linalg.norm(matrix1) * np.linalg.norm(matrix2))

# 打印结果
print("欧氏距离：", euclidean_distance)
print("曼哈顿距离：", manhattan_distance)
print("余弦相似度：", cosine_similarity)







