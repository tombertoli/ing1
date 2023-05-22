!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'constants' stamp: 'a 5/22/2023 12:30:30'!
cuentaConDepositoDeValor: valueOfTransaction
	| cuenta |
	cuenta := ReceptiveAccount new.
	cuenta register: (Deposit for: valueOfTransaction ).
	^cuenta! !

!PortfolioTest methodsFor: 'constants' stamp: 'a 5/21/2023 12:30:24'!
cuentaConDepositoDeValor: transactionAmount verifica: aCondition
	| depositoAAgregar cuentaAVerificar |
	
	cuentaAVerificar := ReceptiveAccount new.
	depositoAAgregar:= Deposit for: transactionAmount .
	cuentaAVerificar register: depositoAAgregar .
	aCondition value: cuentaAVerificar value: depositoAAgregar.! !

!PortfolioTest methodsFor: 'constants' stamp: 'a 5/22/2023 12:09:47'!
portfolioConCuentaVaciaVerifica: bloqueAVerificar
	| cuenta portfolio |
	portfolio:=PortfolioExistente new. 
	cuenta:=ReceptiveAccount new. 
	portfolio add: cuenta.
	
	bloqueAVerificar value: portfolio value: cuenta 
	
	! !

!PortfolioTest methodsFor: 'constants' stamp: 'a 5/21/2023 20:17:10'!
portfolioConDepositoDeValor: depositValue

	self portfolioConDepositoDeValor: depositValue verifica:[:unPortfolio :depositoAgregado | ^unPortfolio ]! !

!PortfolioTest methodsFor: 'constants' stamp: 'a 5/22/2023 12:09:57'!
portfolioConDepositoDeValor: transactionValue verifica: bloqueAVerificar
	
	| portfolio |
	portfolio := PortfolioExistente new.
	
	self cuentaConDepositoDeValor: transactionValue verifica: [
		:cuentaAAgregar :transaccionAgregada |
		portfolio add: cuentaAAgregar . 
		bloqueAVerificar value: portfolio value: transaccionAgregada 
	]! !

!PortfolioTest methodsFor: 'constants' stamp: 'a 5/22/2023 12:10:04'!
portfolioConDepositoDeValor: depositValue yExtraccionDeValor: withdrawValue verifica: bloqueAVerificar
	| portfolio extraccionAAgregar |
	
	portfolio := PortfolioExistente new.
	self cuentaConDepositoDeValor: depositValue verifica: [
		:cuenta :deposito |
		 
		extraccionAAgregar := Withdraw for: withdrawValue .
		cuenta register: extraccionAAgregar. 
	
		portfolio add: cuenta . 
		bloqueAVerificar value: portfolio value: deposito value: extraccionAAgregar
	]
	! !

!PortfolioTest methodsFor: 'constants' stamp: 'a 5/22/2023 12:27:31'!
shouldPortfolioWithChild: portfolioHijo throwErrorWhenAdding: cuenta 
	| portfolioPadre |
	portfolioPadre:=PortfolioExistente new. 
	portfolioPadre add: portfolioHijo.
	self should: [portfolioPadre add:cuenta] raise: Error withMessageText: PortfolioExistente accountIsAlreadyAddedErrorDescription ! !

!PortfolioTest methodsFor: 'constants' stamp: 'a 5/22/2023 12:27:52'!
shouldPortfolioWithParent:portfolioPadre throwErrorWhenAdding:cuenta 
	| portfolioHijo|
	
	portfolioHijo:=PortfolioExistente new. 
	portfolioPadre add: portfolioHijo .
	self should: [portfolioHijo add:cuenta] raise: Error withMessageText: PortfolioExistente accountIsAlreadyAddedErrorDescription 

! !


!PortfolioTest methodsFor: 'testing' stamp: 'a 5/21/2023 22:26:27'!
test01PortfolioNuevoTieneBalanceCero
	self assert: 0 equals: PortfolioExistente new balance! !

!PortfolioTest methodsFor: 'testing' stamp: 'a 5/21/2023 20:15:17'!
test02PortfolioConUnaCuentaTieneElMismoBalance
	self assert: 5 equals: (self portfolioConDepositoDeValor: 5 ) balance! !

