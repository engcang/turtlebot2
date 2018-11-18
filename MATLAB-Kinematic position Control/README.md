# Controlling the real robot
+ Controlling the real robot via ROS into wanted position using kinematic error modeling's input velocities


### referred to robot's modelling of paper : 
+ A Stable Target-Tracking Control for Unicycle Mobile Robots, Sung-On Lee, Young-Jo Cho, Myung Hwang-Bo, Bum-Jae You, Sang-Rok Oh, Proceedings of the 2000 IEEE/RSJ International Conference on Intelligent Robots and Systems 
  + Modelling uses velocity input which is proved stable by Lyapunov stability


### Nessecary :
+ [< Robotics System Toolbox >](https://kr.mathworks.com/help/robotics/classeslist.html)
+ [< Support Package for Turtlebot-Based Robots >](https://kr.mathworks.com/help/supportpkg/turtlebotrobot/index.html)

## Code breaking down
+ ROS connection :
~~~
    rosinit('192.168.0.10'); % type your robot's IP
    tbot = turtlebot;
    resetOdometry(tbot); % Reset robot's Odometry
    
    robot = rospublisher('/mobile_base/commands/velocity');
    velmsg = rosmessage(robot);
    
    odom = rossubscriber('/odom');
~~~
</br>
This block initialize ROS connection and make nodes subscribes and publishes the messages under topics
<p align="center">
<img src="https://github.com/engcang/image-files/blob/master/turtlebot2/rqt1.JPG" width="700"/>
</p>

~~~
%% System Parameters
K1=2;
K2=2; %gain


xt=1;
yt=1; %xt= target.x, yt = target.y
rho=sqrt((xt-Ax)^2+(yt-Ay)^2);
~~~
