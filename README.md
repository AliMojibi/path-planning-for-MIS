# Path Planning under Penetration Point Constraints for MIS
This project was part of the Medical Robotics Course and focuses on solving the path planning problem under penetration point constraints for Minimally Invasive Surgery (MIS). The objective is to generate an optimized trajectory for the end-effector of a robotic arm, ensuring precise and controlled movement in line with the task requirements.

# Problem Statement
In MIS, the end-effector's motion must adhere to some constraints, such as maintaining a fixed penetration point while achieving linear motion.
This project formulates an optimization problem to respect these constraints and generate feasible paths for the Mitsubish PA-10 robot based on the paper


# Features
* Inverse Kinematics: Solved the inverse kinematics for the Mitsubishi PA-10 robot to achieve precise control over the end-effector's trajectory.
* Optimization: Formulated and solved an optimization problem to generate linear motion of the end-effector while maintaining the penetration point constraint.
*Trajectory Generation: Generated a trajectory and demonstrated the robot's controlled motion.
# Tools Used
MATLAB: Used for solving the optimization problem and simulating the robot's motion.

# References
If you wish to dive deeper into the concepts used in this project, you can refer to the following paper:
https://ieeexplore.ieee.org/abstract/document/1043963/

Michelin, M., Dombre, E., Poignet, P., Pierrot, F., & Eckert, L. (2002). Path planning under a penetration point constraint for minimally invasive surgery. IEEE/RSJ International Conference on Intelligent Robots and Systems, 2, 1475-1480. IEEE.