!PortfolioTest methodsFor: 'testing' stamp: 'a 5/22/2023 12:30:30'!
test03PortfolioConDosCuentasTieneElMismoBalance
	| portfolio nuevaCuentaAAgregar |

	portfolio:=self portfolioConDepositoDeValor: 5. 
	
	nuevaCuentaAAgregar := self cuentaConDepositoDeValor: 3.
	
	portfolio add: nuevaCuentaAAgregar.
	
	self assert: 8 equals: portfolio balance! !

!PortfolioTest methodsFor: 'testing' stamp: 'a 5/21/2023 22:26:27'!
test04PortfolioConDosPortfoliosTieneElMismoBalance
	| portfolio |
	portfolio := PortfolioExistente new. 
	portfolio add: (self portfolioConDepositoDeValor: 5) .
	portfolio add: (self portfolioConDepositoDeValor: 3).
	
	self assert: 8 equals: portfolio balance  
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'a 5/21/2023 22:26:27'!
test05PortfolioVacioNoTieneAUnaTransaccion
	self deny: (PortfolioExistente new hasRegistered: (Deposit for: 5))! !

!PortfolioTest methodsFor: 'testing' stamp: 'a 5/22/2023 12:31:03'!
test06PortfolioConUnaCuentaTieneAUnaTransaccionEnEsaCuenta
	
	self portfolioConDepositoDeValor: 5 verifica:[ 
		:portfolio :depositoAgregado |
		self assert: (portfolio hasRegistered: depositoAgregado)
	]! !

!PortfolioTest methodsFor: 'testing' stamp: 'a 5/22/2023 12:33:18'!
test07PortfolioConDosCuentasTieneAUnaTransaccionEnEsaCuenta
	| portfolio |
	portfolio:= PortfolioExistente new. 
	portfolio add: ReceptiveAccount new.
	
	self cuentaConDepositoDeValor: 5 verifica: [
		:cuentaConDeposito :depositoAgregado | 
		portfolio add: cuentaConDeposito .
		self assert: (portfolio hasRegistered: depositoAgregado )
	]! !

!PortfolioTest methodsFor: 'testing' stamp: 'a 5/22/2023 12:34:08'!
test08PortfolioConDosPortfoliosTieneAUnaTransaccionEnEsePortfolio
	| portfolio |
	portfolio := PortfolioExistente new.
	portfolio add: PortfolioExistente new .
	
	self portfolioConDepositoDeValor: 5 verifica:[
		:portfolioConDeposito :depositoAgregado |  	
		portfolio add: portfolioConDeposito.
		self assert: (portfolio hasRegistered: depositoAgregado)
	]! !

!PortfolioTest methodsFor: 'testing' stamp: 'a 5/21/2023 22:26:27'!
test09PortfolioVacioNoTieneTransacciones
	self assert: PortfolioExistente new transactions isEmpty ! !

!PortfolioTest methodsFor: 'testing' stamp: 'a 5/22/2023 12:35:12'!
test10LasTransaccionesDeUnPortfolioConUnaCuentaSonSoloEsasTransacciones

	self portfolioConDepositoDeValor: 5 yExtraccionDeValor: 5 verifica:[ 
		:portfolio :deposito :extraccion|
		self assert: (OrderedCollection with: deposito with: extraccion) equals: portfolio transactions.
	]! !

!PortfolioTest methodsFor: 'testing' stamp: 'a 5/21/2023 20:47:23'!
test11LasTransaccionesDeUnPortfolioConDosCuentasSonEsasTransacciones

	| transaccionesCuenta |
	self portfolioConDepositoDeValor: 5 yExtraccionDeValor: 5 verifica: 			[
		:portfolio :deposito :extraccion | 	
		
		self cuentaConDepositoDeValor: 7 verifica: [
			:segundaCuenta :segundoDeposito | 
			portfolio add: segundaCuenta . 
	
		    	transaccionesCuenta:= OrderedCollection with: deposito with: extraccion with: segundoDeposito. 

		    	self assert:transaccionesCuenta equals: portfolio transactions.
			].
	]! !

