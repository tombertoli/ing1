!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'helpers' stamp: 'TB 4/13/2023 10:47:53'!
addAndSuspendToCustomerBook: aCustomerBook customerNamed: aCustomerName
	aCustomerBook addCustomerNamed: aCustomerName.
	aCustomerBook suspendCustomerNamed: aCustomerName! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'TB 4/13/2023 12:45:58'!
assertThatCustomerBook: aCustomerBook cantSuspendCustomerNamed: customerToSuspend andThenHasSoleCustomerNamed: expectedSoleCustomer
	self assertThatRunning: [ 	aCustomerBook suspendCustomerNamed: customerToSuspend ] 
		throwsError: CantSuspend 
		andVerifies: [ :anError | 
			self assertThatCustomerBook: aCustomerBook hasSoleCustomerNamed: expectedSoleCustomer 
		]! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'TB 4/13/2023 10:52:11'!
assertThatCustomerBook: aCustomerBook hasAmountOfActiveCustomers: amountOfActiveCustomers andHasAmountOfSuspendedCustomers: amountOfSuspendedCustomers andHasTotalAmountOfCustomers: totalAmountOfCustomers
	self assert: amountOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: amountOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: totalAmountOfCustomers equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'TB 4/13/2023 11:20:20'!
assertThatCustomerBook: aCustomerBook hasSoleCustomerNamed: aCustomerName
	self assert: aCustomerBook numberOfCustomers = 1. 
	self assert: (aCustomerBook includesCustomerNamed: aCustomerName)! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'TB 4/13/2023 10:38:06'!
assertThatRunning: aClosure takesLessThan: aDuration
	|millisecondsBeforeRunning millisecondsAfterRunning|
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < aDuration! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'TB 4/13/2023 12:42:40'!
assertThatRunning: aClosure throwsError: anError andVerifies: anErrorVerifyingClosure
	[ aClosure value. 	self fail ]
		on: anError 
		do: anErrorVerifyingClosure! !


!CustomerBookTest methodsFor: 'testing' stamp: 'TB 4/13/2023 10:39:27'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertThatRunning: [
		customerBook addCustomerNamed: 'John Lennon'
	] takesLessThan: 50 * millisecond
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TB 4/13/2023 10:39:18'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self assertThatRunning: [
		customerBook removeCustomerNamed: paulMcCartney
	] takesLessThan: 100 * millisecond
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TB 4/13/2023 12:42:59'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self assertThatRunning: [customerBook addCustomerNamed: ''] 
		throwsError: Error 
		andVerifies: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty 
		]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TB 4/13/2023 12:42:40'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertThatRunning: [customerBook removeCustomerNamed: 'Paul McCartney'] 
		throwsError: NotFound 
		andVerifies: [ :anError | 
			self assertThatCustomerBook: customerBook hasSoleCustomerNamed: johnLennon 
		]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TB 4/13/2023 12:43:15'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self addAndSuspendToCustomerBook: customerBook customerNamed: paulMcCartney.
	
	self assertThatCustomerBook: customerBook 
		hasAmountOfActiveCustomers: 0 
		andHasAmountOfSuspendedCustomers: 1 
		andHasTotalAmountOfCustomers: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney)
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TB 4/13/2023 12:43:31'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self addAndSuspendToCustomerBook: customerBook customerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertThatCustomerBook: customerBook 
		hasAmountOfActiveCustomers: 0 
		andHasAmountOfSuspendedCustomers: 0 
		andHasTotalAmountOfCustomers: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney)


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TB 4/13/2023 12:43:40'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertThatCustomerBook: customerBook 
		cantSuspendCustomerNamed: 'George Harrison' 
		andThenHasSoleCustomerNamed: johnLennon
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TB 4/13/2023 12:43:45'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	self addAndSuspendToCustomerBook: customerBook customerNamed: johnLennon.
	
	self assertThatCustomerBook: customerBook 
		cantSuspendCustomerNamed: johnLennon 
		andThenHasSoleCustomerNamed: johnLennon
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'TB 4/13/2023 11:46:50'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'TB 4/13/2023 11:45:53'!
removeCustomerNamed: aName 
 
	self removeFromCollection: active elementsWithValue: aName andRun: [
		^aName
	].

	self removeFromCollection: suspended elementsWithValue: aName andRun: [
		^aName
	].

	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'helpers' stamp: 'TB 4/13/2023 11:44:52'!
removeFromCollection: aCollection elementsWithValue: anElement andRun: aClosure 
	1 to: aCollection size do: 	[ :index |	 anElement = (aCollection at: index)			ifTrue: [
		aCollection removeAt: index.
		aClosure value
	]].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
