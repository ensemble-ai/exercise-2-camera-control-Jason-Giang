# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* [Jason Gao] 
* *email:* [jngao@ucdavis.edu]

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [x] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
There was a crosshair that was drawn, but it doesn't follow right on top of the target/Vessel. Also cannot zoom in or out.
___
### Stage 2 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [x] Unsatisfactory

___
#### Justification ##### 
The mesh drawn was the a crosshair instead of a bounding box. The box seems to be only blocking one side of the screen(left).
___
### Stage 3 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [x] Unsatisfactory

___
#### Justification ##### 
The crosshair was drawn, but after the target stops moving, it doesn't go back to the target. Also, there is no leash distance. The crosshair also doesn't seem to follow the target, rather both the crosshair and target are linked in control inputs.
___
### Stage 4 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [x] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Write Justification here.
The crosshair doesn't go back to the target after the delay duration.Because the crosshair is faster than the target, it does somewhat look like the target is following the crosshair.
The camera doesn't have a leash distance.
___
### Stage 5 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [x] Unsatisfactory
The implementations for almost all of the cameras is the same. There isn't 2 borders and none of the functionalities were added.
___
#### Justification ##### 

___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the dotnet style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####
[Spaces between functions](https://github.com/ensemble-ai/exercise-2-camera-control-Jason-Giang/blob/8e58baeb7d9f6bc0e8e298522f332872aba2dcc6/Obscura/scripts/camera_controllers/four_way_push.gd#L21) aren't always 2 blank lines.

#### Style Guide Exemplars ####
Had good spacing between [if statements](https://github.com/ensemble-ai/exercise-2-camera-control-Jason-Giang/blob/8e58baeb7d9f6bc0e8e298522f332872aba2dcc6/Obscura/scripts/camera_controllers/position_lock.gd#L14). 
Good white spacing [between oporators and commas](https://github.com/ensemble-ai/exercise-2-camera-control-Jason-Giang/blob/8e58baeb7d9f6bc0e8e298522f332872aba2dcc6/Obscura/scripts/camera_controllers/position_lock_lerp.gd#L20).
Trailing [zeros'](https://github.com/ensemble-ai/exercise-2-camera-control-Jason-Giang/blob/8e58baeb7d9f6bc0e8e298522f332872aba2dcc6/Obscura/scripts/camera_controllers/position_lock_lerp.gd#L4) for floats.
___
#### Put style guide infractures ####

___

# Best Practices #

### Description ###

If the student has followed best practices (Unity coding conventions from the StyleGuides document) then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.

This should be similar to the Code Style justification.

#### Best Practices Infractions ####
There was a lack of comments on all of the camera controllers, making it harder to understand the functionality. 


#### Best Practices Exemplars ####
It was good to wrap the [long variables](https://github.com/ensemble-ai/exercise-2-camera-control-Jason-Giang/blob/8e58baeb7d9f6bc0e8e298522f332872aba2dcc6/Obscura/scripts/camera_controllers/lerp_smoothing_target_focus.gd#L20) with multiple lines for readability.
All of the camera controller scripts are in the camera_controlers folder.