!PortfolioTest methodsFor: 'testing' stamp: 'a 5/21/2023 22:26:27'!
test12LasTransaccionesDeUnPortfolioConDosPortfoliosSonEsasTransacciones

    	| portfolio transacciones |
	portfolio := PortfolioExistente new.
	transacciones:= OrderedCollection new. 
    	self portfolioConDepositoDeValor: 5 yExtraccionDeValor: 5 verifica: [
		:primerPortfolio :deposito :extraccion | 
		portfolio add: primerPortfolio . 
		transacciones add: deposito. 
		transacciones add: extraccion. 
	].
	  self portfolioConDepositoDeValor: 7 verifica: [
		:segundoPortfolio :deposito | 
		portfolio add: segundoPortfolio . 
		transacciones add: deposito. 
	].

    	self assert:transacciones equals: portfolio transactions.! !

!PortfolioTest methodsFor: 'testing' stamp: 'a 5/22/2023 12:10:43'!
test13PortfolioConUnaCuentaNoPermiteRepetidos 
	self portfolioConCuentaVaciaVerifica: [:portfolio :cuenta |
		self should: [portfolio add:cuenta] raise: Error withMessageText: PortfolioExistente accountIsAlreadyAddedErrorDescription 
	]	
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'a 5/22/2023 12:27:31'!
test14PortfolioConPortfolioNoPermiteRepetidos 
	self portfolioConCuentaVaciaVerifica: [:portfolioHijo :cuenta |
		self shouldPortfolioWithChild: portfolioHijo throwErrorWhenAdding: cuenta
	]! !

!PortfolioTest methodsFor: 'testing' stamp: 'a 5/22/2023 12:27:31'!
test15PortfolioConPortfolioNietoNoPermiteRepetidos 
	| portfolioHijo |
	portfolioHijo:=PortfolioExistente new. 
	
	self portfolioConCuentaVaciaVerifica: [:portfolioNieto :cuenta | 
		portfolioHijo add: portfolioNieto .
		self shouldPortfolioWithChild: portfolioHijo throwErrorWhenAdding: cuenta 
	]! !

!PortfolioTest methodsFor: 'testing' stamp: 'a 5/22/2023 12:28:45'!
test16PortfolioConPadreNoPermiteRepetidos 
	self portfolioConCuentaVaciaVerifica: [:portfolioPadre :cuenta |
		self shouldPortfolioWithParent: portfolioPadre throwErrorWhenAdding:cuenta 
	]! !

!PortfolioTest methodsFor: 'testing' stamp: 'a 5/22/2023 12:29:10'!
test17PortfolioConAbueloNoPermiteRepetidos 
	|  portfolioPadre |

	self portfolioConCuentaVaciaVerifica: [:portfolioAbuelo :cuenta |
		portfolioPadre:=PortfolioExistente new. 
		portfolioAbuelo add: portfolioPadre .	
	
		self shouldPortfolioWithParent: portfolioPadre throwErrorWhenAdding: cuenta 
	]! !

!PortfolioTest methodsFor: 'testing' stamp: 'a 5/22/2023 12:16:48'!
test18PortfolioConCuentaNoPermiteRepetidosEnHijo 
	|  portfolioPadre |
	self portfolioConCuentaVaciaVerifica: [:portfolioHijo :cuenta |
		portfolioPadre:=PortfolioExistente new. 
		portfolioPadre add:cuenta.
		self should: [portfolioPadre add:portfolioHijo] raise: Error withMessageText: PortfolioExistente accountIsAlreadyAddedErrorDescription 
	]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'accessing' stamp: 'a 5/15/2023 19:54:02'!
contributeToBalance: aBalance
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'accessing' stamp: 'a 5/15/2023 19:54:02'!
contributeToBalance: aBalance
	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'a 5/15/2023 19:32:59'!
value

	^ value! !


!Withdraw methodsFor: 'accessing' stamp: 'a 5/15/2023 19:54:02'!
contributeToBalance: aBalance
	^aBalance - value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #PersonalRegister category: 'Portfolio-Ejercicio'!
