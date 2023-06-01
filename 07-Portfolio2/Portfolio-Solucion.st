!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'TB 5/31/2023 14:55:43'!
test16PortfolioCanHaveName

	self assert: 'Portfolio de prueba' equals: (Portfolio named: 'Portfolio de prueba' with: ReceptiveAccount new with: ReceptiveAccount new) name.! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TB 5/31/2023 14:53:26'!
test08ReceptiveAccountCanHaveName

	self assert: 'Cuenta de prueba' equals: (ReceptiveAccount named: 'Cuenta de prueba') name.
! !


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'testing' stamp: 'TB 6/1/2023 15:05:10'!
test01EmptyAccountHasEmptyAccountSummary

	self assert: self emptyAccountAccountSummary equals: (AccountSummary of: ReceptiveAccount new) value first.! !

!ReportTest methodsFor: 'testing' stamp: 'TB 5/30/2023 12:52:35'!
test02ReceptiveAccountWithOneOfEachTransactionHasCorrectAccountSummary

	| account |
	account := ReceptiveAccount new.
	Deposit register: 10 on: account.
	Withdraw register: 5 on: account.
	Transfer register: 1 from: account to: ReceptiveAccount new.
	Transfer register: 1 from: ReceptiveAccount new to: account.
	
	self assert: (OrderedCollection 
		with: 'Deposito por 10.'
		with: 'Extraccion por 5.'
		with: 'Salida por transferencia de 1.'
		with: 'Entrada por transferencia de 1.'
		with: 'Balance = 5') equals: (AccountSummary of: account) value.! !

!ReportTest methodsFor: 'testing' stamp: 'TB 5/30/2023 12:52:48'!
test03ReceptiveAccountWithMultiplesOfEachTransactionHasCorrectAccountSummary

	| account expectedSummary |
	account := ReceptiveAccount new.
	Deposit register: 10 on: account.
	Withdraw register: 5 on: account.
	Deposit register: 10 on: account.
	Transfer register: 1 from: account to: ReceptiveAccount new.
	Withdraw register: 5 on: account.
	Transfer register: 1 from: ReceptiveAccount new to: account.
	Transfer register: 1 from: ReceptiveAccount new to: account.
	Transfer register: 1 from: account to: ReceptiveAccount new.
	
	expectedSummary := 	OrderedCollection 
		with: 'Deposito por 10.'
		with: 'Extraccion por 5.'
		with: 'Deposito por 10.'
		with: 'Salida por transferencia de 1.'
		with: 'Extraccion por 5.'
		with: 'Entrada por transferencia de 1.'.
		
	expectedSummary add: 'Entrada por transferencia de 1.'.
	expectedSummary add: 'Salida por transferencia de 1.'.
	expectedSummary add: 'Balance = 10'.
	
	self assert: expectedSummary equals: (AccountSummary of: account) value.! !

!ReportTest methodsFor: 'testing' stamp: 'TB 6/1/2023 15:05:10'!
test04EmptyPortfolioHasEmptyAccountSummary

	self assert: self emptyAccountAccountSummary equals: (AccountSummary of: Portfolio new) value first.! !

!ReportTest methodsFor: 'testing' stamp: 'TB 6/1/2023 15:08:46'!
test05PortfolioWithOneAccountHasCorrectSummary
	
	| portfolio |
	portfolio := self portfolioConCuentaHija: [:account | Deposit register: 5 on: account].
	
	self assert: (OrderedCollection with: 'Deposito por 5.' with: 'Balance = 5') 
		equals: (AccountSummary of: portfolio) value.! !

!ReportTest methodsFor: 'testing' stamp: 'TB 6/1/2023 15:09:35'!
test06PortfolioWithOneAccountAndOnePortfolioHasCorrectSummary
	| portfolioHijo portfolioPadre |
	
	portfolioHijo := self portfolioConCuentaHija: [:account | Deposit register: 5 on: account].
	
	portfolioPadre := self portfolioConCuentaHija: [:account | Withdraw register: 2 on: account].
	portfolioPadre add: portfolioHijo.
	
	self assert: (OrderedCollection with: 'Extraccion por 2.' with: 'Deposito por 5.' with: 'Balance = 3') equals: (AccountSummary of: portfolioPadre) value.! !

