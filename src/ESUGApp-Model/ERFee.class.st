"
Description
--------------------

I am a model of Fee
"
Class {
	#name : #ERFee,
	#superclass : #ESUGActiveRecord,
	#instVars : [
		'currency',
		'erfAllDaysFee',
		'erfOneDayFee',
		'lrfAllDaysFee',
		'lrfOneDayFee',
		'bankAccountInformation',
		'bankPayPalUrl',
		'payPalCommissionPercentage',
		'staticCommissionPaypal',
		'extraPersonSD',
		'creditCardCommissionPercentage'
	],
	#category : #'ESUGApp-Model'
}

{ #category : #accessing }
ERFee >> bankAccountInformation [
	^ bankAccountInformation
]

{ #category : #accessing }
ERFee >> bankAccountInformation: anObject [
	bankAccountInformation := anObject
]

{ #category : #accessing }
ERFee >> bankPayPalUrl [
	^ bankPayPalUrl
]

{ #category : #accessing }
ERFee >> bankPayPalUrl: anObject [
	bankPayPalUrl := anObject
]

{ #category : #accessing }
ERFee >> creditCardCommissionPercentage [

	^ creditCardCommissionPercentage
]

{ #category : #accessing }
ERFee >> creditCardCommissionPercentage: anObject [

	creditCardCommissionPercentage := anObject
]

{ #category : #accessing }
ERFee >> currency [
	^ currency
]

{ #category : #accessing }
ERFee >> currency: anObject [
	currency := anObject
]

{ #category : #'magrittes-descriptions' }
ERFee >> descriptionBankPayPalUrl [
	<magritteDescription>
	| tmp |
	tmp := MAStringDescription new.
	tmp 
		accessor: #bankPayPalUrl; 
		priority: 70;
		beRequired;
		label: 'Credit Card URL (Required)';
		withoutLabel: true;
		id: 'bankPayPalUrl';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERFee >> descriptionCreditCardCommissionPercentage [
	<magritteDescription>
	| tmp |
	tmp := MANumberDescription new.
	tmp 
		accessor: #creditCardCommissionPercentage; 
		priority: 100;
		beRequired;
		label: 'Credit card Commission Percentage (Required)';
		addCondition: [ :value | value >= 0 ]
  		labelled: 'Need to be a positive number';
		withoutLabel: true;
		cssClass: 'half';
		id: 'creditCardCommissionPercentage';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERFee >> descriptionErfAllDaysFee [
	<magritteDescription>
	| tmp |
	tmp := MANumberDescription new.
	tmp 
		accessor: #erfAllDaysFee; 
		priority: 30;
		beRequired;
		group: 'Early Registration Fee:';
		label: 'All Days Fee (Required)';
		addCondition: [ :value | value >= 0 ]
  		labelled: 'Need to be a positive number';
		withoutLabel: true;
		cssClass: 'half';
		id: 'erfAllDaysFee';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERFee >> descriptionErfOneDayFee [
	<magritteDescription>
	| tmp |
	tmp := MANumberDescription new.
	tmp 
		accessor: #erfOneDayFee; 
		priority: 40;
		beRequired;
		label: 'One Day Fee (Required)';
		addCondition: [ :value | value >= 0 ]
  		labelled: 'Need to be a positive number';
		withoutLabel: true;
		cssClass: 'half';
		id: 'erfOneDayFee';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERFee >> descriptionExtraPersonSD [
	<magritteDescription>
	| tmp |
	tmp := MANumberDescription new.
	tmp 
		accessor: #extraPersonSD; 
		priority: 20;
		beRequired;
		label: 'Price for add person to the Social Dinner (Required)';
		addCondition: [ :value | value >= 0 ]
  		labelled: 'Need to be a positive number';
		withoutLabel: true;
		cssClass: 'half';
		id: 'extraPersonSD';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERFee >> descriptionLrfAllDaysFee [
	<magritteDescription>
	| tmp |
	tmp := MANumberDescription new.
	tmp 
		accessor: #lrfAllDaysFee; 
		priority: 50;
		beRequired;
		group: 'Late Registration Fee:';
		label: 'All Days Fee (Required)';
		addCondition: [ :value | value >= 0 ]
  		labelled: 'Need to be a positive number';
		withoutLabel: true;
		cssClass: 'half';
		id: 'lrfAllDaysFee';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERFee >> descriptionLrfOneDayFee [
	<magritteDescription>
	| tmp |
	tmp := MANumberDescription new.
	tmp 
		accessor: #lrfOneDayFee; 
		priority: 60;
		beRequired;
		label: 'One Day Fee (Required)';
		addCondition: [ :value | value >= 0 ]
  		labelled: 'Need to be a positive number';
		withoutLabel: true;
		cssClass: 'half';
		id: 'lrfOneDayFee';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERFee >> descriptionPayPalCommissionPercentage [
	<magritteDescription>
	| tmp |
	tmp := MANumberDescription new.
	tmp 
		accessor: #payPalCommissionPercentage; 
		priority: 80;
		beRequired;
		label: 'Credit Card Commission Percentage (Required)';
		addCondition: [ :value | value >= 0 ]
  		labelled: 'Need to be a positive number';
		withoutLabel: true;
		cssClass: 'half';
		id: 'payPalCommissionPercentage';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #'magrittes-descriptions' }
ERFee >> descriptionPaymentCurrency [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #currency;
		priority: 10;
		beRequired;
		options: ERPaymentInformation currencyTypes;
		cssClass: 'half';
		withoutLabel: true;
		id: 'currency';
		componentClass: MDLMASelectListComponent .
	^ tmp1 yourself
]

{ #category : #'magrittes-descriptions' }
ERFee >> descriptionStaticPayPalCommission [
	<magritteDescription>
	| tmp |
	tmp := MANumberDescription new.
	tmp 
		accessor: #staticCommissionPaypal; 
		priority: 90;
		beRequired;
		label: 'Static Commission Credit Card (Required)';
		addCondition: [ :value | value >= 0 ]
  		labelled: 'Need to be a positive number';
		withoutLabel: true;
		cssClass: 'half';
		id: 'staticCommissionPaypal';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERFee >> erfAllDaysFee [
	^ erfAllDaysFee
]

{ #category : #accessing }
ERFee >> erfAllDaysFee: anObject [
	erfAllDaysFee := anObject
]

{ #category : #accessing }
ERFee >> erfOneDayFee [
	^ erfOneDayFee
]

{ #category : #accessing }
ERFee >> erfOneDayFee: anObject [
	erfOneDayFee := anObject
]

{ #category : #accessing }
ERFee >> extraPersonSD [
	^ extraPersonSD
]

{ #category : #accessing }
ERFee >> extraPersonSD: anObject [
	extraPersonSD := anObject
]

{ #category : #initialization }
ERFee >> initialize [
	super initialize.
	bankAccountInformation := ERBankAccountInformation new.
	
]

{ #category : #accessing }
ERFee >> lrfAllDaysFee [
	^ lrfAllDaysFee
]

{ #category : #accessing }
ERFee >> lrfAllDaysFee: anObject [
	lrfAllDaysFee := anObject
]

{ #category : #accessing }
ERFee >> lrfOneDayFee [
	^ lrfOneDayFee
]

{ #category : #accessing }
ERFee >> lrfOneDayFee: anObject [
	lrfOneDayFee := anObject
]

{ #category : #'accesing-tokens' }
ERFee >> payPalAmountToken [
	^ '[AMOUNT]'
]

{ #category : #accessing }
ERFee >> payPalCommissionPercentage [
	^ payPalCommissionPercentage 
]

{ #category : #accessing }
ERFee >> payPalCommissionPercentage: anObject [
	payPalCommissionPercentage := anObject
]

{ #category : #'accesing-tokens' }
ERFee >> payPalInvoiceNumberToken [
	
	^ '[INVOICENUMBER]'
]

{ #category : #accessing }
ERFee >> staticCommissionPaypal [
	^ staticCommissionPaypal 
]

{ #category : #accessing }
ERFee >> staticCommissionPaypal: anObject [
	staticCommissionPaypal := anObject
]

{ #category : #accessing }
ERFee >> urlWithAmount: aString1 invoiceNumber: aString2 [
	|url|
	url := self bankPayPalUrl.
	url := url
		copyReplaceAll: self payPalAmountToken
		with: aString1.
	url := url
		copyReplaceAll: self payPalInvoiceNumberToken
		with: aString2.
	^ url
]
