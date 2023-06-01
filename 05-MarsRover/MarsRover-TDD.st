!classDefinition: #RoverTests category: 'MarsRover-TDD'!
TestCase subclass: #RoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-TDD'!

!RoverTests methodsFor: 'assertions' stamp: 'a 5/14/2023 15:57:51'!
assertRover: aRover at: aPosition heading: aDirection 
	self assert: aPosition equals: aRover position. 
	self assert: aDirection equals: aRover direction. ! !


!RoverTests methodsFor: 'testing' stamp: 'a 5/15/2023 10:11:54'!
test00NoCommandsDoesNothing
	self assertRover:((Rover at: 1@1  heading: North new) command: '')	 at: 1@1 heading: North new. ! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/14/2023 17:38:26'!
test01RoverBeginsAtPositionAndHeading
	self assertRover: (Rover at: 1@1 heading: North new) at: 1@1 heading: North new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/14/2023 17:38:41'!
test02MovingRoverForwardModifiesCorrectlyRoversPosition
	self assertRover: ((Rover at: 1@1 heading: North new) command: 'f') at: 1@2 heading: North new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/14/2023 17:38:50'!
test03MovingRoverForwardTwiceModifiesCorrectlyRoversPosition
	self assertRover: ((Rover at: 1@1 heading: North new) command: 'ff') at: 1@3 heading: North new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/14/2023 17:39:03'!
test04MovingRoverBackwardsModifiesCorrectlyRoversPosition
	self assertRover: ((Rover at: 1@1 heading: North new) command: 'b') at: 1@0 heading: North new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/14/2023 17:39:40'!
test05MovingRoverBackwardsTwiceModifiesCorrectlyRoversPosition
	self assertRover: ((Rover at: 1@1 heading: North new) command: 'bb') at: 1@-1 heading: North new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/14/2023 17:39:55'!
test06RotatingLeftTurnsNorthToWest
	self assertRover: ((Rover at: 1@1 heading: North new) command: 'l') at: 1@1 heading: West new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/14/2023 17:40:09'!
test07RotatingLeftTwiceTurnsNorthToSouth
	self assertRover: ((Rover at: 1@1 heading: North new) command: 'll') at: 1@1 heading: South new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/14/2023 17:40:28'!
test08RotatingLeftThreeTimesTurnsNorthToEast
	self assertRover: ((Rover at: 1@1 heading: North new) command: 'lll') at: 1@1 heading: East new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/14/2023 17:49:01'!
test09RotatingLeftFourTimesTurnsDoesNotModifyDirection
	self assertRover: ((Rover at: 1@1 heading: North new) command: 'llll') at: 1@1 heading: North new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/14/2023 17:49:07'!
test10RotatingRightTurnsNorthToEast
	self assertRover: ((Rover at: 1@1 heading: North new) command: 'r') at: 1@1 heading: East new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/14/2023 17:50:58'!
test11RotatingRightTwiceTurnsNorthToSouth
	self assertRover: ((Rover at: 1@1 heading: North new) command: 'rr') at: 1@1 heading: South new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/14/2023 17:52:54'!
test12RotatingRightThreeTimesTurnsNorthToWest
	self assertRover: ((Rover at: 1@1 heading: North new) command: 'rrr') at: 1@1 heading: West new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/14/2023 17:53:55'!
test13RotatingRightFourTimesDoesNotChangeState
	self assertRover: ((Rover at: 1@1 heading: North new) command: 'rrrr') at: 1@1 heading: North new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/14/2023 18:02:12'!
test14InvalidCommandRaisesError
	self should:[
		(Rover at: 1@1 heading: North new) command: 'p']
	raise: 
		Error
	withMessageText: 
		Rover invalidCommandErrorDescription! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/14/2023 18:12:38'!
test15InvalidCommandDoesNotAllowAnyMoreCommands
	| rover |
	rover:= Rover at: 1@1 heading: North new.
	[rover command: 'p'] on: Error do: []. 
	self should:[
		rover command: 'f']
	raise: 
		Error
	withMessageText: 
		Rover invalidStateErrorDescription! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/15/2023 10:19:31'!
test16RoverHeadingSouthMovesForwardOnceCorrectly
	self assertRover: ((Rover at: 1@1  heading: South new) command: 'f')at: 1@0 heading: South new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/15/2023 10:19:50'!