!ReportTest methodsFor: 'testing' stamp: 'TB 5/30/2023 13:06:11'!
test07EmptyAccountHasZeroTransferNet
		
	self assert: 0 equals: (TransferNet of: ReceptiveAccount new) value.! !

!ReportTest methodsFor: 'testing' stamp: 'TB 5/30/2023 13:06:22'!
test08AccountWithOneIncomingTransferHasPositiveTransferNet

	| account |
	account := ReceptiveAccount new.
	Transfer register: 5 from: ReceptiveAccount new to: account.
	self assert: 5 equals: (TransferNet of: account) value.! !

!ReportTest methodsFor: 'testing' stamp: 'TB 5/30/2023 13:06:31'!
test09AccountWithOneOutgoingTransferHasNegativeTransferNet

	| account |
	account := ReceptiveAccount new.
	Transfer register: 5 from: account to: ReceptiveAccount new.
	self assert: -5 equals: (TransferNet of: account) value.! !

!ReportTest methodsFor: 'testing' stamp: 'TB 5/30/2023 13:06:40'!
test10AccountWithMultipleTransferHasCorrespondingTransferNet

	| account |
	account := ReceptiveAccount new.
	Transfer register: 3 from: account to: ReceptiveAccount new.
	Transfer register: 5 from: ReceptiveAccount new to: account.
	self assert: 2 equals: (TransferNet of: account) value.! !

!ReportTest methodsFor: 'testing' stamp: 'TB 5/30/2023 13:06:49'!
test11EmptyPortfolioHasZeroTransferNet

	self assert: 0 equals: (TransferNet of: Portfolio new) value.! !

!ReportTest methodsFor: 'testing' stamp: 'TB 6/1/2023 15:12:07'!
test12PortfolioWithOneAccountHasAccountsTransferNet

	| portfolio |
	portfolio := self portfolioConCuentaHijaYTransferenciaDe: 5.
	
	self assert: 5 equals: (TransferNet of: portfolio) value.! !

!ReportTest methodsFor: 'testing' stamp: 'TB 6/1/2023 15:12:50'!
test13PortfolioWithOneAccountAndOnePortfolioHasSumOfTransferNets
	| portfolioHijo portfolioPadre |
	
	portfolioHijo := self portfolioConCuentaHijaYTransferenciaDe: 5.
	
	portfolioPadre := self portfolioConCuentaHija: [:account | Transfer register: 2 from: account to: ReceptiveAccount new].
	portfolioPadre add: portfolioHijo.
	
	self assert: 3 equals: (TransferNet of: portfolioPadre) value.! !

!ReportTest methodsFor: 'testing' stamp: 'TB 6/1/2023 15:14:22'!
test14EmptyPortfolioHasItselfAsStructure

	self assert: (OrderedCollection with: 'Portfolio de prueba') equals: (PortfolioStructure of: self portfolioConNombre) value.! !

!ReportTest methodsFor: 'testing' stamp: 'TB 6/1/2023 15:17:26'!
test15PortfolioWithAccountPrintsStructureCorrectly

	| cuenta |
	cuenta := self cuentaConNombre.
	self assert: (OrderedCollection with: 'Portfolio de prueba' with: Character tab asString, 'Cuenta de prueba') 
		equals: (PortfolioStructure of: (self portfolioConNombreEHijo: cuenta)) value.! !

!ReportTest methodsFor: 'testing' stamp: 'TB 6/1/2023 15:18:42'!
test16PortfolioWithAccountAndPortfolioWithAccountPrintsStructureCorrectly

	| portfolioHijo cuentaHija portfolio |
	cuentaHija := ReceptiveAccount named: 'Cuenta hija'.
	portfolioHijo := Portfolio named: 'Un portfolio hijo' with: cuentaHija.
	
	portfolio := self portfolioConNombreEHijo: portfolioHijo.
	portfolio add: self cuentaConNombre.
	
	self assert: (OrderedCollection 
				with: 'Portfolio de prueba' 
				with: Character tab asString, 'Un portfolio hijo'
				with: Character tab asString, Character tab asString, 'Cuenta hija'
				with: Character tab asString, 'Cuenta de prueba') 			
	       equals: (PortfolioStructure of: portfolio) value.! !

