!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'support'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'TB 6/9/2023 11:26:22'!
setUp

	support := CartTestingSupport new.! !

!CartTest methodsFor: 'tests' stamp: 'TB 6/9/2023 11:26:29'!
test01NewCartsAreCreatedEmpty

	self assert: support createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'TB 6/9/2023 11:26:36'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := support createCart.
	
	self 
		should: [ cart add: support itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'TB 6/9/2023 11:26:40'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := support createCart.
	
	cart add: support itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'TB 6/9/2023 11:26:44'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := support createCart.
	
	self 
		should: [cart add: 0 of: support itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'TB 6/9/2023 11:26:50'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := support createCart.
	
	self 
		should: [cart add: 2 of: support itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'TB 6/9/2023 11:26:56'!
test06CartRemembersAddedItems

	| cart |
	
	cart := support createCart.
	
	cart add: support itemSellByTheStore.
	self assert: (cart includes: support itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'TB 6/9/2023 11:27:02'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := support createCart.
	
	self deny: (cart includes: support itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'TB 6/9/2023 11:27:06'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := support createCart.
	
	cart add: 2 of: support itemSellByTheStore.
	self assert: (cart occurrencesOf: support itemSellByTheStore) = 2! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'support'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'TB 6/11/2023 18:34:20'!
checkoutWithValidCartAfterRunning: aClosure

	| cart cashier transactionRecord |
	cart := support createCart.
	cart add: 	support itemSellByTheStore .
	
	aClosure value: cart.
	
	transactionRecord := OrderedCollection new.
	cashier := Cashier new.
	cashier checkout: cart with: self validCreditCard record: transactionRecord on: self dateForToday merchantProcessor: self merchantProcessorSimulator.
	
	^transactionRecord! !

!CashierTest methodsFor: 'support' stamp: 'TB 6/9/2023 11:51:21'!
dateForToday

	^June/15/2023! !

!CashierTest methodsFor: 'support' stamp: 'TB 6/9/2023 12:00:59'!
expiredCreditCard
	
	^CreditCard expiringOn: (self todaysMonthOfYearDisplacedBy: 1 * month).! !

!CashierTest methodsFor: 'support' stamp: 'TB 6/11/2023 18:39:30'!
merchantProcessorSimulator

	^MerchantProcessorSimulator stolen: Array new! !

!CashierTest methodsFor: 'support' stamp: 'TB 6/11/2023 18:37:50'!
shouldCheckingOutWith: aCreditCard and: aMerchantProcessor verify: anErrorVerificationBlock

	| cart cashier transactionRecord |
	cart := support createCart.
	cart add: support itemSellByTheStore.
	
	transactionRecord := OrderedCollection new.
	cashier := Cashier new.
	
	self should: [cashier checkout: cart with: aCreditCard record: transactionRecord on: self dateForToday merchantProcessor: aMerchantProcessor ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | anErrorVerificationBlock value: anError value: transactionRecord]! !

!CashierTest methodsFor: 'support' stamp: 'TB 6/9/2023 12:00:45'!
todaysMonthOfYearDisplacedBy: anAmountOfMonths

	^ GregorianMonthOfYear year: self dateForToday year month: (self dateForToday month next: anAmountOfMonths)! !

!CashierTest methodsFor: 'support' stamp: 'TB 6/11/2023 18:15:11'!
validCreditCard

	^ CreditCard expiringOn: self validCreditCardExpiryDate! !

!CashierTest methodsFor: 'support' stamp: 'TB 6/11/2023 18:15:04'!
validCreditCardExpiryDate

	^ self todaysMonthOfYearDisplacedBy: -1 * month! !


!CashierTest methodsFor: 'setUp/tearDown' stamp: 'TB 6/9/2023 11:27:57'!
setUp

	support := CartTestingSupport new.
! !


!CashierTest methodsFor: 'testing' stamp: 'TB 6/11/2023 18:19:22'!
test01CashierCannotCheckoutEmptyCart

	| cart cashier transactionRecord |
	cart := support createCart.
	transactionRecord := OrderedCollection new.
	cashier := Cashier new.
	
	self should: [cashier checkout: cart with: self validCreditCard record: transactionRecord on: self dateForToday merchantProcessor: self merchantProcessorSimulator] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:exception |
			self assert: Cashier cannotCheckoutEmptyCartErrorDescription equals: exception messageText.			
			self assert: transactionRecord isEmpty.
		]! !

!CashierTest methodsFor: 'testing' stamp: 'TB 6/11/2023 18:34:37'!
test02CashierChecksOutCartWithOneItem

	self assert: 10 equals: (self checkoutWithValidCartAfterRunning: [:aCart | ]) sum.! !

!CashierTest methodsFor: 'testing' stamp: 'TB 6/11/2023 18:34:42'!
test03CashierChecksOutCartWithMultipleItems

	self assert: 15 equals: (self checkoutWithValidCartAfterRunning: [:aCart | aCart add: support secondItemSellByTheStore ]) sum.! !

!CashierTest methodsFor: 'testing' stamp: 'TB 6/11/2023 18:38:01'!
test04CashierCannotCheckoutWithExpiredCreditCard

	self shouldCheckingOutWith: self expiredCreditCard and: self merchantProcessorSimulator verify: [:error :transactionRecord | 
		self assert: Cashier expiredCreditCardErrorDescription equals: error messageText.
		self assert: transactionRecord isEmpty.
	]! !

!CashierTest methodsFor: 'testing' stamp: 'TB 6/11/2023 18:38:57'!
test05CashierCannotCheckoutWithStolenCreditCard

	| merchantProcessor stolenCard |
	stolenCard := self validCreditCard .	
	merchantProcessor := MerchantProcessorSimulator stolen: (Array with: stolenCard). 
	
	self shouldCheckingOutWith: stolenCard and: merchantProcessor verify: [:error :transactionRecord | 
		self assert: MerchantProcessor stolenCreditCardErrorDescription equals: error messageText.
		self assert: transactionRecord isEmpty.
	]! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'accessing' stamp: 'TB 6/9/2023 11:43:32'!
priceOf: anItem

	^anItem x! !

!Cart methodsFor: 'accessing' stamp: 'TB 6/9/2023 11:43:21'!
totalPrice
	^items sum: [:item | self priceOf: item]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartTestingSupport category: 'TusLibros'!
Object subclass: #CartTestingSupport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTestingSupport methodsFor: 'as yet unclassified' stamp: 'TB 6/9/2023 11:25:26'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTestingSupport methodsFor: 'as yet unclassified' stamp: 'TB 6/9/2023 11:39:34'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore with: self secondItemSellByTheStore ! !

!CartTestingSupport methodsFor: 'as yet unclassified' stamp: 'TB 6/9/2023 11:43:51'!
itemNotSellByTheStore
	
	^50@'invalidBook'! !

!CartTestingSupport methodsFor: 'as yet unclassified' stamp: 'TB 6/9/2023 11:43:55'!
itemSellByTheStore
	
	^10@'validBook'! !

!CartTestingSupport methodsFor: 'as yet unclassified' stamp: 'TB 6/9/2023 11:44:01'!
secondItemSellByTheStore
	
	^5@'anotherValidBook'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'TB 6/11/2023 18:31:25'!
assert: aCreditCard isValidFor: aReferenceDate

	^ aCreditCard expiryDate >= aReferenceDate ifTrue: [self error: self class expiredCreditCardErrorDescription]! !

!Cashier methodsFor: 'checkout' stamp: 'TB 6/9/2023 12:05:16'!
assertNotEmpty: aCart

	^ aCart isEmpty ifTrue: [self error: self class cannotCheckoutEmptyCartErrorDescription ]! !

!Cashier methodsFor: 'checkout' stamp: 'TB 6/11/2023 18:19:35'!
checkout: aCart with: aCreditCard record: aTransactionRecord on: aReferenceDate merchantProcessor: aMerchantProcessor     

	self assert: aCreditCard isValidFor: aReferenceDate.
	self assertNotEmpty: aCart.
	aMerchantProcessor validate: aCreditCard.
	
	aTransactionRecord add: aCart totalPrice! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error' stamp: 'TB 6/9/2023 11:30:14'!
cannotCheckoutEmptyCartErrorDescription
	^'No se puede facturar un carrito vacio'! !

!Cashier class methodsFor: 'error' stamp: 'TB 6/11/2023 18:31:25'!
expiredCreditCardErrorDescription
	^'No se puede facturar con una tarjeta expirada'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiryDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'TB 6/9/2023 11:57:33'!
initializeExpiringOn: aGregorianMonthOfYear 

	expiryDate := aGregorianMonthOfYear.! !


!CreditCard methodsFor: 'accessing' stamp: 'TB 6/9/2023 11:57:41'!
expiryDate
	
	^expiryDate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'TB 6/9/2023 11:57:16'!
expiringOn: aGregorianMonthOfYear

	^self new initializeExpiringOn: aGregorianMonthOfYear ! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: 'TusLibros'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'error' stamp: 'TB 6/11/2023 18:28:26'!
stolenCreditCardErrorDescription
	^'Esa tarjeta de credito fue robada'! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'stolen'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'TB 6/11/2023 18:20:44'!
initializeStolen: aCollectionOfStolenCreditCards 
	
	stolen := aCollectionOfStolenCreditCards.! !


!MerchantProcessorSimulator methodsFor: 'validation' stamp: 'TB 6/11/2023 18:23:21'!
validate: aCreditCard 
	
	(stolen includes: aCreditCard) ifTrue: [self error: MerchantProcessor stolenCreditCardErrorDescription].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: 'TusLibros'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'TB 6/11/2023 18:20:19'!
stolen: aCollection
	
	^self new initializeStolen: aCollection! !
