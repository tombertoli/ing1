!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'constants' stamp: 'a 6/25/2023 20:17:06'!
alemAddress
	|address| 
	address:= Address new. 
	address streetName: 'Alem'. 
	address streetNumber: 1122.
	address province: 'CABA'.
	address zipCode: 1001. 
	address town: 'CABA'. 
	
	^address
	
	! !

!ImportTest methodsFor: 'constants' stamp: 'a 6/25/2023 20:16:42'!
juanPerezCustomer
	|customer|
	customer:= Customer new. 
	customer firstName: 'Juan'.
	customer lastName: 'Perez'.
	customer identificationType: 'C'.
	customer identificationNumber: '23-25666777-9'.
	customer addAddress: self alemAddress .
	
	^customer 
	
	! !

!ImportTest methodsFor: 'constants' stamp: 'a 6/25/2023 19:44:49'!
maipuAddress
	|address| 
	address:= Address new. 
	address streetName: 'Maipu'. 
	address streetNumber: 888.
	address province: 'Buenos Aires'.
	address zipCode: 1122. 
	address town: 'Florida'. 
	
	^address
	
	! !

!ImportTest methodsFor: 'constants' stamp: 'a 6/25/2023 19:45:58'!
pepeSanchezCustomer
	|customer|
	customer:= Customer new. 
	customer firstName: 'Pepe'.
	customer lastName: 'Sanchez'.
	customer identificationType: 'D'.
	customer identificationNumber: '22333444'.
	customer addAddress: self sanMartinAddress .
	customer addAddress: self maipuAddress .
	
	^customer 
	
	! !

!ImportTest methodsFor: 'constants' stamp: 'a 6/25/2023 19:44:08'!
sanMartinAddress
	|address| 
	address:= Address new. 
	address streetName: 'San Martin'. 
	address streetNumber: 3322.
	address province: 'BsAs'.
	address zipCode: 1636. 
	address town: 'Olivos'. 
	
	^address
	
	! !


!ImportTest methodsFor: 'asserts' stamp: 'a 6/25/2023 20:07:04'!
assertCustomer: expectedCustomer equals: anotherCustomer 
	
	self assert: expectedCustomer firstName equals:  anotherCustomer firstName.
	self assert: expectedCustomer lastName equals: anotherCustomer lastName. 	
	self assert: expectedCustomer addresses equals: anotherCustomer addresses. 
	self assert: expectedCustomer identificationType equals: anotherCustomer identificationType . 
	self assert: expectedCustomer identificationNumber equals: anotherCustomer identificationNumber. 
	! !

!ImportTest methodsFor: 'asserts' stamp: 'a 6/25/2023 20:10:06'!
assertCustomer: expectedCustomer isIncludedIn: aCollectionOfCustomers 
	
	(aCollectionOfCustomers anySatisfy: [:aCustomer | expectedCustomer = aCustomer ]) ifFalse: [self fail].! !


!ImportTest methodsFor: 'tests' stamp: 'a 6/26/2023 13:46:42'!
setUp
	session:= DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction 

	
	! !

!ImportTest methodsFor: 'tests' stamp: 'a 6/26/2023 13:47:05'!
tearDown
	session close 

	
	! !

!ImportTest methodsFor: 'tests' stamp: 'a 6/26/2023 14:00:43'!
test01CustomersAreWrittenCorrectly
	
	| customers |
	(CustomerImporter for: session from: (UniFileStream new open: 'input.txt' forWrite: false)) value. 
	session commit. 
	
	customers:=session selectAllOfType: Customer. 

	self assertCustomer: self pepeSanchezCustomer isIncludedIn: customers.
	self assertCustomer: self juanPerezCustomer isIncludedIn: customers.
	! !

!ImportTest methodsFor: 'tests' stamp: 'a 6/26/2023 13:57:08'!
test02CustomersAreImportedCorrectlyFromStringStream
	
	| customers array stringStream |
	array:= Array with: 'C,Pepe,Sanchez,D,22333444' with: 'A,San Martin,3322,Olivos,1636,BsAs' with: 'A,Maipu,888,Florida,1122,Buenos Aires' with: 'C,Juan,Perez,C,23-25666777-9' with: 'A,Alem,1122,CABA,1001,CABA'.
	stringStream:= StringStream with: array.
	(CustomerImporter for: session from:stringStream ) value. 
	session commit. 
	
	customers:=session selectAllOfType: Customer. 

	self assertCustomer: self pepeSanchezCustomer isIncludedIn: customers.
	self assertCustomer: self juanPerezCustomer isIncludedIn: customers.
	! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!Address methodsFor: 'as yet unclassified' stamp: 'a 6/25/2023 19:54:06'!
= anObject 
	(anObject isKindOf: Address) ifFalse:[^anObject=self].
	anObject province = self province ifFalse:[^false]. 
	anObject streetName = self streetName ifFalse:[^false] . 	
	anObject streetNumber = self streetNumber ifFalse:[^false]. 
	anObject town = self town ifFalse:[^false] . 
	anObject zipCode= self zipCode ifFalse:[^false]. 
	^true! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!Customer methodsFor: 'importing' stamp: 'a 6/25/2023 19:31:25'!
importCustomers: sessions

	"
	self importCustomers
	"
	| inputStream session newCustomer line |

	inputStream := UniFileStream new open: 'input.txt' forWrite: false.
	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fourth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData fourth ].

		line := inputStream nextLine. ].

	session commit.
	session close.

	inputStream close.
	! !


!Customer methodsFor: 'as yet unclassified' stamp: 'a 6/25/2023 19:53:09'!
= anObject 
	(anObject isKindOf: Customer) ifFalse:[^anObject=self].
	anObject firstName = self firstName ifFalse:[^false]. 
	anObject lastName = self lastName ifFalse:[^false] . 	
	anObject addresses = self addresses ifFalse:[^false]. 
	anObject identificationType = self identificationType ifFalse:[^false] . 
	anObject identificationNumber = self identificationNumber ifFalse:[^false]. 
	^true! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session stream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'a 6/26/2023 13:59:05'!
initializeFor: aSession from: aStream 
	session := aSession.
	stream:=aStream! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'a 6/26/2023 13:59:27'!
value
	| inputStream newCustomer line |

	inputStream:=stream.

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := inputStream nextLine. ].

	inputStream close.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'a 6/26/2023 13:58:40'!
for: aSession from: aStream 
	^self new initializeFor: aSession from: aStream! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'a 6/26/2023 13:58:15'!
initializeFor: aConfiguration from: aString 

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'a 6/26/2023 13:58:15'!
for: aConfiguration

	^self new initializeFor: aConfiguration from: aStream! !


!classDefinition: #StringStream category: 'CustomerImporter'!
Object subclass: #StringStream
	instanceVariableNames: 'collection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!StringStream methodsFor: 'initialization' stamp: 'a 6/26/2023 13:56:46'!
initializeWith: aCollection 
	collection := aCollection.! !


!StringStream methodsFor: 'as yet unclassified' stamp: 'a 6/26/2023 14:02:48'!
nextLine
	| result |
	collection isEmpty ifTrue: [^nil].
	result := collection first. 
	collection := collection allButFirst . 
	^result ! !


!StringStream methodsFor: 'accessing' stamp: 'a 6/26/2023 14:03:08'!
close
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StringStream class' category: 'CustomerImporter'!
StringStream class
	instanceVariableNames: ''!

!StringStream class methodsFor: 'instance creation' stamp: 'a 6/26/2023 13:56:26'!
with: aCollection 
	^self new initializeWith: aCollection ! !
