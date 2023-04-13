!classDefinition: #I category: 'PeanoCloning'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PeanoCloning'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'PeanoCloning'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'private' stamp: 'TB 3/28/2023 10:27:19'!
divideInto: aNumber
	^aNumber! !

!I class methodsFor: 'private' stamp: 'TB 3/28/2023 10:36:27'!
negativeNumbersNotSupportedErrorDescription
	^'Negative numbers not supported'! !

!I class methodsFor: 'private' stamp: 'JFGO 3/25/2023 19:00:37'!
next
	^II.! !

!I class methodsFor: 'private' stamp: 'JFGO 3/25/2023 19:59:30'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous.! !


!I class methodsFor: 'arithmetic operations' stamp: 'TB 3/28/2023 09:24:05'!
* aNumber
	^aNumber! !

!I class methodsFor: 'arithmetic operations' stamp: 'JFGO 3/25/2023 19:13:50'!
+ aNaturalNumber
	^aNaturalNumber next.! !

!I class methodsFor: 'arithmetic operations' stamp: 'TB 3/28/2023 10:35:24'!
/ aNumber
	^aNumber divideInto: self! !


!classDefinition: #II category: 'PeanoCloning'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PeanoCloning'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'PeanoCloning'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'arithmetic operations' stamp: 'TB 3/28/2023 09:27:21'!
* aNumber
	^self previous * aNumber + aNumber! !

!II class methodsFor: 'arithmetic operations' stamp: 'JFGO 3/25/2023 19:27:09'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!II class methodsFor: 'arithmetic operations' stamp: 'JFGO 3/25/2023 19:58:08'!
- aNaturalNumber
	^aNaturalNumber subtractFrom: self.! !

!II class methodsFor: 'arithmetic operations' stamp: 'TB 3/28/2023 10:28:44'!
/ aNumber
	^aNumber divideInto: self! !


!II class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:32:30'!
divideInto: aNumber
	aNumber = self ifFalse: [^I + ((aNumber - self) / self)] ifTrue: [^I]! !

!II class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/26/2023 11:19:10'!
next
	next ifNil: [
		next := self cloneNamed: self name, 'I'. 
		next previous: self.		
		].
	
	^next.! !

!II class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/25/2023 19:25:46'!
previous
	^previous.! !

!II class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/25/2023 19:36:52'!
previous: aNaturalNumber
	previous:=aNaturalNumber.! !

!II class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/25/2023 20:54:19'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'TB 3/28/2023 10:55:49'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'PeanoCloning'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PeanoCloning'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'PeanoCloning'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'arithmetic operations' stamp: 'TB 3/28/2023 10:32:52'!
* aNumber
	^self previous * aNumber + aNumber! !

!III class methodsFor: 'arithmetic operations' stamp: 'TB 3/28/2023 10:32:52'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!III class methodsFor: 'arithmetic operations' stamp: 'TB 3/28/2023 10:32:52'!
- aNaturalNumber
	^aNaturalNumber subtractFrom: self.! !

!III class methodsFor: 'arithmetic operations' stamp: 'TB 3/28/2023 10:32:52'!
/ aNumber
	^aNumber divideInto: self! !


!III class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:32:52'!
divideInto: aNumber
	aNumber = self ifFalse: [^I + ((aNumber - self) / self)] ifTrue: [^I]! !

!III class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:32:52'!
next
	next ifNil: [
		next := self cloneNamed: self name, 'I'. 
		next previous: self.		
		].
	
	^next.! !

!III class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:32:52'!
previous
	^previous.! !

!III class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:32:52'!
previous: aNaturalNumber
	previous:=aNaturalNumber.! !

!III class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:32:52'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!III class methodsFor: '--** private fileout/in **--' stamp: 'TB 3/28/2023 10:55:49'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'PeanoCloning'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PeanoCloning'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'PeanoCloning'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'arithmetic operations' stamp: 'TB 3/28/2023 10:32:52'!
* aNumber
	^self previous * aNumber + aNumber! !