test17RoverHeadingSouthMovesForwardTwiceCorrectly
	self assertRover: ((Rover at: 1@1  heading: South new) command: 'ff')at: 1@-1 heading: South new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/15/2023 10:21:01'!
test18RoverHeadingEastMovesForwardOnceCorrectly
	self assertRover: ((Rover at: 1@1  heading: East new) command: 'f')at: 2@1 heading: East new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/15/2023 10:21:42'!
test19RoverHeadingEastMovesForwardTwiceeCorrectly
	self assertRover: ((Rover at: 1@1  heading: East new) command: 'ff')at: 3@1 heading: East new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/15/2023 10:22:42'!
test20RoverHeadingWestMovesForwardOnceCorrectly
	self assertRover: ((Rover at: 1@1  heading: West new) command: 'f')at: 0@1 heading: West new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/15/2023 10:23:03'!
test21RoverHeadingWestMovesForwardTwiceCorrectly
	self assertRover: ((Rover at: 1@1  heading: West new) command: 'ff')at: -1@1 heading: West new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/15/2023 10:30:55'!
test22RoverHeadingSouthMovesBackwardOnceCorrectly
	self assertRover: ((Rover at: 1@1  heading: South new) command: 'b')at: 1@2 heading: South new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/15/2023 10:31:42'!
test23RoverHeadingSouthMovesBackwardTwiceCorrectly
	self assertRover: ((Rover at: 1@1  heading: South new) command: 'bb')at: 1@3 heading: South new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/15/2023 10:34:09'!
test24RoverHeadingEastMovesBackwardOnceCorrectly
	self assertRover: ((Rover at: 1@1  heading: East new) command: 'b')at: 0@1 heading: East new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/15/2023 10:34:52'!
test25RoverHeadingEastMovesBackwardTwiceCorrectly
	self assertRover: ((Rover at: 1@1  heading: East new) command: 'bb')at: -1@1 heading: East new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/15/2023 10:36:32'!
test26RoverHeadingWestMovesBackwardOnceCorrectly
	self assertRover: ((Rover at: 1@1  heading: West new) command: 'b')at: 2@1 heading: West new! !

!RoverTests methodsFor: 'testing' stamp: 'a 5/15/2023 10:36:26'!
test27RoverHeadingWestMovesBackwardTwiceCorrectly
	self assertRover: ((Rover at: 1@1  heading: West new) command: 'bb')at: 3@1 heading: West new! !


!classDefinition: #Command category: 'MarsRover-TDD'!
Object subclass: #Command
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-TDD'!

!Command methodsFor: 'execution' stamp: 'a 5/14/2023 16:37:11'!
executeWith: aRover 
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: 'MarsRover-TDD'!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'handling' stamp: 'a 5/14/2023 16:45:11'!
canHandle: aCommand 
	self subclassResponsibility ! !


!classDefinition: #MoveBackwardCommand category: 'MarsRover-TDD'!
Command subclass: #MoveBackwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-TDD'!

!MoveBackwardCommand methodsFor: 'execution' stamp: 'a 5/14/2023 16:37:35'!
executeWith: aRover 
	aRover moveBackward ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveBackwardCommand class' category: 'MarsRover-TDD'!
MoveBackwardCommand class
	instanceVariableNames: ''!

!MoveBackwardCommand class methodsFor: 'handling' stamp: 'a 5/14/2023 16:46:31'!
canHandle: aCommand 
	^aCommand = $b ! !


!classDefinition: #MoveForwardCommand category: 'MarsRover-TDD'!
Command subclass: #MoveForwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-TDD'!

!MoveForwardCommand methodsFor: 'execution' stamp: 'a 5/14/2023 16:37:46'!
executeWith: aRover 
	aRover moveForward ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveForwardCommand class' category: 'MarsRover-TDD'!
MoveForwardCommand class
	instanceVariableNames: ''!

!MoveForwardCommand class methodsFor: 'as yet unclassified' stamp: 'a 5/14/2023 16:46:44'!
canHandle: aCommand 
	^aCommand = $f! !


!classDefinition: #RotateLeftCommand category: 'MarsRover-TDD'!
Command subclass: #RotateLeftCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-TDD'!

!RotateLeftCommand methodsFor: 'execution' stamp: 'a 5/14/2023 17:05:50'!
executeWith: aRover 
	aRover rotateLeft ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateLeftCommand class' category: 'MarsRover-TDD'!
RotateLeftCommand class
	instanceVariableNames: ''!

