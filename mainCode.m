clear all 
close all
clc
origine_table=[0.125,0.025,0.09];
cube_dimensions = [0.06,0.06,0.06];
width_offset=0.02;
length_offset=0.03;
end_test=0;
vrep=remApi('remoteApi');
vrep.simxFinish(-1);
clientID = vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
%connector=vrep.simxGetObjectHandle(clientID,'ROBOTIQ_85_attachPoint', vrep.simx_opmode_blocking);
if(clientID> -1)
    
    disp('connected to remote API server');
    [res,j1] = vrep.simxGetObjectHandle(clientID,'ROBOTIQ_85_active1',vrep.simx_opmode_blocking);
    [res,j2] = vrep.simxGetObjectHandle(clientID,'ROBOTIQ_85_active2',vrep.simx_opmode_blocking);
    [res,R5_target] = vrep.simxGetObjectHandle(clientID,'target',vrep.simx_opmode_blocking);
    [res,Proximity_sensor] = vrep.simxGetObjectHandle(clientID,'Proximity_sensor',vrep.simx_opmode_blocking);
    
    %target positions needed
    fposition1 = [0.05,0.125,0.25,0,0,0]; %x y z alpha, betha , gamma
    fposition2 = [0,0.275,0.4,0,0,0];
    fposition3 = [0.025,0.3,0.15,0,0,0]; %above pickup position
    fposition4 = [0.025,0.35,0.1,0,0,0]; %pickup positin
     fposition5 = [0.15,0.1,0.175,0,0,0]; %above place position
      fposition6 =[0.15,0.1,0.1,0,0,0]; %place position
      
      gripper (clientID,0,j1,j2); pause(1.5); %open gripper
      moveL (clientID, R5_target,fposition3,2);
    
     while (end_test ==0)
           %shape=vrep.simxGetObjects(clientID,vrep.sim_object_shape_type,vrep.simx_opmode_blocking);
            [res, PSensor_distance,detectedPoint] = vrep.simxReadProximitySensor(clientID,Proximity_sensor,vrep.simx_opmode_blocking);
           if (PSensor_distance>0)
           moveL (clientID, R5_target,fposition4,2);
          % attachedShape=shape;
          %vrep.simxSetObjectParent(attachedShape,clientID,connector,true,vrep.simx_opmode_blocking);
           gripper (clientID,1,j1,j2); pause(3);%close gripper and pickup cube
           
           moveL (clientID, R5_target,fposition3,2);
           moveL (clientID, R5_target,fposition5,2);
           moveL (clientID, R5_target,fposition6,2);
          % vrep.simxSetObjectParent(attachedShape,clientID,-1,true,vrep.simx_opmode_blocking)
           gripper (clientID,0,j1,j2); pause(3);%open gripper
           moveL (clientID, R5_target,fposition5,2);
           moveL (clientID, R5_target,fposition3,2);
           %refresh the place position
           [end_test,fposition6, fposition5,fposition3]=pick_and_place(origine_table,4,4,3,cube_dimensions,width_offset,length_offset,fposition6, fposition5,fposition3);
           end
       
    end
           
           vrep.delete();
           disp('program ended');
           
 end
      
    