!IIII class methodsFor: 'arithmetic operations' stamp: 'TB 3/28/2023 10:32:52'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!IIII class methodsFor: 'arithmetic operations' stamp: 'TB 3/28/2023 10:32:52'!
- aNaturalNumber
	^aNaturalNumber subtractFrom: self.! !

!IIII class methodsFor: 'arithmetic operations' stamp: 'TB 3/28/2023 10:32:52'!
/ aNumber
	^aNumber divideInto: self! !


!IIII class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:32:52'!
divideInto: aNumber
	aNumber = self ifFalse: [^I + ((aNumber - self) / self)] ifTrue: [^I]! !

!IIII class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:32:52'!
next
	next ifNil: [
		next := self cloneNamed: self name, 'I'. 
		next previous: self.		
		].
	
	^next.! !

!IIII class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:32:52'!
previous
	^previous.! !

!IIII class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:32:52'!
previous: aNaturalNumber
	previous:=aNaturalNumber.! !

!IIII class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:32:52'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!IIII class methodsFor: '--** private fileout/in **--' stamp: 'TB 3/28/2023 10:55:49'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'PeanoCloning'!
DenotativeObject subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PeanoCloning'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'PeanoCloning'!
IIIII class
	instanceVariableNames: 'next previous'!

!IIIII class methodsFor: 'arithmetic operations' stamp: 'TB 3/28/2023 10:33:12'!
* aNumber
	^self previous * aNumber + aNumber! !

!IIIII class methodsFor: 'arithmetic operations' stamp: 'TB 3/28/2023 10:33:12'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!IIIII class methodsFor: 'arithmetic operations' stamp: 'TB 3/28/2023 10:33:12'!
- aNaturalNumber
	^aNaturalNumber subtractFrom: self.! !

!IIIII class methodsFor: 'arithmetic operations' stamp: 'TB 3/28/2023 10:33:12'!
/ aNumber
	^aNumber divideInto: self! !


!IIIII class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:33:12'!
divideInto: aNumber
	aNumber = self ifFalse: [^I + ((aNumber - self) / self)] ifTrue: [^I]! !

!IIIII class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:33:12'!
next
	next ifNil: [
		next := self cloneNamed: self name, 'I'. 
		next previous: self.		
		].
	
	^next.! !

!IIIII class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:33:12'!
previous
	^previous.! !

!IIIII class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:33:12'!
previous: aNaturalNumber
	previous:=aNaturalNumber.! !

!IIIII class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:33:12'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'TB 3/28/2023 10:55:49'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	previous := IIII.! !


!classDefinition: #IIIIII category: 'PeanoCloning'!
DenotativeObject subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PeanoCloning'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'PeanoCloning'!
IIIIII class
	instanceVariableNames: 'next previous'!

!IIIIII class methodsFor: 'arithmetic operations' stamp: 'TB 3/28/2023 10:33:12'!
* aNumber
	^self previous * aNumber + aNumber! !

!IIIIII class methodsFor: 'arithmetic operations' stamp: 'TB 3/28/2023 10:33:12'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!IIIIII class methodsFor: 'arithmetic operations' stamp: 'TB 3/28/2023 10:33:12'!
- aNaturalNumber
	^aNaturalNumber subtractFrom: self.! !

!IIIIII class methodsFor: 'arithmetic operations' stamp: 'TB 3/28/2023 10:33:12'!
/ aNumber
	^aNumber divideInto: self! !


!IIIIII class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:33:12'!
divideInto: aNumber
	aNumber = self ifFalse: [^I + ((aNumber - self) / self)] ifTrue: [^I]! !

!IIIIII class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:33:12'!
next
	next ifNil: [
		next := self cloneNamed: self name, 'I'. 
		next previous: self.		
		].
	
	^next.! !

!IIIIII class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:33:12'!
previous
	^previous.! !

!IIIIII class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:33:12'!
previous: aNaturalNumber
	previous:=aNaturalNumber.! !

!IIIIII class methodsFor: 'private auxiliary operations' stamp: 'TB 3/28/2023 10:33:12'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'TB 3/28/2023 10:55:49'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!