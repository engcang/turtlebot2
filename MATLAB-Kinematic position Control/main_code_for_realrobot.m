    rosshutdown
    clc
    clear 
    close all
    
    rosinit('192.168.0.10');
    tbot = turtlebot;
    tbot.OdometryReset.TopicName = '/reset';
    
%     robot = rospublisher('/mobile_base/commands/velocity');
    robot = rospublisher('/cmd_vel');
    velmsg = rosmessage(robot);
    resetOdometry(tbot);
    
    odom = rossubscriber('/odom');
    odomdata = receive(odom,3);
    pose = odomdata.Pose.Pose;
    Ax = pose.Position.X;
    Ay = pose.Position.Y;
    quat = pose.Orientation;
    angles = quat2eul([quat.W quat.X quat.Y quat.Z]);
    Api = angles(1);
    
%% System Parameters
K1=2;
K2=2;


xt=Ax+1;
yt=Ay; %xt = Ax + target.x, yt = Ay + target.y will be better
rho=sqrt((xt-Ax)^2+(yt-Ay)^2);

while 1
if rho >=0.02
rho=sqrt((xt-Ax)^2+(yt-Ay)^2);
psi=atan2(yt-Ay,xt-Ax);
theta=Api;
phi=theta-psi;

            if phi > pi
                phi = phi - 2*pi;
            end
            if phi < -pi
                phi = phi + 2*pi;
            end

disp([theta*180/pi psi*180/pi phi*180/pi]);

    velmsg.Linear.X = K1*rho*cos(phi);
    velmsg.Angular.Z = -K1*sin(phi)*cos(phi)-K2*phi;

        if velmsg.Linear.X >= 0.2 
            velmsg.Linear.X=0.2;
        end
        if velmsg.Linear.X <= -0.2
            velmsg.Linear.X=-0.2;
        end
        if velmsg.Angular.Z >= 2.8
            velmsg.Linear.Z=2.8;
        end
        if velmsg.Angular.Z <= -2.8
            velmsg.Angular.Z=-2.8;
        end
    send(robot,velmsg);
    
    odomdata = receive(odom,3);
    pose = odomdata.Pose.Pose;
    Ax = pose.Position.X;
    Ay = pose.Position.Y;
    quat = pose.Orientation;
    angles = quat2eul([quat.W quat.X quat.Y quat.Z]);
    Api = angles(1);
else
    velmsg.Linear.X=0;
    velmsg.Angular.Z=0;
    send(robot,velmsg);
    break;
end
end
