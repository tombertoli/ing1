!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'sentenceFinder stackToSearch winterIsHere expectedResults stackToSearchClone wint winningEleven'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'TB 4/23/2023 18:35:52'!
test01PrefixIsCaseSensitive
	
	stackToSearch push: 'winter is coming'.	
	self assertFindMatchesExpected ! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'TB 4/23/2023 18:03:56'!
test02EmptyPrefixThrowsError

	self should: [sentenceFinder find: '' in: stackToSearch] raise: Error description: SentenceFinderByPrefix emptyPrefixError.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'TB 4/23/2023 18:03:53'!
test03PrefixWithSpacesThrowsError

	self should: [sentenceFinder find: 'hola como' in: stackToSearch] raise: Error description: SentenceFinderByPrefix prefixHasSpacesError.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'TB 4/23/2023 18:29:18'!
test04StackShouldRemainUnchangedAfterFind	

	sentenceFinder find: wint in: stackToSearch.
	self assert: stackToSearchClone isEqualTo: stackToSearch.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'TB 4/23/2023 18:36:34'!
test05PrefixIsSearchedOnlyAtTheBeginningOfStrings
	
	stackToSearch push: 'The winds of Winter'.	
	self assertFindMatchesExpected ! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'TB 4/23/2023 18:36:41'!
test06PrefixDoesNotIgnoreWhitespace
		
	stackToSearch push: ' ', wint.
	self assertFindMatchesExpected ! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'TB 4/23/2023 18:36:46'!
test07FindMatchesMultipleSentences

	| winterIsTheBestSeason |
	winterIsTheBestSeason := 'Winter is the best season'.
	stackToSearch push: winterIsTheBestSeason.
	expectedResults add: winterIsTheBestSeason.
	
	self assertFindMatchesExpected ! !


!SentenceFinderByPrefixTest methodsFor: 'setUp/tearDown' stamp: 'TB 4/23/2023 18:28:59'!
setUp

	wint := 'Wint'.
	winterIsHere := 'Winter is here'.
	winningEleven := 'winning eleven'.
	sentenceFinder := SentenceFinderByPrefix new.
	
	stackToSearch := OOStack new.	
	stackToSearch push: winterIsHere.
	stackToSearch push: winningEleven.
	
	stackToSearchClone := OOStack new.
	stackToSearchClone push: winterIsHere.	
	stackToSearchClone push: winningEleven.
	
	expectedResults := OrderedCollection with: winterIsHere.! !


!SentenceFinderByPrefixTest methodsFor: 'helpers' stamp: 'TB 4/23/2023 18:24:33'!
assert: anUnmodifiedStack isEqualTo: aPossiblyModifiedStack
	
	[anUnmodifiedStack isEmpty] whileFalse: [	self assert: anUnmodifiedStack pop = aPossiblyModifiedStack pop].
	self assert: aPossiblyModifiedStack isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'helpers' stamp: 'TB 4/23/2023 18:35:52'!
assertFindMatchesExpected

	self assert: (sentenceFinder find: wint in: stackToSearch) = expectedResults! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'TB 4/23/2023 16:41:33'!
initialize
	
	state := EmptyStackState new.! !


!OOStack methodsFor: 'accessing' stamp: 'TB 4/23/2023 16:54:38'!
isEmpty

	^state isKindOf: EmptyStackState! !

!OOStack methodsFor: 'accessing' stamp: 'TB 4/23/2023 16:45:29'!
size

	^state size! !

!OOStack methodsFor: 'accessing' stamp: 'TB 4/23/2023 17:26:30'!
top
	
	self isEmpty ifTrue: [self error: self class stackEmptyErrorDescription].
	^state value.	! !


!OOStack methodsFor: 'adding' stamp: 'TB 4/23/2023 16:37:11'!
push: aValueToPush

	state := NonEmptyStackState with: aValueToPush next: state! !


!OOStack methodsFor: 'removing' stamp: 'TB 4/23/2023 17:26:22'!
pop
	
	| valueToReturn |
	self isEmpty ifTrue: [self error: self class stackEmptyErrorDescription].
	
	valueToReturn := state value.
	state := state next.
	^valueToReturn! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'TB 4/23/2023 18:18:36'!
find: aPrefixToFind in: aStackToSearchIn

	| currentElement wordsWithPrefix |
	
	aPrefixToFind isEmpty ifTrue: [self error: self class emptyPrefixError].
	aPrefixToFind detect: [:aCharacterInPrefix | aCharacterInPrefix asString = ' '] ifFound: [self error: self class prefixHasSpacesError] ifNone: [].
	aStackToSearchIn isEmpty ifTrue: [^OrderedCollection new].
	
	currentElement := aStackToSearchIn pop.
	wordsWithPrefix := self find: aPrefixToFind in: aStackToSearchIn.
	aStackToSearchIn push: currentElement.
	
	(currentElement is: aPrefixToFind substringAt: 1) ifTrue: [wordsWithPrefix add: currentElement].	
	^wordsWithPrefix
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'TB 4/23/2023 17:39:22'!
emptyPrefixError

	^'El prefijo vacio no es un prefijo valido'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'TB 4/23/2023 17:45:57'!
prefixHasSpacesError

	^'Un prefijo no puede tener espacios'! !


!classDefinition: #StackState category: 'Stack-Exercise'!
Object subclass: #StackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackState methodsFor: 'accessing' stamp: 'TB 4/23/2023 16:42:21'!
next

	self subclassResponsibility ! !

!StackState methodsFor: 'accessing' stamp: 'TB 4/23/2023 16:44:44'!
size

	self subclassResponsibility! !


!classDefinition: #EmptyStackState category: 'Stack-Exercise'!
StackState subclass: #EmptyStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStackState methodsFor: 'accessing' stamp: 'TB 4/23/2023 16:42:27'!
next

	^self! !

!EmptyStackState methodsFor: 'accessing' stamp: 'TB 4/23/2023 16:45:07'!
size

	^0! !


!classDefinition: #NonEmptyStackState category: 'Stack-Exercise'!
StackState subclass: #NonEmptyStackState
	instanceVariableNames: 'value next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NonEmptyStackState methodsFor: 'initialization' stamp: 'TB 4/23/2023 16:38:37'!
initializeWith: aValueToStore next: nextState

	value := aValueToStore.
	next := nextState! !


!NonEmptyStackState methodsFor: 'accessing' stamp: 'TB 4/23/2023 16:42:37'!
next

	^next! !

!NonEmptyStackState methodsFor: 'accessing' stamp: 'TB 4/23/2023 16:45:17'!
size

	^1 + next size.! !

!NonEmptyStackState methodsFor: 'accessing' stamp: 'TB 4/23/2023 16:40:43'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NonEmptyStackState class' category: 'Stack-Exercise'!
NonEmptyStackState class
	instanceVariableNames: ''!

!NonEmptyStackState class methodsFor: 'instance creation' stamp: 'TB 4/23/2023 16:38:03'!
with: aValueToStore next: nextState

	^self new initializeWith: aValueToStore next: nextState ! !