Object subclass: #PersonalRegister
	instanceVariableNames: 'padre'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PersonalRegister methodsFor: 'accessing' stamp: 'a 5/21/2023 12:01:58'!
balance
	self subclassResponsibility ! !

!PersonalRegister methodsFor: 'accessing' stamp: 'a 5/22/2023 12:43:07'!
contributeToTransactions
	self subclassResponsibility ! !

!PersonalRegister methodsFor: 'accessing' stamp: 'a 5/21/2023 12:01:23'!
hasRegistered: aTransaction 
	self subclassResponsibility ! !

!PersonalRegister methodsFor: 'accessing' stamp: 'a 5/21/2023 12:02:03'!
transactions
	self subclassResponsibility ! !


!PersonalRegister methodsFor: 'assertions' stamp: 'a 5/22/2023 12:05:31'!
assertReceptiveAccountIsNotIncludedIn: aReceptiveAccount forPortfolio: portfolio 
	self subclassResponsibility ! !

!PersonalRegister methodsFor: 'assertions' stamp: 'a 5/21/2023 21:23:44'!
assertRegisterIsNotIncluded: unRegistro forPortfolio: portfolio  
	self subclassResponsibility ! !


!PersonalRegister methodsFor: 'modifying' stamp: 'a 5/21/2023 22:07:49'!
hasBeenAddedToPortfolio: aPortfolio 
	padre:=aPortfolio ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
PersonalRegister subclass: #Portfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'assertions' stamp: 'a 5/21/2023 22:32:22'!
assertRegisterIsNotIncluded: unRegistro excepting: aRegisterToExcept forPortfolio: aPortfolio
	self subclassResponsibility ! !


!Portfolio methodsFor: 'modifying' stamp: 'a 5/21/2023 22:32:34'!
add: unRegistro 
	self subclassResponsibility ! !


!Portfolio methodsFor: 'error handling' stamp: 'a 5/21/2023 22:33:16'!
hasAddedDuplicatedRegister 
	self error: self class accountIsAlreadyAddedErrorDescription . ! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'errors' stamp: 'a 5/21/2023 22:33:46'!
accountIsAlreadyAddedErrorDescription 
	^'No se puede agregar una cuenta ya agregada'! !


!classDefinition: #PortfolioExistente category: 'Portfolio-Ejercicio'!
Portfolio subclass: #PortfolioExistente
	instanceVariableNames: 'registros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioExistente methodsFor: 'accessing' stamp: 'a 5/21/2023 12:09:02'!
balance
	^(registros sum: [:aRegister | aRegister balance] ifEmpty: [0])! !

!PortfolioExistente methodsFor: 'accessing' stamp: 'a 5/22/2023 12:46:07'!
contributeToTransactions: totalTransactions 
	registros do: [:registroActual | 
		registroActual contributeToTransactions: totalTransactions 
	] ! !

!PortfolioExistente methodsFor: 'accessing' stamp: 'a 5/21/2023 12:09:02'!
hasRegistered: unaTransaccion 

	^(registros anySatisfy:[:registro | registro hasRegistered: unaTransaccion]) 
	! !

!PortfolioExistente methodsFor: 'accessing' stamp: 'a 5/22/2023 12:41:47'!
transactions
	| totalTransactions |
	totalTransactions:=OrderedCollection new.
	registros do:[ :registroActual | 
             registroActual contributeToTransactions: totalTransactions. 
 	].
	^totalTransactions 
! !


!PortfolioExistente methodsFor: 'modifying' stamp: 'a 5/22/2023 11:51:22'!
add: unRegistro 
	registros do: [:registroIterante | 
		registroIterante assertRegisterIsNotIncluded: unRegistro forPortfolio: self
	]. 
	padre assertRegisterIsNotIncluded: unRegistro excepting: self forPortfolio: self.
	registros add: unRegistro.
	unRegistro hasBeenAddedToPortfolio: self. ! !


