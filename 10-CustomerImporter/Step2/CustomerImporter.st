!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'TB 6/28/2023 19:58:25'!
test01CustomerImporterImportsTestFileCorrectly

	CustomerImporter valueFrom: self validImportData into: session.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'TB 6/28/2023 20:24:29'!
test02CustomerImporterFileWithOnlyAddressesThrowsError

	self should: [CustomerImporter valueFrom: self dataWithOnlyAddresses into: session.]
		raise: Error - MessageNotUnderstood
		withMessageText: CustomerImporter noCustomerToAssignAddressErrorDescription.
		
	self assert: 0 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'tests' stamp: 'TB 6/28/2023 20:29:14'!
test03CustomerImporterFileWithIncompleteCustomerLineThrowsError

	self should: [CustomerImporter valueFrom: self dataWithIncompleteCustomerLine into: session.]
		raise: Error - MessageNotUnderstood
		withMessageText: CustomerImporter invalidLineErrorDescription ! !

!ImportTest methodsFor: 'tests' stamp: 'TB 6/28/2023 20:29:17'!
test04CustomerImporterFileWithIncompleteAddressLineThrowsError

	self should: [CustomerImporter valueFrom: self dataWithIncompleteAddressLine into: session.]
		raise: Error - MessageNotUnderstood
		withMessageText: CustomerImporter invalidLineErrorDescription ! !

!ImportTest methodsFor: 'tests' stamp: 'TB 6/28/2023 20:35:30'!
test05CustomerImporterEmptyFileThrowsError

	self should: [CustomerImporter valueFrom: self emptyData into: session.]
		raise: Error - MessageNotUnderstood
		withMessageText: CustomerImporter emptyFileErrorDescription ! !

!ImportTest methodsFor: 'tests' stamp: 'TB 6/28/2023 20:41:19'!
test06CustomerImporterFileWithNeitherCNorAAsFirstFieldThrowsError

	self should: [CustomerImporter valueFrom: self dataWithInvalidTag into: session.]
		raise: Error - MessageNotUnderstood
		withMessageText: CustomerImporter invalidTagErrorDescription ! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:12:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'TB 6/28/2023 20:38:22'!
dataWithEmptyLine
	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
'! !

!ImportTest methodsFor: 'test data' stamp: 'TB 6/28/2023 20:12:01'!
dataWithIncompleteAddressLine
	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,Maipu,Florida,1122,Buenos Aires'! !

!ImportTest methodsFor: 'test data' stamp: 'TB 6/28/2023 20:09:00'!
dataWithIncompleteCustomerLine
	^ ReadStream on: 'C,Pepe,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'TB 6/28/2023 20:42:07'!
dataWithInvalidTag
	^ReadStream on: 'D,'! !

!ImportTest methodsFor: 'test data' stamp: 'TB 6/28/2023 20:04:51'!
dataWithOnlyAddresses

	^ReadStream on: 
'A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires'! !

!ImportTest methodsFor: 'test data' stamp: 'TB 6/28/2023 20:14:14'!
emptyData
	^ReadStream on: ''! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


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


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

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


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

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


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream customer lineData line'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'TB 6/28/2023 20:36:35'!
value

	[ self canReadLine ] whileTrue: [
		self tokenizeLine.
		self importFromLineData. ].

	"Como no se puede importar solo un Address, customer siempre es nil sii el archivo es vacio (o invalido por otro motivo)"
	customer ifNil: [self error: self class emptyFileErrorDescription].! !


!CustomerImporter methodsFor: 'actions - private' stamp: 'TB 6/28/2023 15:14:07'!
canReadLine

	line := readStream nextLine.
	^line notNil! !

!CustomerImporter methodsFor: 'actions - private' stamp: 'TB 6/28/2023 20:29:00'!
importAddress

	| newAddress |
	lineData size = 6 ifFalse: [self error: self class invalidLineErrorDescription].
	
	newAddress := Address new.
	customer ifNil: [self error: self class noCustomerToAssignAddressErrorDescription].
	customer addAddress: newAddress.
	newAddress streetName: lineData second.
	newAddress streetNumber: lineData third asNumber .
	newAddress town: lineData fourth.
	newAddress zipCode: lineData fifth asNumber .
	newAddress province: lineData sixth! !

!CustomerImporter methodsFor: 'actions - private' stamp: 'TB 6/28/2023 20:29:00'!
importCustomer	 
	lineData size = 5 ifFalse: [self error: self class invalidLineErrorDescription ].
	
	customer := Customer new.
	customer firstName: lineData second.
	customer lastName: lineData third.
	customer identificationType: lineData fourth.
	customer identificationNumber: lineData fifth.
	session persist: customer.! !

!CustomerImporter methodsFor: 'actions - private' stamp: 'TB 6/28/2023 20:42:19'!
importFromLineData

	(lineData first = 'C') ifTrue: [^ self importCustomer].
	(lineData first = 'A') ifTrue: [^ self importAddress].
	
	self error: self class invalidTagErrorDescription ! !

!CustomerImporter methodsFor: 'actions - private' stamp: 'TB 6/28/2023 15:12:22'!
tokenizeLine

	lineData := line findTokens: $,! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!CustomerImporter class methodsFor: 'error' stamp: 'TB 6/28/2023 20:37:52'!
emptyFileErrorDescription
	^'El stream de datos esta vacío'! !

!CustomerImporter class methodsFor: 'error' stamp: 'TB 6/28/2023 20:37:36'!
emptyLineInStreamErrorDescription
	^'Se encontró una línea vacía'! !

!CustomerImporter class methodsFor: 'error' stamp: 'TB 6/28/2023 20:29:00'!
invalidLineErrorDescription
	^'Linea invalida, no tiene suficientes campos'! !

!CustomerImporter class methodsFor: 'error' stamp: 'TB 6/28/2023 20:41:36'!
invalidTagErrorDescription
	^'El identificador es invalido'! !

!CustomerImporter class methodsFor: 'error' stamp: 'TB 6/28/2023 20:04:23'!
noCustomerToAssignAddressErrorDescription
	^'No existe un cliente al cual asignar la direccion'! !


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


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

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

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
