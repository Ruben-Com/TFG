import matplotlib.pyplot as plt
import csv
  
x = []
y = []
  
with open('./T0008ALL.CSV','r') as csvfile:
    plots = csv.reader(csvfile, delimiter = ',')
      
    for row in plots:
        x.append(row[0])
        y.append(1*int(row[12]) + 2*int(row[11]) + 4*int(row[10]) + 8*int(row[9]) + 16*int(row[8]) + 32*int(row[7]) + 64*int(row[6]) + 128*int(row[5]) + 256*int(row[4]) + 512*int(row[3]) + 1024*int(row[2]) + 2048*int(row[1]))
  
plt.plot(y, color='red', linestyle='dashed', linewidth=2, markersize=12, label="LEYENDA")
plt.xlabel('Muestras')
plt.ylabel('Valores')
plt.title('Triangular vel. 3')
plt.show()
