# Fall-Detection-iOS

An application that uses the sensors on an iPhone to determine if the end-user falls.

## Algorithm

It uses the 3-axes of acceleartion and gyroscope to monitor the user's movement and determine if there is a fall. The current process is to take the aggregate of the acceleration vector and compare it against a threshold value. 
