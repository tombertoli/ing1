!classDefinition: #MarsRoverLogTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogTest methodsFor: 'testing' stamp: 'a 6/5/2023 15:35:10'!
newPositionLoggerForMarsRoverVerifies: aConditionToVerify
	| newLog marsRover |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	newLog := Logger for: marsRover with: PositionRecordingStrategy . 
	aConditionToVerify value: marsRover value: newLog! !

!MarsRoverLogTest methodsFor: 'testing' stamp: 'a 6/5/2023 15:34:51'!
test01NewPositionLogIsEmpty 
	self newPositionLoggerForMarsRoverVerifies: [:aMarsRover :aLog | 
		self assert: OrderedCollection new equals: aLog log. 
	]! !

!MarsRoverLogTest methodsFor: 'testing' stamp: 'a 6/5/2023 15:34:51'!
test02PositionLogWithOneCommandIsCorrect
	self newPositionLoggerForMarsRoverVerifies: [:aMarsRover :aLog | 
		aMarsRover process: 'f'.
		self assert: (OrderedCollection with: '1@2') equals: aLog log. 
	]! !

!MarsRoverLogTest methodsFor: 'testing' stamp: 'a 6/5/2023 15:34:51'!
test03PositionLogWithMultipleCommandsIsCorrect
	
	self newPositionLoggerForMarsRoverVerifies: [:aMarsRover :aLog |
		aMarsRover process: 'fblfb'.
		self assert: (OrderedCollection with: '1@2' with: '1@1' with: '0@1' with:'1@1') equals: aLog log. 
	]! !

!MarsRoverLogTest methodsFor: 'testing' stamp: 'a 6/5/2023 14:38:49'!
test04DirectionLogWithMultipleCommandsIsCorrect
	| newLog marsRover |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	newLog := Logger for: marsRover with: HeadingRecordingStrategy . 
	marsRover process: 'rlrrrr'.
	self assert: (OrderedCollection with: 'East' with: 'North' with: 'East' with:'South' with: 'West' with: 'North') equals: newLog log. ! !

!MarsRoverLogTest methodsFor: 'testing' stamp: 'a 6/5/2023 14:42:02'!
test05DirectionAndPositionLogWithMultipleCommandsIsCorrect
	| newLog marsRover |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	newLog :=Logger for: marsRover with: HeadingRecordingStrategy with: PositionRecordingStrategy. 
	marsRover process: 'rflbr'.
	self assert: (OrderedCollection with: 'East' with: '2@1' with: 'North' with:'2@0' with: 'East') equals: newLog log. ! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRoverWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'a 6/5/2023 14:55:04'!
test01NewPositionWindowIsEmpty
	| marsRover window |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth . 
	window := Window for: marsRover with: PositionRecordingStrategy . 
	self assert: '' equals: window position. ! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'a 6/5/2023 14:55:14'!
test02PositionWindowWithCommandsIsCurrentPosition
	| marsRover window |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth . 
	window := Window for: marsRover with: PositionRecordingStrategy . 
	marsRover process: 'fbff'. 
	self assert: '1@3' equals: window position. ! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'a 6/5/2023 14:55:28'!
test03DirectionWindowWithCommandsIsCurrentHeading
	| marsRover window |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth . 
	window := Window for: marsRover with: HeadingRecordingStrategy . 
	marsRover process: 'llrl'. 
	self assert: 'Apuntando al sur' equals: window heading. ! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'a 6/5/2023 14:56:25'!
test04PositionAndDirectionWindowWithCommandsIsCurrentHeading
	| marsRover window |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth . 
	window := Window for: marsRover with: PositionRecordingStrategy with: HeadingRecordingStrategy . 
	marsRover process: 'rflbr'. 
	self assert: 'Apuntando al este' equals: window heading. 
	self assert: '2@0' equals: window position.! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head records'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'a 6/5/2023 14:26:02'!
initializeAt: aPosition heading: aHeadingType
	records:=OrderedCollection new .
	position := VariableWatcher for: aPosition notifying: records with: #positionChanged:.
	head := VariableWatcher for: (aHeadingType for: self with: nil) notifying: records with: #headingChanged:.
! !


!MarsRover methodsFor: 'heading' stamp: 'a 6/5/2023 14:26:02'!
headEast
	
	head update: ( MarsRoverHeadingEast for: self with: nil)! !

!MarsRover methodsFor: 'heading' stamp: 'a 6/5/2023 14:26:02'!
headNorth
	
	head update: ( MarsRoverHeadingNorth for: self with: nil)! !

!MarsRover methodsFor: 'heading' stamp: 'a 6/5/2023 14:26:02'!
headSouth
	
	head update: ( MarsRoverHeadingSouth for: self with: nil)! !