!RotateLeftCommand class methodsFor: 'as yet unclassified' stamp: 'a 5/14/2023 17:06:02'!
canHandle: aCommand 
	^aCommand = $l! !


!classDefinition: #RotateRightCommand category: 'MarsRover-TDD'!
Command subclass: #RotateRightCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-TDD'!

!RotateRightCommand methodsFor: 'execution' stamp: 'a 5/14/2023 17:09:24'!
executeWith: aRover 
	aRover rotateRight ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateRightCommand class' category: 'MarsRover-TDD'!
RotateRightCommand class
	instanceVariableNames: ''!

!RotateRightCommand class methodsFor: 'as yet unclassified' stamp: 'a 5/14/2023 17:09:35'!
canHandle: aCommand 
	^aCommand = $r! !


!classDefinition: #Direction category: 'MarsRover-TDD'!
Object subclass: #Direction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-TDD'!

!Direction methodsFor: 'movement' stamp: 'a 5/15/2023 10:38:51'!
moveBackwardWith: aRover 
	self subclassResponsibility ! !

!Direction methodsFor: 'movement' stamp: 'a 5/15/2023 10:25:14'!
moveForwardWith: aRover 
	self subclassResponsibility ! !


!Direction methodsFor: 'directions' stamp: 'a 5/14/2023 17:34:51'!
left 
	self subclassResponsibility ! !

!Direction methodsFor: 'directions' stamp: 'a 5/14/2023 17:55:38'!
right 
	self subclassResponsibility ! !


!Direction methodsFor: 'comparing' stamp: 'a 5/14/2023 17:45:02'!
= aDirection 
	^aDirection class = self class! !


!classDefinition: #East category: 'MarsRover-TDD'!
Direction subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-TDD'!

!East methodsFor: 'directions' stamp: 'a 5/14/2023 17:46:41'!
left 
	^North new ! !

!East methodsFor: 'directions' stamp: 'a 5/14/2023 17:57:25'!
right
	^South new! !


!East methodsFor: 'movement' stamp: 'a 5/15/2023 10:39:10'!
moveBackwardWith: aRover 
	aRover moveWest ! !

!East methodsFor: 'movement' stamp: 'a 5/15/2023 10:26:25'!
moveForwardWith: aRover 
	aRover moveEast ! !


!classDefinition: #North category: 'MarsRover-TDD'!
Direction subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-TDD'!

!North methodsFor: 'directions' stamp: 'a 5/14/2023 17:46:04'!
left 
	^West new! !

!North methodsFor: 'directions' stamp: 'a 5/14/2023 17:56:03'!
right
	^East new! !


!North methodsFor: 'movement' stamp: 'a 5/15/2023 10:39:18'!
moveBackwardWith: aRover 
	aRover moveSouth ! !

!North methodsFor: 'movement' stamp: 'a 5/15/2023 10:26:34'!
moveForwardWith: aRover 
	aRover moveNorth ! !


!classDefinition: #South category: 'MarsRover-TDD'!
Direction subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-TDD'!

!South methodsFor: 'directions' stamp: 'a 5/14/2023 17:46:27'!
left 
	^East new ! !

!South methodsFor: 'directions' stamp: 'a 5/14/2023 17:56:13'!
right
	^West new! !


!South methodsFor: 'movement' stamp: 'a 5/15/2023 10:39:25'!
moveBackwardWith: aRover 
	aRover moveNorth ! !

!South methodsFor: 'movement' stamp: 'a 5/15/2023 10:26:57'!
moveForwardWith: aRover 
	aRover moveSouth ! !


!classDefinition: #West category: 'MarsRover-TDD'!
Direction subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-TDD'!

!West methodsFor: 'directions' stamp: 'a 5/14/2023 17:46:35'!
left 
	^South new! !

!West methodsFor: 'directions' stamp: 'a 5/14/2023 17:56:23'!
right
	^North new! !


!West methodsFor: 'movement' stamp: 'a 5/15/2023 10:39:32'!
moveBackwardWith: aRover 
	aRover moveEast ! !

!West methodsFor: 'movement' stamp: 'a 5/15/2023 10:27:07'!
moveForwardWith: aRover 
	aRover moveWest ! !


!classDefinition: #Rover category: 'MarsRover-TDD'!
Object subclass: #Rover
	instanceVariableNames: 'position direction state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-TDD'!

!Rover methodsFor: 'accessing' stamp: 'a 5/14/2023 17:07:41'!
direction
	^direction ! !