!ReportTest methodsFor: 'testing' stamp: 'TB 6/1/2023 15:31:09'!
test17EmptyPortfolioHasEmptyPortfolioSummary

	self assert: (OrderedCollection with: 'Portfolio de prueba' with: Character tab asString, 'Balance = 0') equals: self portfolioConNombre portfolioSummary.! !

!ReportTest methodsFor: 'testing' stamp: 'TB 6/1/2023 15:39:39'!
test18PortfolioConCuentaSeDescribeEnPortfolioSummary
	| portfolio hijo |
	
	hijo := self cuentaConNombre.
	Deposit register: 5 on: hijo.
	portfolio := self portfolioConNombreEHijo: hijo.

	self assert: (OrderedCollection 
				with: 'Portfolio de prueba'
				with: Character tab asString, 'Cuenta de prueba'
				with: Character tab asString, Character tab asString, 'Deposito por 5.'
				with: Character tab asString, Character tab asString, 'Balance = 5'
		 		with: Character tab asString, 'Balance = 5') 
		equals: portfolio portfolioSummary.! !

!ReportTest methodsFor: 'testing' stamp: 'TB 6/1/2023 16:10:42'!
test19PortfolioConCuentaYPortfolioHijoSeDescribeEnPortfolioSummary
	| portfolio cuentaHija cuentaNieta portfolioHijo expectedResult |
	
	cuentaNieta := ReceptiveAccount named: 'cuenta nieta'.
	Withdraw register: 3 on: cuentaNieta.
	portfolioHijo := Portfolio named: 'portfolio hijo'.
	portfolioHijo add: cuentaNieta.
	
	cuentaHija := self cuentaConNombre.
	Deposit register: 5 on: cuentaHija.	

	portfolio := self portfolioConNombreEHijo: cuentaHija.
	portfolio add: portfolioHijo.
	
	expectedResult := (OrderedCollection 
				with: 'Portfolio de prueba'
				with: Character tab asString, 'Cuenta de prueba'
				with: Character tab asString, Character tab asString, 'Deposito por 5.'
				with: Character tab asString, Character tab asString, 'Balance = 5'
				with: Character tab asString, 'portfolio hijo'
				with: Character tab asString, Character tab asString, 'cuenta nieta').
				
	expectedResult add: Character tab asString, Character tab asString, Character tab asString, 'Extraccion por 3.'.
	expectedResult add: Character tab asString, Character tab asString, Character tab asString, 'Balance = -3'.
	expectedResult add: Character tab asString, Character tab asString, 'Balance = -3'.	
	expectedResult add: Character tab asString, 'Balance = 2'.
	
	self assert: expectedResult 		equals: (PortfolioSummary of: portfolio) value.! !


!ReportTest methodsFor: 'constants' stamp: 'TB 6/1/2023 15:17:26'!
cuentaConNombre

	^ ReceptiveAccount named: 'Cuenta de prueba'! !

!ReportTest methodsFor: 'constants' stamp: 'TB 6/1/2023 15:05:10'!
emptyAccountAccountSummary

	^ 'Balance = 0'! !

!ReportTest methodsFor: 'constants' stamp: 'TB 6/1/2023 15:08:19'!
portfolioConCuentaHija: aBlockToRunOnChildAccount
	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	aBlockToRunOnChildAccount value: account.
	
	portfolio add: account.
	^portfolio! !

!ReportTest methodsFor: 'constants' stamp: 'TB 6/1/2023 15:11:55'!
portfolioConCuentaHijaYTransferenciaDe: unValor

	^self portfolioConCuentaHija: [:account | Transfer register: unValor from: ReceptiveAccount new to: account]! !

