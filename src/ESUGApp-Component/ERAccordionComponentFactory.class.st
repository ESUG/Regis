Class {
	#name : #ERAccordionComponentFactory,
	#superclass : #WAComponent,
	#instVars : [
		'attendee'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #'instance creation' }
ERAccordionComponentFactory class >> on: anAttendee [

	| form |
	
	form := self new.
	form attendee: anAttendee.
	^ form
]

{ #category : #accessing }
ERAccordionComponentFactory >> attendee: anObject [
	attendee := anObject
]

{ #category : #factoryFormMethods }
ERAccordionComponentFactory >> createAdditionalInfoTab: anAttendee withContent: aContent andClassId: anId [
	"Create a additional info tab from an attendee"
	
	^ ERAccordionContentTab new 
	 contentTab: (self createAdditionalInformationComponent: anAttendee);
			attendee: anAttendee;
			tabId: 'additionalInfoForm', (anId printString); 
			tabName: 'Additional ', (anId printString);
			classId: anId;
			container: aContent;
			previousTabName: 'Conference ', (anId printString)
]

{ #category : #factoryFormMethods }
ERAccordionComponentFactory >> createAdditionalInformationComponent: anAttendee [
	"Create a form of additional information"
	
	^ self createFormOf: anAttendee additionalInformation
]

{ #category : #factoryFormMethods }
ERAccordionComponentFactory >> createBasicInfoTab: anAttendee withContent: aContent andClassId: anId [
	"Create a basic info tab from an attendee"

	^ ERAccordionContentTab new 
		contentTab: (self createBasicInformationComponent: anAttendee);
			attendee: anAttendee;
			tabId: 'basicInfoForm', (anId printString); 
			tabName: 'User ', (anId printString);
			classId: anId;
			container: aContent;
			nextTabName: 'Conference ', (anId printString)
]

{ #category : #factoryFormMethods }
ERAccordionComponentFactory >> createBasicInformationComponent: anAttendee [
	"Create a form of user account information"
	
	^ self createFormOf: ((anAttendee userAccount) 
	as: ERUserAccountForRegister)
]

{ #category : #factoryFormMethods }
ERAccordionComponentFactory >> createFormOf: anObject [
	"Create a form of a tab"

	^ anObject asComponent 
		addDecoration: MAValidationDecoration new;
		yourself.
]

{ #category : #factoryFormMethods }
ERAccordionComponentFactory >> createRegConferenceInfoTab: anAttendee withContent: aContent andClassId: anId [
	"Create a conference registration info tab from an attendee"
	
	^ ERAccordionContentTab new 
			contentTab: (self createRegConferenceInformationComponent: anAttendee);
			attendee: anAttendee ;
			tabId: 'conferenceOptionsForm', (anId printString); 
			tabName: 'Conference ', (anId printString);
			container: aContent;
			classId: anId;
			nextTabName: 'Additional ', (anId printString);
			previousTabName: 'User ', (anId printString)
]

{ #category : #factoryFormMethods }
ERAccordionComponentFactory >> createRegConferenceInformationComponent: anAttendee [
	"Create a form of conference information"

	^ self createFormOf: anAttendee conferenceInformation
]
