"
Description
--------------------

I am a factory of some components like: ERContentTab with content of magritte forms and fields of password
"
Class {
	#name : #ERComponentFactory,
	#superclass : #WAComponent,
	#instVars : [
		'attendee',
		'conference'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #'instance creation' }
ERComponentFactory class >> on: anAttendee [
	| form |
	form := self new.
	form attendee: anAttendee.
	^ form
]

{ #category : #accessing }
ERComponentFactory >> attendee [
	^ attendee
]

{ #category : #accessing }
ERComponentFactory >> attendee: anObject [
	attendee := anObject
]

{ #category : #accessing }
ERComponentFactory >> conference [

	^ conference
]

{ #category : #accessing }
ERComponentFactory >> conference: anObject [

	conference := anObject
]

{ #category : #factoryFormMethods }
ERComponentFactory >> createAdditionalInfoTab: anAttendee withContent: aContent [
	
	^ ERContentTab new 
	 contentTab: (self createAdditionalInformationComponent: anAttendee);
			attendee: anAttendee;
			 tabId: 'additionalInfoForm'; 
			 tabName: 'Additional';
			 container: aContent;
			previousTabName: 'Billing Information';
			nextTabName: 'Payment'
]

{ #category : #factoryFormMethods }
ERComponentFactory >> createAdditionalInformationComponent: anAttendee [
	
	^ self createFormOf: anAttendee additionalInformation
]

{ #category : #factoryFormMethods }
ERComponentFactory >> createBasicInfoTab: anAttendee withContent: aContent [
	^ ERContentTab new 
		contentTab: (self createBasicInformationComponent: anAttendee);
			 attendee: anAttendee;
			 tabId: 'basicInfoForm'; 
			 tabName: 'User';
			 container: aContent;
			nextTabName: 'Contact'
]

{ #category : #factoryFormMethods }
ERComponentFactory >> createBasicInformationComponent: anAttendee [
	^ self createFormOf: ((anAttendee userAccount) 
	as: ERUserAccountForRegister)
]

{ #category : #factoryFormMethods }
ERComponentFactory >> createBillingInfoTab: anAttendee withContent: aContent [
	^ ERContentTab new 
		contentTab: (self createBillingInformationComponentOn: anAttendee);
			attendee: anAttendee;
			 tabId: 'affiliationInfoForm'; 
			 tabName: 'Billing Information';
			 container: aContent;
			nextTabName: 'Additional';
			previousTabName: 'Conference'
]

{ #category : #factoryFormMethods }
ERComponentFactory >> createBillingInformationComponentOn: anAttendee [
	^ self createFormOf: anAttendee affiliationInformation
]

{ #category : #factoryFormMethods }
ERComponentFactory >> createContactInfoTab: anAttendee withContent: aContent [
	^ ERContentTab new 
		contentTab: (self createContactInformationComponent: anAttendee);
			attendee: anAttendee ;
			 tabId: 'contactInfoForm'; 
			 tabName: 'Contact';
			 container: aContent;
			previousTabName: 'User';
			nextTabName: 'Conference'
]

{ #category : #factoryFormMethods }
ERComponentFactory >> createContactInformationComponent: anAttendee [
	^ self createFormOf: anAttendee contactInformation
]

{ #category : #factoryFormMethods }
ERComponentFactory >> createFormOf: anObject [
	^ anObject asComponent 
		addDecoration: MAValidationDecoration new;
		yourself.
]

{ #category : #factoryFormMethods }
ERComponentFactory >> createPaymentInfoTab: anAttendee withContent: aContent [

	^ ERContentTab new
		contentTab: (self createPaymentInformationComponent: anAttendee);
		previousContentTab: self paymentInformationDescription;
		attendee: anAttendee;
		tabId: 'paymentInformationForm';
		tabName: 'Payment';
		container: aContent;
		nextTabName: 'Done';
		previousTabName: 'Additional'
]

{ #category : #factoryFormMethods }
ERComponentFactory >> createPaymentInfoTab: anAttendee withContent: aContent andConference: aConference [
	
	self conference: aConference.

	^ ERContentTab new
		contentTab: (self createPaymentInformationComponent: anAttendee);
		previousContentTab: self paymentInformationDescription;
		attendee: anAttendee;
		tabId: 'paymentInformationForm';
		tabName: 'Payment';
		container: aContent;
		nextTabName: 'Done';
		previousTabName: 'Additional'
]

{ #category : #factoryFormMethods }
ERComponentFactory >> createPaymentInformationComponent: anAttendee [
	^ self createFormOf: anAttendee paymentInformation 
]

{ #category : #factoryFormMethods }
ERComponentFactory >> createRegConferenceInfoTab: anAttendee withContent: aContent [
	^ ERContentTab new 
			contentTab: (self createRegConferenceInformationComponent: anAttendee);
			attendee: anAttendee ;
			 tabId: 'conferenceOptionsForm'; 
			 tabName: 'Conference';
			 container: aContent;
			nextTabName: 'Billing Information';
			previousTabName: 'Contact'.
]

{ #category : #factoryFormMethods }
ERComponentFactory >> createRegConferenceInformationComponent: anAttendee [
	^ self createFormOf: anAttendee conferenceInformation
]

{ #category : #factoryFormMethods }
ERComponentFactory >> creditCardCommission [

	^ self conference fee creditCardCommissionPercentage * 100
]

{ #category : #factoryFormMethods }
ERComponentFactory >> paymentInformationDescription [

	self creditCardCommission isZero 
		ifTrue: [ '<br><p>Pay by transfer or by card. Pay in euros.</p>
      <p><strong>IMPORTANT: Bank transfer should mention "ESUG" & the registrant name(s) as comment (e.g "Esug John Johnson")</strong></p>
      <p>Use the inter-country IBAN / BIC data (may need to ask your bank to process he payment)</p>' ].
	
	^ '<br><p>Pay by transfer or by card. Pay in euros. Credit card implies additional fee of '
	  , self creditCardCommission asString , '%</p>
      <p><strong>IMPORTANT: Bank transfer should mention "ESUG" & the registrant name(s) as comment (e.g "Esug John Johnson")</strong></p>
      <p>Use the inter-country IBAN / BIC data (may need to ask your bank to process he payment)</p>'
]