!ReportTest methodsFor: 'constants' stamp: 'TB 6/1/2023 15:14:14'!
portfolioConNombre

	^Portfolio named: 'Portfolio de prueba'! !

!ReportTest methodsFor: 'constants' stamp: 'TB 6/1/2023 15:18:26'!
portfolioConNombreEHijo: unHijo

	^self portfolioConNombre add: unHijo! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'testing' stamp: 'TB 5/28/2023 18:47:54'!
test01TransferAffectsAccountBalances

	| sourceAccount destinationAccount |
	sourceAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	Transfer register: 5 from: sourceAccount to: destinationAccount.
	
	self assert: 5 equals: destinationAccount balance.
	self assert: -5 equals: sourceAccount balance.! !

!TransferTest methodsFor: 'testing' stamp: 'TB 5/28/2023 18:47:54'!
test02SourceAccountHasTransferWithdrawRegistered

	| sourceAccount transfer |
	sourceAccount := ReceptiveAccount new.
	transfer := Transfer register: 5 from: sourceAccount to: ReceptiveAccount new.
	
	self assert: (sourceAccount hasRegistered: transfer withdrawal).! !

!TransferTest methodsFor: 'testing' stamp: 'TB 5/28/2023 18:47:54'!
test03DestinationAccountHasTransferDepositRegistered

	| destinationAccount transfer |
	destinationAccount := ReceptiveAccount new.
	transfer := Transfer register: 5 from: ReceptiveAccount new to: destinationAccount .
	
	self assert: (destinationAccount hasRegistered: transfer deposit).! !

!TransferTest methodsFor: 'testing' stamp: 'TB 6/1/2023 15:21:41'!
test04TransferDepositCanAccessTheTransfer

	| transfer |
	transfer := self transferOf5.
	self assert: transfer equals: transfer deposit transfer.! !

!TransferTest methodsFor: 'testing' stamp: 'TB 6/1/2023 15:22:02'!
test05TransferWithdrawalCanAccessTheTransfer

	| transfer |
	transfer := self transferOf5.
	self assert: transfer equals: transfer withdrawal transfer.! !

!TransferTest methodsFor: 'testing' stamp: 'TB 6/1/2023 15:19:38'!
transferOf5

	^ Transfer register: 5 from: ReceptiveAccount new to: ReceptiveAccount new! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'reports' stamp: 'TB 5/31/2023 15:25:10'!
informTransactionReport: aReport

	self subclassResponsibility ! !


!Account methodsFor: 'name' stamp: 'TB 5/31/2023 14:58:47'!
name

	^name! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'TB 5/31/2023 14:57:00'!
initializeNamed: aName
	
	name := aName.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reports' stamp: 'TB 5/31/2023 15:29:36'!
contributeToAccountReport: anAccountReport

	anAccountReport contributeWithPortfolio: self! !

!Portfolio methodsFor: 'reports' stamp: 'TB 5/31/2023 15:28:08'!
informAccountReport: anAccountReport 
	
	accounts do: [:account | account contributeToAccountReport: anAccountReport].! !

!Portfolio methodsFor: 'reports' stamp: 'TB 5/31/2023 15:25:10'!
informTransactionReport: anAccountSummary

	accounts do: [ :cuenta | cuenta informTransactionReport: anAccountSummary ]! !

!Portfolio methodsFor: 'reports' stamp: 'TB 6/1/2023 15:59:50'!
portfolioSummary
	
	| summary |
	summary := OrderedCollection with: name.
	accounts do: [:account | 
		(account isKindOf: ReceptiveAccount) ifTrue: [			
			summary add: Character tab asString, account name.
			(AccountSummary of: account) value do: [ :summaryLine |
				summary add: Character tab asString, Character tab asString, summaryLine 
			]
		].
	
		(account isKindOf: Portfolio) ifTrue: [
			account portfolioSummary do: [				:summaryLine |
				summary add: Character tab asString, summaryLine
			]
		].
	].
	
	summary add: Character tab asString, 'Balance = ', self balance asString.
	^summary! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'TB 5/31/2023 15:05:56'!
