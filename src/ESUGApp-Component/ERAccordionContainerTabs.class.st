"
I am a container tab to accordion users
"
Class {
	#name : #ERAccordionContainerTabs,
	#superclass : #ERAccordionContainer,
	#instVars : [
		'tabView',
		'messageComponent',
		'tabs',
		'saveTabs',
		'id',
		'cancelCallback',
		'saveCallback'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #'instance creation' }
ERAccordionContainerTabs class >> formGroupMemberRegisterOn: anAttendee withClassId: anId cancelCallback: aFirstCallback saveCallback: aSecondCallback [
	| form |
	form := self new id: anId.
	form attendee: anAttendee.
	form cancelCallback: aFirstCallback.
	form saveCallback: aSecondCallback.
	form initializeTabsGroupMemberRegisterFor: anAttendee.
	form tabView: (ERTabs tabs: form tabs).
	^ form
]

{ #category : #accessing }
ERAccordionContainerTabs >> cancelCallback: anObject [
	
	cancelCallback := anObject
]

{ #category : #initialization }
ERAccordionContainerTabs >> cancelTab [

	^ cancelCallback
]

{ #category : #accessing }
ERAccordionContainerTabs >> id: anId [

	id := anId
]

{ #category : #initialization }
ERAccordionContainerTabs >> initialize [

	super initialize.
	messageComponent := ERAlert warningAlert id: 'registerAlert'.
]

{ #category : #initialization }
ERAccordionContainerTabs >> initializeTabsGroupMemberRegisterFor: anAttendee [
	"Initialize tabs for register form"
	
	tabs := OrderedCollection new
				add: ((self createBasicInfoTab: anAttendee withContent: self andClassId: id)
					activate; 
					cancelCallback: self cancelTab);
				add: ((self createRegConferenceInfoTab: anAttendee withContent: self andClassId: id)
					disabled: true;
					cancelCallback: self cancelTab);
				add: ((self createAdditionalInfoTab: anAttendee withContent: self andClassId: id)
					disabled: true; 
					buttonsOfTab: [:html |self renderFinalizeButtonOn: html ]; 
					cancelCallback: self cancelTab);
				yourself.
	saveTabs := [ self saveGroupAttendeeTabs ]
]

{ #category : #rendering }
ERAccordionContainerTabs >> renderContentPageOn: html [
	
	html form
		method: 'post';
		id: ('registerAccordionForm', id printString);
		style: 'padding-bottom: 20px';
		with: [
			html div
				id: 'userSection', id printString;
				with: [
				html mdlTabs 
					rippleEffect
					with: [ 
						html div
							style: 'overflow-x:auto;';
							with: [ 
								html render: messageComponent.
							 	html render: tabView ] ] ] ]
]

{ #category : #rendering }
ERAccordionContainerTabs >> renderFinalizeButtonOn: html [
	html mdlButton
		style: 'float:right';
		beSubmit;
		raised;
		primaryColor;
		rippleEffect;
		id: 'registerButton', id printString;
		callback: [ 
			saveTabs
				on: ERException
				do: [ :exception |  messageComponent errorMessage: exception messageText ] ];
		with: 'Finalize Registration'
]

{ #category : #accessing }
ERAccordionContainerTabs >> saveAdditionalInfoAt: index [
	(tabs at: index)contentTab save.
	attendee additionalInformation: (tabs at: index)contentTab model 
]

{ #category : #accessing }
ERAccordionContainerTabs >> saveCallback: anObject [
	
	saveCallback := anObject
]

{ #category : #saving }
ERAccordionContainerTabs >> saveGroupAttendeeTabs [

	self saveUserAccountAt: 1.
	self saveRegConferenceInfoAt: 2.
	self saveAdditionalInfoAt: 3.
	saveCallback cull: attendee
]

{ #category : #accessing }
ERAccordionContainerTabs >> saveRegConferenceInfoAt: index [
	(tabs at: index) contentTab save.
	attendee conferenceInformation: (tabs at: index)contentTab model 
]

{ #category : #accessing }
ERAccordionContainerTabs >> saveUserAccountAt: index [
	(tabs at: index) contentTab save.
	attendee userAccount: (tabs at: index) contentTab model
]

{ #category : #accessing }
ERAccordionContainerTabs >> tabView: anObject [
	tabView := anObject
]

{ #category : #accessing }
ERAccordionContainerTabs >> tabs [
	^ tabs
]

{ #category : #accessing }
ERAccordionContainerTabs >> tabs: anObject [
	tabs := anObject
]