!MarsRover methodsFor: 'heading' stamp: 'a 6/5/2023 14:26:02'!
headWest
	head update: ( MarsRoverHeadingWest for: self with: nil)! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'a 6/4/2023 19:12:15'!
moveEast
	
	position update: (position + (1@0)).! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'a 6/4/2023 19:12:11'!
moveNorth
	
	position update: (position + (0@1)).! !

!MarsRover methodsFor: 'moving' stamp: 'a 6/4/2023 19:12:19'!
moveSouth
	
	position update: (position + (0@-1)).
! !

!MarsRover methodsFor: 'moving' stamp: 'a 6/4/2023 19:12:23'!
moveWest
	
	position update: (position + (-1@0)).
! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'records' stamp: 'a 6/5/2023 14:18:22'!
addRecord: aRecord
	records add: aRecord ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'a 6/5/2023 14:26:02'!
for: aMarsRover with: aStrategy  
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #RecordingStrategy category: 'MarsRover-WithHeading'!
Object subclass: #RecordingStrategy
	instanceVariableNames: 'record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RecordingStrategy methodsFor: 'updating' stamp: 'a 6/5/2023 14:31:44'!
headingChanged: aHeading
	self subclassResponsibility ! !

!RecordingStrategy methodsFor: 'updating' stamp: 'a 6/5/2023 14:31:51'!
positionChanged: aPosition
	self subclassResponsibility ! !


!RecordingStrategy methodsFor: 'initialization' stamp: 'a 6/5/2023 14:36:43'!
initializeForARecord: aRecord 
	record:=aRecord! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RecordingStrategy class' category: 'MarsRover-WithHeading'!
RecordingStrategy class
	instanceVariableNames: ''!

!RecordingStrategy class methodsFor: 'instance creation' stamp: 'a 6/5/2023 14:36:09'!
for: aRecord 
	^self new initializeForARecord: aRecord. ! !


!classDefinition: #HeadingRecordingStrategy category: 'MarsRover-WithHeading'!
RecordingStrategy subclass: #HeadingRecordingStrategy
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingRecordingStrategy methodsFor: 'updating' stamp: 'a 6/5/2023 14:30:23'!
headingChanged: aHeading
	record recordHeadingChange: aHeading! !

!HeadingRecordingStrategy methodsFor: 'updating' stamp: 'a 6/5/2023 14:30:36'!
positionChanged: aPosition! !


!classDefinition: #PositionRecordingStrategy category: 'MarsRover-WithHeading'!
RecordingStrategy subclass: #PositionRecordingStrategy
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionRecordingStrategy methodsFor: 'updating' stamp: 'a 6/5/2023 14:30:54'!
headingChanged: aHeading
	! !

!PositionRecordingStrategy methodsFor: 'updating' stamp: 'a 6/5/2023 14:31:30'!
positionChanged: aPosition
	record recordPositionChange: aPosition ! !


!classDefinition: #RoverRecord category: 'MarsRover-WithHeading'!
Object subclass: #RoverRecord
	instanceVariableNames: 'strategies'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverRecord methodsFor: 'updating' stamp: 'a 6/4/2023 20:57:05'!
headingChanged: aNewHeading 
	self subclassResponsibility ! !

!RoverRecord methodsFor: 'updating' stamp: 'a 6/4/2023 20:57:01'!
positionChanged: aNewPosition 
	self subclassResponsibility ! !


!RoverRecord methodsFor: 'initialization' stamp: 'a 6/5/2023 14:52:57'!
initializeWith: aStrategy 
	strategies:= OrderedCollection with: (aStrategy for: self)! !

!RoverRecord methodsFor: 'initialization' stamp: 'a 6/5/2023 14:51:28'!
initializeWithStrategy: aStrategy andSecondStrategy: aSecondStrategy
	strategies:= OrderedCollection with: (aStrategy for: self) with: (aSecondStrategy for: self) ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverRecord class' category: 'MarsRover-WithHeading'!
RoverRecord class
	instanceVariableNames: ''!

!RoverRecord class methodsFor: 'as yet unclassified' stamp: 'a 6/5/2023 14:54:18'!
for: aMarsRover with: aStrategy 
	|record| 
	record := self new initializeWith: aStrategy. 
	aMarsRover addRecord: record. 
	^record! !

!RoverRecord class methodsFor: 'as yet unclassified' stamp: 'a 6/5/2023 14:54:30'!
for: aMarsRover with: aStrategy with: aSecondStrategy
	|record| 
	record := self new initializeWithStrategy: aStrategy andSecondStrategy: aSecondStrategy . 
	aMarsRover addRecord: record. 
	^record! !