named: aName 
	
	^self new initializeNamed: aName ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'TB 5/31/2023 15:08:12'!
named: aName with: anAccount 
	
	^self new initializeNamed: aName;
		add: anAccount;
		yourself.! !

!Portfolio class methodsFor: 'instance creation' stamp: 'TB 5/31/2023 14:57:26'!
named: aName with: anAccount with: anotherAccount 
	
	^self new initializeNamed: aName;
		add: anAccount;
		add: anotherAccount;
		yourself.! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'TB 5/31/2023 14:52:37'!
initializeNamed: aName 
	
	name := aName.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'a 5/29/2023 20:29:54'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !



!ReceptiveAccount methodsFor: 'reports' stamp: 'TB 5/31/2023 15:29:42'!
contributeToAccountReport: anAccountReport

	anAccountReport contributeWithReceptiveAccount: self.! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'TB 5/31/2023 15:27:44'!
informTransactionReport: anAccountSummary
	
	transactions do: [ :transaction | 		transaction contributeToTransctionReport: anAccountSummary 	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'TB 5/31/2023 14:52:45'!
named: aName 
	
	^self new initializeNamed: aName ! !


!classDefinition: #AccountReport category: 'Portfolio-Solucion'!
Object subclass: #AccountReport
	instanceVariableNames: 'account report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReport methodsFor: 'double dispatch' stamp: 'TB 6/1/2023 15:02:01'!
contributeWithPortfolio: aPortfolio

	self subclassResponsibility! !

!AccountReport methodsFor: 'double dispatch' stamp: 'TB 6/1/2023 15:02:04'!
contributeWithReceptiveAccount: aReceptiveAccount

	self subclassResponsibility! !


!AccountReport methodsFor: 'initialization' stamp: 'TB 6/1/2023 15:01:40'!
initializeOf: anAccount

	account := anAccount ! !


!AccountReport methodsFor: 'evaluating' stamp: 'TB 6/1/2023 15:02:08'!
value

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReport class' category: 'Portfolio-Solucion'!
AccountReport class
	instanceVariableNames: ''!

!AccountReport class methodsFor: 'as yet unclassified' stamp: 'TB 5/31/2023 15:22:22'!
of: aPortfolio

	^self new initializeOf: aPortfolio ! !


!classDefinition: #PortfolioStructure category: 'Portfolio-Solucion'!
AccountReport subclass: #PortfolioStructure
	instanceVariableNames: 'currentIndentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioStructure methodsFor: 'modifying - private' stamp: 'TB 6/1/2023 15:01:51'!
addToReport: anAccount

	report add: currentIndentation, anAccount name.	! !

!PortfolioStructure methodsFor: 'modifying - private' stamp: 'TB 6/1/2023 15:02:11'!
withIncreasedIndent: aBlock

	currentIndentation := currentIndentation, Character tab asString.
	aBlock value.
	currentIndentation := currentIndentation allButLast! !


!PortfolioStructure methodsFor: 'double dispatch' stamp: 'TB 6/1/2023 15:02:01'!
contributeWithPortfolio: aPortfolio

	self addToReport: aPortfolio.
	self withIncreasedIndent: [		
		aPortfolio informAccountReport: self.
	].! !

!PortfolioStructure methodsFor: 'double dispatch' stamp: 'TB 6/1/2023 15:02:04'!
contributeWithReceptiveAccount: aReceptiveAccount

	self addToReport: aReceptiveAccount.! !


!PortfolioStructure methodsFor: 'evaluating' stamp: 'TB 6/1/2023 15:02:08'!
value

	currentIndentation := ''.
	report := OrderedCollection new.
	self contributeWithPortfolio: account.
	
	^report! !


!classDefinition: #PortfolioSummary category: 'Portfolio-Solucion'!
AccountReport subclass: #PortfolioSummary
	instanceVariableNames: 'currentIndentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioSummary methodsFor: 'double dispatch' stamp: 'TB 6/1/2023 16:14:24'!
contributeWithPortfolio: aPortfolio

	self addToReport: aPortfolio name.
	self withIncreasedIndent: [
		aPortfolio informAccountReport: self.		
		self addToReport: 'Balance = ', aPortfolio balance asString.
	].
	! !

!PortfolioSummary methodsFor: 'double dispatch' stamp: 'TB 6/1/2023 16:12:34'!
contributeWithReceptiveAccount: aReceptiveAccount

	self addToReport: aReceptiveAccount name.
	self withIncreasedIndent: [
		(AccountSummary of: aReceptiveAccount) value do: [:summaryLine | self addToReport: summaryLine].
	].! !


!PortfolioSummary methodsFor: 'evaluating' stamp: 'TB 6/1/2023 16:05:41'!
value

	currentIndentation := ''.
	report := OrderedCollection new.
	
	self contributeWithPortfolio: account.
	
	^report! !


!PortfolioSummary methodsFor: 'as yet unclassified' stamp: 'TB 6/1/2023 16:08:10'!
addToReport: aString

	report add: currentIndentation, aString! !

!PortfolioSummary methodsFor: 'as yet unclassified' stamp: 'TB 6/1/2023 16:09:42'!
withIncreasedIndent: aBlock

	currentIndentation := currentIndentation, Character tab asString.
	aBlock value.
	currentIndentation := currentIndentation allButLast! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reports' stamp: 'TB 5/31/2023 15:27:44'!
contributeToTransctionReport: aSummary

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reports' stamp: 'TB 5/31/2023 15:27:44'!
contributeToTransctionReport: anAccountSummary

	anAccountSummary contributeWithDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferTransaction category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTransaction methodsFor: 'initialization' stamp: 'TB 5/30/2023 12:31:06'!
initializeFor: aTransfer

	transfer := aTransfer .! !


!TransferTransaction methodsFor: 'accessing' stamp: 'TB 5/28/2023 17:49:19'!
transfer

	^transfer
! !


!TransferTransaction methodsFor: 'balance' stamp: 'TB 5/30/2023 12:33:04'!
affectBalance: aBalanceToAffect

	self subclassResponsibility! !


!TransferTransaction methodsFor: 'value' stamp: 'TB 5/30/2023 12:31:19'!
value

	^transfer value! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: 'Portfolio-Solucion'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'instance creation' stamp: 'TB 5/30/2023 12:34:33'!
for: aTransfer

	^self new initializeFor: aTransfer! !


!classDefinition: #TransferDeposit category: 'Portfolio-Solucion'!
TransferTransaction subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'reports' stamp: 'TB 5/31/2023 15:27:44'!
contributeToTransctionReport: anAccountSummary

	anAccountSummary contributeWithTransferDeposit: self.! !



!TransferDeposit methodsFor: 'balance' stamp: 'TB 5/30/2023 12:33:32'!
affectBalance: aBalanceToAffect

	^aBalanceToAffect + transfer value! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Solucion'!
TransferTransaction subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'reports' stamp: 'TB 5/31/2023 15:27:44'!
contributeToTransctionReport: anAccountSummary

	anAccountSummary contributeWithTransferWithdraw: self.! !



!TransferWithdraw methodsFor: 'balance' stamp: 'TB 5/30/2023 12:33:43'!
affectBalance: aBalanceToAffect

	^aBalanceToAffect - transfer value! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reports' stamp: 'TB 5/31/2023 15:27:44'!
contributeToTransctionReport: anAccountSummary

	anAccountSummary contributeWithWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransactionReport category: 'Portfolio-Solucion'!
Object subclass: #TransactionReport
	instanceVariableNames: 'account report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransactionReport methodsFor: 'initialization' stamp: 'TB 5/30/2023 13:09:22'!
initializeOf: anAccount

	account := anAccount ! !


!TransactionReport methodsFor: 'evaluating' stamp: 'TB 5/30/2023 13:12:29'!
value

	self subclassResponsibility ! !


!TransactionReport methodsFor: 'double dispatch' stamp: 'TB 5/30/2023 13:11:02'!
contributeWithDeposit: aDeposit

	self subclassResponsibility! !

!TransactionReport methodsFor: 'double dispatch' stamp: 'TB 5/30/2023 13:11:18'!
contributeWithTransferDeposit: aTransferDeposit

	self subclassResponsibility! !

!TransactionReport methodsFor: 'double dispatch' stamp: 'TB 5/30/2023 13:11:22'!
contributeWithTransferWithdraw: aTransferWithdraw

	self subclassResponsibility! !

!TransactionReport methodsFor: 'double dispatch' stamp: 'TB 5/30/2023 13:11:24'!
contributeWithWithdraw: aWithdraw

	self subclassResponsibility! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
TransactionReport subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'double dispatch' stamp: 'TB 5/30/2023 13:11:10'!
contributeWithDeposit: aDeposit
	
	report add: 'Deposito por ', aDeposit value asString, '.'.! !

!AccountSummary methodsFor: 'double dispatch' stamp: 'TB 5/30/2023 13:11:35'!
contributeWithTransferDeposit: aTransferDeposit
	
	report add: 'Entrada por transferencia de ', aTransferDeposit transfer value asString, '.'.! !

!AccountSummary methodsFor: 'double dispatch' stamp: 'TB 5/30/2023 13:11:40'!
contributeWithTransferWithdraw: aTransferWithdraw
	
	report add: 'Salida por transferencia de ', aTransferWithdraw transfer value asString, '.'.! !

!AccountSummary methodsFor: 'double dispatch' stamp: 'TB 5/30/2023 13:11:42'!
contributeWithWithdraw: aWithdraw
	
	report add: 'Extraccion por ', aWithdraw value asString, '.'.! !


!AccountSummary methodsFor: 'evaluating' stamp: 'TB 5/31/2023 15:25:10'!
value

	report := OrderedCollection new.
	account informTransactionReport: self.
		
	report add: 'Balance = ', account balance asString.
	^report ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'TB 5/30/2023 12:38:17'!
of: anAccount

	^self new initializeOf: anAccount! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
TransactionReport subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'double dispatch' stamp: 'TB 5/30/2023 13:14:14'!
contributeWithDeposit: aDeposit! !

!TransferNet methodsFor: 'double dispatch' stamp: 'TB 5/30/2023 13:14:43'!
contributeWithTransferDeposit: aTransferDeposit

	report := report + aTransferDeposit value.! !

!TransferNet methodsFor: 'double dispatch' stamp: 'TB 5/30/2023 13:15:02'!
contributeWithTransferWithdraw: aTransferWithdraw

	report := report - aTransferWithdraw value.! !

!TransferNet methodsFor: 'double dispatch' stamp: 'TB 5/30/2023 13:15:11'!
contributeWithWithdraw: aWithdraw! !


!TransferNet methodsFor: 'evaluating' stamp: 'TB 5/31/2023 15:25:10'!
value

	report := 0.	
	account informTransactionReport: self.	
	^report.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'TB 5/30/2023 12:57:04'!
of: anAccount

	^self new initializeOf: anAccount! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'withdrawal deposit value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'TB 5/30/2023 12:32:53'!
initializeRegister: anAmountToTransfer from: aSource to: aDestination

	value := anAmountToTransfer.
	withdrawal := TransferWithdraw register: self on: aSource.
	deposit := TransferDeposit register: self on: aDestination.! !


!Transfer methodsFor: 'accessing' stamp: 'TB 5/23/2023 10:31:42'!
deposit
	^deposit! !

!Transfer methodsFor: 'accessing' stamp: 'TB 5/30/2023 12:32:44'!
value
	^value! !

!Transfer methodsFor: 'accessing' stamp: 'TB 5/28/2023 18:01:54'!
withdrawal
	^withdrawal! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'TB 5/28/2023 18:47:54'!
register: anAmountToTransfer from: aSource to: aDestination

	^self new initializeRegister: anAmountToTransfer from: aSource to: aDestination ! !
