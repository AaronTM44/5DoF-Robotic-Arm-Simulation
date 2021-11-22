 function gripper (clientID,closing,j1,j2)
vrep = remApi('remoteApi');
p1 = vrep.simxGetJointPosition(clientID,j1, vrep.simx_opmode_blocking);
p2 = vrep.simxGetJointPosition(clientID,j2,vrep.simx_opmode_blocking);
 
if (closing==1)
  if (p1 <(p2-0.008))
      vrep.simxSetJointTargetVelocity (clientID,j1,-1,vrep.simx_opmode_blocking);
      vrep.simxSetJointTargetVelocity (clientID,j2,-4,vrep.simx_opmode_blocking);
  else
      vrep.simxSetJointTargetVelocity (clientID,j1,-2,vrep.simx_opmode_blocking);
      vrep.simxSetJointTargetVelocity (clientID,j2,-2,vrep.simx_opmode_blocking);
  end
else
    if (p1<p2)
         vrep.simxSetJointTargetVelocity (clientID,j1,4,vrep.simx_opmode_blocking);
         vrep.simxSetJointTargetVelocity (clientID,j2,2,vrep.simx_opmode_blocking);
    else
         vrep.simxSetJointTargetVelocity (clientID,j1,2,vrep.simx_opmode_blocking);
         vrep.simxSetJointTargetVelocity (clientID,j2,4,vrep.simx_opmode_blocking);
    end
end
  
end