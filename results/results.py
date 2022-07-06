import matplotlib.pyplot as plt
import csv
  
x = []
y = []
  
with open('ARCHIVO','r') as csvfile:
    plots = csv.reader(csvfile, delimiter = ',')
      
    for row in plots:
        x.append(row[0])
        #y.append(row[1])
        y.append(1*int(row[9]) + 2*int(row[8]) + 4*int(row[7]) + 8*int(row[6]) + 16*int(row[5]) + 32*int(row[4]) + 64*int(row[3]) + 128*int(row[2]))
  
plt.plot(x, y, color='red', linestyle='dashed', linewidth=2, markersize=12, label="LEYENDA")
plt.xlabel('Time')
plt.ylabel('Value')
plt.title('TITULO')
plt.show()