!PortfolioExistente methodsFor: 'initialization' stamp: 'a 5/21/2023 22:38:37'!
initialize

	registros := OrderedCollection new.
	padre:=PortfolioInexistente new! !


!PortfolioExistente methodsFor: 'assertions' stamp: 'a 5/22/2023 12:06:31'!
assertReceptiveAccountIsNotIncludedIn: aReceptiveAccount forPortfolio: portfolio 
	self assertRegisterIsNotIncluded: aReceptiveAccount forPortfolio: portfolio! !

!PortfolioExistente methodsFor: 'assertions' stamp: 'a 5/21/2023 22:39:07'!
assertRegisterIsNotIncluded: unRegistro excepting: aRegisterToExcept forPortfolio: aPortfolio
	registros do: [:registroIterante| 
		registroIterante = aRegisterToExcept ifFalse: [registroIterante assertRegisterIsNotIncluded:unRegistro  forPortfolio: aPortfolio]
	]. 
	padre assertRegisterIsNotIncluded: unRegistro excepting: self  forPortfolio: aPortfolio! !

!PortfolioExistente methodsFor: 'assertions' stamp: 'a 5/21/2023 21:32:39'!
assertRegisterIsNotIncluded: unRegistro forPortfolio: portfolio  
	registros do: [:registroIterante| 
		registroIterante assertRegisterIsNotIncluded:unRegistro  forPortfolio: portfolio
	] ! !



!classDefinition: #PortfolioInexistente category: 'Portfolio-Ejercicio'!
Portfolio subclass: #PortfolioInexistente
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioInexistente methodsFor: 'assertions' stamp: 'a 5/22/2023 12:06:40'!
assertReceptiveAccountIsNotIncludedIn: aReceptiveAccount forPortfolio: portfolio ! !

!PortfolioInexistente methodsFor: 'assertions' stamp: 'a 5/21/2023 22:37:40'!
assertRegisterIsNotIncluded: unRegistro excepting: aRegisterToExcept forPortfolio: aPortfolio

	 ! !

!PortfolioInexistente methodsFor: 'assertions' stamp: 'a 5/21/2023 22:34:51'!
assertRegisterIsNotIncluded: unRegistro forPortfolio: portfolio  
	! !


!PortfolioInexistente methodsFor: 'accessing' stamp: 'a 5/21/2023 22:35:20'!
balance
	^0! !

!PortfolioInexistente methodsFor: 'accessing' stamp: 'a 5/22/2023 12:46:49'!
contributeToTransactions: totalTransactions 
! !

!PortfolioInexistente methodsFor: 'accessing' stamp: 'a 5/21/2023 22:37:08'!
hasRegistered: aTransaction 
	^false
! !

!PortfolioInexistente methodsFor: 'accessing' stamp: 'a 5/21/2023 22:37:02'!
transactions
	^OrderedCollection new 
! !


!PortfolioInexistente methodsFor: 'modifying' stamp: 'a 5/21/2023 22:37:30'!
add: unRegistro 
	 ! !

!PortfolioInexistente methodsFor: 'modifying' stamp: 'a 5/21/2023 22:35:37'!
hasBeenAddedToPortfolio: aPortfolio 
! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
PersonalRegister subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'a 5/15/2023 19:54:02'!
balance

	^transactions inject:0 into: [ :partialBalance :aTransaction|  aTransaction contributeToBalance: partialBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'assertions' stamp: 'a 5/22/2023 12:03:41'!
assertReceptiveAccountIsNotIncludedIn: aReceptiveAccount forPortfolio: portfolio 
	self = aReceptiveAccount ifTrue: [portfolio hasAddedDuplicatedRegister]! !

!ReceptiveAccount methodsFor: 'assertions' stamp: 'a 5/22/2023 12:06:54'!
assertRegisterIsNotIncluded: unRegistro forPortfolio: portfolio  
	unRegistro assertReceptiveAccountIsNotIncludedIn: self forPortfolio: portfolio. ! !


!ReceptiveAccount methodsFor: 'accessing' stamp: 'a 5/22/2023 12:46:28'!
contributeToTransactions: totalTransactions 
	totalTransactions addAll: transactions! !