!classDefinition: #Logger category: 'MarsRover-WithHeading'!
RoverRecord subclass: #Logger
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Logger methodsFor: 'modifying' stamp: 'a 6/5/2023 14:32:39'!
recordHeadingChange: aHeading 
	(aHeading isKindOf: MarsRoverHeadingNorth) ifTrue: [log add: 'North']. 
	(aHeading isKindOf: MarsRoverHeadingSouth) ifTrue: [log add: 'South']. 
	(aHeading isKindOf: MarsRoverHeadingEast) ifTrue: [log add: 'East'].
	(aHeading isKindOf: MarsRoverHeadingWest) ifTrue: [log add: 'West'].! !

!Logger methodsFor: 'modifying' stamp: 'a 6/5/2023 14:32:55'!
recordPositionChange: aPosition
	log add: aPosition asString . ! !


!Logger methodsFor: 'initialization' stamp: 'a 6/5/2023 14:53:25'!
initialize 
	log:=OrderedCollection new. ! !


!Logger methodsFor: 'accessing' stamp: 'a 6/4/2023 18:39:24'!
log 
	^log! !


!Logger methodsFor: 'updating' stamp: 'a 6/5/2023 14:43:18'!
headingChanged: aHeading
	strategies do: [:currentStrategy | currentStrategy headingChanged: aHeading ]! !

!Logger methodsFor: 'updating' stamp: 'a 6/5/2023 14:43:18'!
positionChanged: aPosition

	strategies do: [:currentStrategy | currentStrategy positionChanged: aPosition ]! !


!classDefinition: #Window category: 'MarsRover-WithHeading'!
RoverRecord subclass: #Window
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Window methodsFor: 'updating' stamp: 'a 6/5/2023 14:49:05'!
headingChanged: aNewHeading
	strategies do: [:currentStrategy | currentStrategy headingChanged: aNewHeading]! !

!Window methodsFor: 'updating' stamp: 'a 6/5/2023 15:38:05'!
positionChanged: aPosition 
	strategies do: [:currentStrategy | currentStrategy positionChanged: aPosition].! !

!Window methodsFor: 'updating' stamp: 'a 6/5/2023 14:48:37'!
recordHeadingChange: aNewHeading
	(aNewHeading isKindOf: MarsRoverHeadingNorth) ifTrue: [heading:='Apuntando al norte'].
	(aNewHeading isKindOf: MarsRoverHeadingSouth) ifTrue: [heading:='Apuntando al sur'].
	(aNewHeading isKindOf: MarsRoverHeadingWest) ifTrue: [heading:='Apuntando al oeste'].
	(aNewHeading isKindOf: MarsRoverHeadingEast) ifTrue: [heading:='Apuntando al este'].! !

!Window methodsFor: 'updating' stamp: 'a 6/5/2023 14:48:16'!
recordPositionChange: aPosition 
	position := aPosition asString! !


!Window methodsFor: 'initialization' stamp: 'a 6/5/2023 14:53:06'!
initialize 
	heading:=''.
	position:=''! !


!Window methodsFor: 'accessing' stamp: 'a 6/5/2023 14:49:27'!
heading 
	^heading! !

!Window methodsFor: 'accessing' stamp: 'a 6/5/2023 14:49:37'!
position
	^position ! !


!classDefinition: #VariableWatcher category: 'MarsRover-WithHeading'!
ProtoObject subclass: #VariableWatcher
	instanceVariableNames: 'watched notifiers symbol'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!VariableWatcher methodsFor: 'initialization' stamp: 'a 6/4/2023 19:35:14'!
initializeFor: watchedField notifying: objectsToNotify with: aSymbolToNotify  
	watched := watchedField . 
	notifiers := objectsToNotify . 
	symbol:=aSymbolToNotify ! !


!VariableWatcher methodsFor: 'updating' stamp: 'a 6/4/2023 19:36:38'!
update: newValue 
	watched:= newValue . 
	notifiers do: [:currentNotifier | currentNotifier perform: symbol with: newValue]. ! !


!VariableWatcher methodsFor: 'default behaviour' stamp: 'a 6/4/2023 19:26:16'!
doesNotUnderstand: aMessage 
	^aMessage sendTo: watched! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VariableWatcher class' category: 'MarsRover-WithHeading'!
VariableWatcher class
	instanceVariableNames: ''!

!VariableWatcher class methodsFor: 'as yet unclassified' stamp: 'a 6/4/2023 19:29:32'!
for: aPosition notifying: loggers with: aSymbol  
	^self new initializeFor:aPosition notifying: loggers with: aSymbol ! !
