# Problem: Martian Robots

# The Problem
The surface of Mars can be modelled by a rectangular grid around which robots are able to move according to instructions provided from Earth. You are to write a program that determines each sequence of robot positions and reports the final position of the robot.

A robot position consists of a grid coordinate (a pair of integers: x-coordinate followed by y-coordinate) and an orientation (N, S, E, W for north, south, east, and west).

A robot instruction is a string of the letters “L”, “R”, and “F” which represent, respectively, the instructions:
  - Left: the robot turns left 90 degrees and remains on the current grid point.
  - Right: the robot turns right 90 degrees and remains on the current grid point.
  - Forward: the robot moves forward one grid point in the direction of the current orientation and maintains the same orientation.

The direction North corresponds to the direction from grid point (x, y) to grid point (x, y+1).

There is also a possibility that additional command types may be required in the future and provision should be made for this.

Since the grid is rectangular and bounded (...yes Mars is a strange planet), a robot that moves “off” an edge of the grid is lost forever. However, lost robots leave a robot “scent” that prohibits future robots from dropping off the world at the same grid point. The scent is left at the last grid position the robot occupied before disappearing over the edge. An instruction to move “off” the world from a grid point from which a robot has been previously lost is simply ignored by the current robot.

## The Input
The first line of input is the upper-right coordinates of the rectangular world, the lower-left coordinates are assumed to be 0, 0.

The remaining input consists of a sequence of robot positions and instructions (two lines per robot). A position consists of two integers specifying the initial coordinates of the robot and an orientation (N, S, E, W), all separated by whitespace on one line. A robot instruction is a string of the letters “L”, “R”, and “F” on one line.

Each robot is processed sequentially, i.e., finishes executing the robot instructions before the next robot begins execution.

The maximum value for any coordinate is 50.

All instruction strings will be less than 100 characters in length.

## The Output
For each robot position/instruction in the input, the output should indicate the final grid position and orientation of the robot. If a robot falls off the edge of the grid the word “LOST” should be printed after the position and orientation.

## Sample Input
5 3\
1 1 E RFRFRFRF\
3 2 N FRRFLLFFRRFLL\
0 3 W LLFFFLFLFL

## Sample Output
1 1 E\
3 3 N LOST\
2 3 S

## Usage
The main program can be run using from this Ruby shell script `./bin/mars_robot_control_centre`.
It takes arguments from the commandline.

`./bin/mars_robot_control_centre x y robot_x robot_y robot_orientation instruction_set`

Where:
  - `x` -> _x coordinate of the rectangular world. Defines width of the "world"_
  - `y` -> _y coordinate of the rectangular world. Defines length of the "world"_
  - `robot_x` -> _starting position of the robot along the x-axis_
  - `robot_y` -> _starting position of the robot along the y-axis_
  - `instruction_set` -> _instructions to be performed by the robot i.e. L, R or F_

These generic instructions are suitable for controlling a single robot. However, this system is able to allow a maximum of three robots to be controlled. Please see below for examples on how to run this program for multiple robots.

Run for one robot `./bin/mars_robot_control_centre 5 3 1 1 E RFRFRFRF`

Run for two robots `./bin/mars_robot_control_centre 5 3 1 1 E RFRFRFRF 3 2 N FRRFLLFFRRFLL`

Run for three robots `./bin/mars_robot_control_centre 5 3 1 1 E RFRFRFRF 0 3 W LLFFFLFLFL 3 2 N FRRFLLFFRRFLL`


## Further Improvements
1. There are three outstanding Rubocop violations to clear up in the _perform method_ which will need further consideration. The most pressing of them being the _CyclomaticComplexity_ issue.

2. Every Robot is currently designed to be self-aware of the terrain it’s traversing. Ideally the surface object should be de-coupled from the Robot. It may be best to have a surface “map” which the Robot class knows about rather than the individual robots.

3. I have written a Ruby shell script for this as I’m not entirely sure about how you envisaged how the program will be run.

4. Interactively receive inputs using the _gets_ method in Ruby to receive inputs.

## Limitations
1. It will be very easy to mix up the command-line input. This is an area that can be improved upon. The underlying implementation is set up to allow for this.
