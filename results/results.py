import matplotlib.pyplot as plt
import csv
  
x = []
y = []
  
with open('ARCHIVO','r') as csvfile:
    plots = csv.reader(csvfile, delimiter = ',')
      
    for row in plots:
        x.append(row[0])
        y.append(1*int(row[13]) + 2*int(row[12]) + 4*int(row[11]) + 8*int(row[10]) + 16*int(row[9]) + 32*int(row[8]) + 64*int(row[7]) + 128*int(row[6]) + 256*int(row[5]) + 512*int(row[4]) + 1024*int(row[3]) + 2048*int(row[2]))
  
plt.plot(x, y, color='red', linestyle='dashed', linewidth=2, markersize=12, label="LEYENDA")
plt.xlabel('Time')
plt.ylabel('Value')
plt.title('TITULO')
plt.show()
