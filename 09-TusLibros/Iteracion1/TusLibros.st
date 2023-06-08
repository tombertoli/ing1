!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'TB 6/8/2023 15:27:08'!
carritoEnStore: unaStore con: unLibro
	| cart |
	cart := Cart in: unaStore.
	cart add: unLibro.
	^cart! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'TB 6/7/2023 17:41:40'!
primerLibro

	^ '1234567890123'! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'TB 6/7/2023 17:41:51'!
segundoLibro

	^ '4567890123456'! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'TB 6/8/2023 15:28:10'!
storeConUnLibro

	^ Store with: self primerLibro! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'TB 6/7/2023 17:55:26'!
test01CarritoNuevoEstaVacio

	self assert: (Cart in: Store new) isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'TB 6/8/2023 15:28:14'!
test02CarritoConItemDejaDeEstarVacio
	| cart |
	cart := self carritoEnStore: self storeConUnLibro con: self primerLibro.
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'TB 6/8/2023 15:29:01'!
test03CarritoTieneTodosLosItemsQueSeAgregan
	| cart availableBooks |
	availableBooks := OrderedCollection with: self primerLibro with: self segundoLibro.
	
	cart := self carritoEnStore: (Store from: availableBooks) con: self primerLibro.
	cart add: self segundoLibro.
	
	self assert: availableBooks equals: cart items.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'TB 6/8/2023 15:28:38'!
test04AgregarItemInexistenteEsInvalido
	| cart |
	cart := Cart in: self storeConUnLibro.
	
	self should: [cart add: self segundoLibro] raise: Error withMessageText: Cart nonExistantItemAdded.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'items store'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'accessing' stamp: 'TB 6/7/2023 17:47:05'!
isEmpty
	^items isEmpty! !

!Cart methodsFor: 'accessing' stamp: 'TB 6/7/2023 17:47:05'!
items
	^items! !


!Cart methodsFor: 'modifying' stamp: 'TB 6/7/2023 17:54:59'!
add: anItem

	(store isAvailable: anItem) ifFalse: [self error: self class nonExistantItemAdded ].
	
	items add: anItem! !


!Cart methodsFor: 'initialization' stamp: 'TB 6/7/2023 17:47:05'!
initialize 

	items := OrderedCollection new.! !

!Cart methodsFor: 'initialization' stamp: 'TB 6/7/2023 17:51:39'!
initializeIn: aStore 
	
	store := aStore.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'TB 6/7/2023 17:51:32'!
in: aStore 
	
	^self new initializeIn: aStore ! !


!Cart class methodsFor: 'errors' stamp: 'TB 6/7/2023 17:52:14'!
nonExistantItemAdded
	
	^'Se intento agregar un elemento inexistente en la tienda'! !


!classDefinition: #Store category: 'TusLibros'!
Object subclass: #Store
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Store methodsFor: 'initialization' stamp: 'TB 6/7/2023 17:57:45'!
initializeFrom: aCollection

	items := aCollection copy.! !

!Store methodsFor: 'initialization' stamp: 'TB 6/7/2023 17:51:20'!
initializeWith: anItem 

	items := OrderedCollection with: anItem.! !


!Store methodsFor: 'as yet unclassified' stamp: 'TB 6/7/2023 17:53:34'!
isAvailable: anItem

	^items includes: anItem! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Store class' category: 'TusLibros'!
Store class
	instanceVariableNames: ''!

!Store class methodsFor: 'instance creation' stamp: 'TB 6/7/2023 17:57:31'!
from: aCollection

	^self new initializeFrom: aCollection! !

!Store class methodsFor: 'instance creation' stamp: 'TB 6/7/2023 17:50:42'!
with: anItem 
	
	^self new initializeWith: anItem ! !
