# Fall-Detection-iOS

An application that uses the sensors on an iPhone to determine if the end-user falls.

## Algorithm

It uses the 3-axes of acceleartion and gyroscope to monitor the user's movement and determine if there is a fall. The current process is to take the aggregate of the acceleration vector and compare it against a threshold value. This current process does have defficiences since it will only work for specific users and only measures one metric to determine a fall. The next step for this project is to use a smartwatch to get more accurate measurments of the user's body movements.

## Screenshots
<p float="left">
<img src="https://github.com/AbelWeldaregay/Fall-Detection-iOS/blob/master/Screen%20Shot%202020-03-01%20at%2012.13.38%20AM.png?raw=true" width=250 height= 400>
  &nbsp
<img src="https://github.com/AbelWeldaregay/Fall-Detection-iOS/blob/master/Screen%20Shot%202020-03-01%20at%2012.14.00%20AM.png?raw=true" width=250 height= 400>
 &nbsp
<img src= "https://github.com/AbelWeldaregay/Fall-Detection-iOS/blob/master/Screen%20Shot%202020-03-01%20at%2012.14.27%20AM.png?raw=true" width=250 height=400>
</p>
<p float="left">
<img src="https://github.com/AbelWeldaregay/Fall-Detection-iOS/blob/master/Screen%20Shot%202020-03-01%20at%2012.15.20%20AM.png?raw=true" width=250 height=400>
   &nbsp
 <img src="https://github.com/AbelWeldaregay/Fall-Detection-iOS/blob/master/Screen%20Shot%202020-03-01%20at%2012.16.51%20AM.png?raw=true" width=250 height=400>
  &nbsp
 <img src="https://github.com/AbelWeldaregay/Fall-Detection-iOS/blob/master/Screen%20Shot%202020-03-01%20at%2012.17.42%20AM.png?raw=true" width=250 height=400>
</p>


## Getting Started

### Prerequisites
- [Xcode](https://developer.apple.com/xcode/)
- Swift 4
- MacOS is preferred to run this project since iOS development is MacOS exclusive

### Installing
- Open the terminal on Mac or Bash on Windows
- CD to the desired directory
- Give the following commands to initialize a git repository and clone the project
```
git init .
git clone https://github.com/AbelWeldaregay/Fall-Detection-iOS
```
After cloning the project onto your local system, give the following commands to install the pods

```
pod install

```
### Running

  This project can be run directly from Xcode by opening the project in Xcode and clicking run.
 

