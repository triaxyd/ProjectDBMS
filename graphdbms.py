import matplotlib.pyplot as plt

query1 = [51.707,55.761,48.536,19.385,13.126]
query2 = [0.089,0.099,0.082,0.105,0.138]
query3 = [2.022,1.266,1.300,0.887,0.540]
query4 = [3.891,3.254,3.171,2.340,2.011]
query51 =[2.614,2.039,1.258,0.081,0.210]
query52 =[1.804,0.984,0.693,0.349,0.216]

x_values = [1, 2, 3, 4, 5]

plt.plot(x_values, query1, label='Query 1')
plt.plot(x_values, query2, label='Query 2')
plt.plot(x_values, query3, label='Query 3')
plt.plot(x_values, query4, label='Query 4')
plt.plot(x_values, query51, label='Query 5.1')
plt.plot(x_values, query52, label='Query 5.2')

plt.xlabel('Question')
plt.ylabel('Execution Time')
plt.title('Execution Time Per Query')

plt.xticks(x_values)

plt.legend()
plt.show()