!Rover methodsFor: 'accessing' stamp: 'a 5/14/2023 16:05:09'!
position
	^position! !


!Rover methodsFor: 'initialization' stamp: 'a 5/15/2023 10:19:12'!
intializeAt: aPosition heading: aDirection 
	position:=aPosition .
	direction:= aDirection.
	state:= ValidRoverState with: self . ! !


!Rover methodsFor: 'error handling' stamp: 'a 5/14/2023 18:46:25'!
handleInvalidCommand
	state:= BlockedRoverState with: self. 
	self error: self class invalidCommandErrorDescription! !

!Rover methodsFor: 'error handling' stamp: 'a 5/14/2023 18:44:58'!
roverIsBlockedWhenExecuting
	self error: self class invalidStateErrorDescription ! !


!Rover methodsFor: 'updating' stamp: 'a 5/15/2023 10:12:19'!
command: aCommandsList 
	
	aCommandsList do: [:currentCommand |  
		state executeCommand: currentCommand.
		]! !


!Rover methodsFor: 'rotation' stamp: 'a 5/14/2023 18:04:56'!
rotateLeft
	direction:=direction left! !

!Rover methodsFor: 'rotation' stamp: 'a 5/14/2023 17:56:50'!
rotateRight 
	direction:= direction right
	! !


!Rover methodsFor: 'movement' stamp: 'a 5/15/2023 10:39:43'!
moveBackward
	direction moveBackwardWith: self! !

!Rover methodsFor: 'movement' stamp: 'a 5/15/2023 10:28:22'!
moveEast
	position := (position x +1) @ position y! !

!Rover methodsFor: 'movement' stamp: 'a 5/15/2023 10:39:52'!
moveForward 

	direction moveForwardWith: self.
! !

!Rover methodsFor: 'movement' stamp: 'a 5/15/2023 10:27:32'!
moveNorth
	position := position x @ (position y +1)! !

!Rover methodsFor: 'movement' stamp: 'a 5/15/2023 10:27:55'!
moveSouth
	position := position x @ (position y -1)! !

!Rover methodsFor: 'movement' stamp: 'a 5/15/2023 10:28:40'!
moveWest
	position := (position x -1)@position y! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Rover class' category: 'MarsRover-TDD'!
Rover class
	instanceVariableNames: ''!

!Rover class methodsFor: 'initialization' stamp: 'a 5/14/2023 15:59:01'!
at: aPosition heading: aDirection 
	^self new intializeAt: aPosition heading: aDirection ! !


!Rover class methodsFor: 'error handling' stamp: 'a 5/14/2023 16:18:31'!
invalidCommandErrorDescription
	^'El comando ingresado es inválido'! !

!Rover class methodsFor: 'error handling' stamp: 'a 5/14/2023 18:13:31'!
invalidStateErrorDescription
	^'El Rover está bloqueado, recibió un comando inválido'! !


!classDefinition: #RoverState category: 'MarsRover-TDD'!
Object subclass: #RoverState
	instanceVariableNames: 'rover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-TDD'!

!RoverState methodsFor: 'initialization' stamp: 'a 5/14/2023 18:38:47'!
initializeWith: aRover 
	rover := aRover.! !


!RoverState methodsFor: 'execution' stamp: 'a 5/14/2023 18:34:33'!
executeCommand: aCommand 
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverState class' category: 'MarsRover-TDD'!
RoverState class
	instanceVariableNames: ''!

!RoverState class methodsFor: 'initialization' stamp: 'a 5/14/2023 18:38:34'!
with: aRover 
	^self new initializeWith:aRover ! !


!classDefinition: #BlockedRoverState category: 'MarsRover-TDD'!
RoverState subclass: #BlockedRoverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-TDD'!

!BlockedRoverState methodsFor: 'as yet unclassified' stamp: 'a 5/14/2023 18:44:37'!
executeCommand: aCommand 
	rover roverIsBlockedWhenExecuting ! !


!classDefinition: #ValidRoverState category: 'MarsRover-TDD'!
RoverState subclass: #ValidRoverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-TDD'!

!ValidRoverState methodsFor: 'execution' stamp: 'a 5/14/2023 18:42:21'!
executeCommand: aCommand 
	| currentCommandClass |
	currentCommandClass:= 
			Command subclasses 
				detect: [:aCommandClass | aCommandClass canHandle: aCommand ] 
				ifNone: [rover handleInvalidCommand]. 
				
	currentCommandClass new executeWith: rover! !
