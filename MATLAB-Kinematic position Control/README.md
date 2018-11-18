# Controlling the real robot
+ Controlling the real robot via ROS into wanted position using kinematic error modeling's input velocities

### referred to robot's modelling of paper : 
+ A Stable Target-Tracking Control for Unicycle Mobile Robots, Sung-On Lee, Young-Jo Cho, Myung Hwang-Bo, Bum-Jae You, Sang-Rok Oh, Proceedings of the 2000 IEEE/RSJ International Conference on Intelligent Robots and Systems 
  + Modelling uses velocity input which is proved stable by Lyapunov stability


## Code breaking down
    rosinit('192.168.0.10'); % type your robot's IP
    tbot = turtlebot;
    resetOdometry(tbot); % Reset robot's Odometry
    
    robot = rospublisher('/mobile_base/commands/velocity');
    velmsg = rosmessage(robot);
    
    odom = rossubscriber('/odom');
> rosinit('IP')
