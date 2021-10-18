import matplotlib.pyplot as plt

#plt.plot([1,4,9,16])
#plt.title("plot of y value")
#plt.show()
#plt.plot([0,1,2,3,4],[0,1,4,9,16])
#plt.plot([0,1,2,3,4],[0,1,4,9,16], 'ro') # red o : round
#plt.plot([0,1,2,3,4],[0,2,3,4,5], 'bs') # blue s : square
#plt.plot([0,1,2,3,4],[0,3,5,11,5], 'b') # blue line

# color : r g b c m y k w
# line  : default:- -- _ :
# marker: . , o v ^ < > 1 2 3 4 s p * h H + x D d l
#plt.title("plot of x and y value")
#plt.show()

#plt.axis([0,6,0,20])
# x axis = [0 ~ 6]
# y axis = [0~20],
#plt.xlabel("x label")
#plt.ylabel("y label")

"""
##### subplot ######
plt.subplot(2,2,1)
plt.title("2x2 1")
plt.plot([1,2,3,4])

plt.subplot(2,2,2)
plt.title("2x2 2")
plt.plot([4,1,2,3])

plt.subplot(2,2,3)
plt.title("2x2 3")
plt.plot([1,3,2,1])

plt.subplot(2,2,4)
plt.title("2x2 4")
plt.plot([3,2,3,4])

plt.show()
"""
#### gca() , plt.axes()
plt.plot(1,1)
#ax=plt.gca()
ax = plt.axes()
ax.set_facecolor('violet')
plt.show()
