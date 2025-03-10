"
Description
--------------------

I am a card component used for render tabs in the container of page.

Instance Variables
--------------------
	tabView: a ERTabs component to render in this component
	messageComponent: a ERAlert component to show errors of this component
	callback: aBlock to execute after saveTabs
	tabs: an OrderedCollection of Tab components (this will be rendered in tabView component)
	saveTabs: a block to execute when press a Done Button
"
Class {
	#name : #ERContainerTabs,
	#superclass : #ERContainer,
	#instVars : [
		'tabView',
		'messageComponent',
		'callback',
		'tabs',
		'saveTabs'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #'instance creation' }
ERContainerTabs class >> formGroupInformationFormOn: anAttendee withCallback: aBlock content: aContent conference: aConference [
	| form |

	form := self new.
	form content: aContent.
	form callback: aBlock.
	form conference: aConference.
	form attendee: anAttendee.
	form initializeWithGroupInformationFor: anAttendee.
	form tabView: (ERTabs tabs: form tabs).
	^ form
]

{ #category : #'instance creation' }
ERContainerTabs class >> formGroupMemberRegisterOn: anAttendee withCallback: aBlock content: aContent conference: aConference [
	| form |
	form := self new.
	form content: aContent.
	form callback: aBlock.
	form attendee: anAttendee.
	form conference: aConference.
	form initializeTabsGroupMemberRegisterFor: anAttendee.
	form tabView: (ERTabs tabs: form tabs).
	^ form
]

{ #category : #'instance creation' }
ERContainerTabs class >> formRegisterOn: anAttendee withCallback: aBlock content: aContent conference: aConference [
	| form |
	form := self new.
	form content: aContent.
	form callback: aBlock.
	form attendee: anAttendee.
	form conference: aConference.
	form initializeTabsRegisterFor: anAttendee.
	form tabView: (ERTabs tabs: form tabs).
	^ form
]

{ #category : #'instance creation' }
ERContainerTabs class >> formToGroupManagerOn: anAttendee withCallback: aBlock content: aContent [
	| form |
	form := self new.
	form content: aContent.
	form callback: aBlock.
	form attendee: anAttendee.
	form initializeTabsToGroupManagerFor: anAttendee.
	form tabView: (ERTabs tabs: form tabs).
	^ form
]

{ #category : #'instance creation' }
ERContainerTabs class >> formWithoutBasicInfoOn: anAttendee withCallback: aBlock content: aContent [
	| form |
	form := self new.
	form content: aContent.
	form callback: aBlock.
	form attendee: anAttendee.
	form initializeTabsWithoutBasicInformationFor: anAttendee.
	form tabView: (ERTabs tabs: form tabs).
	^ form
]

{ #category : #'instance creation' }
ERContainerTabs class >> formWithoutBasicInfoToGroupMemberOn: anAttendee withCallback: aBlock content: aContent [
	| form |
	form := self new.
	form content: aContent.
	form callback: aBlock.
	form attendee: anAttendee.
	form initializeTabsWithoutBasicInformationToGroupMemberFor: anAttendee.
	form tabView: (ERTabs tabs: form tabs).
	^ form
]

{ #category : #'instance creation' }
ERContainerTabs class >> formWithoutBasicInfoWithNotGroupOn: anAttendee withCallback: aBlock content: aContent conference: aConference [
	| form |
	form := self new.
	form content: aContent.
	form callback: aBlock.
	form attendee: anAttendee.
	form conference: aConference.
	form initializeTabsWithoutBasicInformationWithNotGroupFor: anAttendee.
	form tabView: (ERTabs tabs: form tabs).
	^ form
]

{ #category : #accessing }
ERContainerTabs >> callback: anObject [
	callback := anObject
]

{ #category : #initialization }
ERContainerTabs >> cancelTab [
	^ [ :anAttendee |  anAttendee version > 0 ifTrue: [
		anAttendee abortChanges ].
		self content state: self content lastState  ]
]

{ #category : #rendering }
ERContainerTabs >> children [ 
	^ Array with: messageComponent with: tabView 
]

{ #category : #accessing }
ERContainerTabs >> content: anObject [
	content := anObject
]

{ #category : #rendering }
ERContainerTabs >> initialize [
	super initialize.
	messageComponent := ERAlert warningAlert id: 'registerAlert'.
	
]

{ #category : #initialization }
ERContainerTabs >> initializeTabsGroupMemberRegisterFor: anAttendee [
	"Initialize tabs for register form"
	tabs := OrderedCollection new
				add: ((self createBasicInfoTab: anAttendee withContent: self)
					activate; cancelCallback: self cancelTab);
				add: ((self createRegConferenceInfoTab: anAttendee withContent: self)
					disabled: true; cancelCallback: self cancelTab);
				add: ((self createAdditionalInfoTab: anAttendee withContent: self)
					disabled: true; 
					buttonsOfTab: [:html |self renderFinalizeButtonOn: html ]; 
					cancelCallback: self cancelTab);
				yourself.
	saveTabs := [ self saveGroupAttendeeTabs ]
]

{ #category : #initialization }
ERContainerTabs >> initializeTabsRegisterFor: anAttendee [
	"Initialize tabs for register form"
	
	tabs := OrderedCollection new
	add: ((self createBasicInfoTab: anAttendee withContent: self) activate; cancelCallback: self cancelTab);
	add: ((self createContactInfoTab: anAttendee withContent: self ) disabled: true; cancelCallback: self cancelTab);
	add: ((self createRegConferenceInfoTab: anAttendee withContent: self )disabled: true; cancelCallback: self cancelTab);
	add: ((self createBillingInfoTab: anAttendee withContent: self)disabled: true; cancelCallback: self cancelTab);
	add: ((self createAdditionalInfoTab: anAttendee withContent: self)disabled: true; cancelCallback: self cancelTab);
	add: ((self createPaymentInfoTab: anAttendee withContent: self) disabled: true; buttonsOfTab: [ :html | self renderFinalizeButtonOn: html ]; cancelCallback: self cancelTab);
		yourself.
	saveTabs := [ self saveAttendeeTabs ]
]

{ #category : #initialization }
ERContainerTabs >> initializeTabsToGroupManagerFor: aGroup [
	"Initialize tabs form for update an registration, this tabs do not have a user information"

	tabs := OrderedCollection new
		add: ((self createRegConferenceInfoTab: aGroup withContent: self) 
				activate; 
				previousTabName: nil; 
				cancelCallback: self cancelTab);
		add: ((self createAdditionalInfoTab: aGroup withContent: self) 
				buttonsOfTab: [ :html | self renderFinalizeButtonOn: html ];
				cancelCallback: self cancelTab);
		yourself.
	saveTabs := [ self saveAttendeeToGroupManagerTabs: aGroup ]
]

{ #category : #initialization }
ERContainerTabs >> initializeTabsWithoutBasicInformationFor: anAttendee [
	"Initialize tabs form for update an registration, this tabs do not have a user information"
	tabs := OrderedCollection new
		add: ((self createContactInfoTab: anAttendee withContent: self) 
					activate; 
					previousTabName: nil; 
					cancelCallback: self cancelTab);
		add: ((self createRegConferenceInfoTab: anAttendee withContent: self)
			cancelCallback: self cancelTab);
		add: ((self createBillingInfoTab: anAttendee withContent: self)
			cancelCallback: self cancelTab);
		add: ((self createAdditionalInfoTab: anAttendee withContent: self)
			cancelCallback: self cancelTab);
		add: ((self createPaymentInfoTab: anAttendee withContent: self)
			buttonsOfTab: [ :html | self renderFinalizeButtonOn: html ]; 
			cancelCallback: self cancelTab);
		yourself.
	saveTabs := [ self saveAttendeeToGroupManagerTabs: anAttendee ]
]

{ #category : #initialization }
ERContainerTabs >> initializeTabsWithoutBasicInformationToGroupMemberFor: anAttendee [
	"Initialize tabs form for update an registration, this tabs do not have a user information"
	tabs := OrderedCollection new
		add: ((self createRegConferenceInfoTab: anAttendee withContent: self)
			activate; 
			previousTabName: nil; 
			cancelCallback: self cancelTab);
		add: ((self createAdditionalInfoTab: anAttendee withContent: self)
			buttonsOfTab: [ :html | self renderFinalizeButtonOn: html ];
			cancelCallback: self cancelTab);
		yourself.
	saveTabs := [ self saveAttendeeToGroupManagerTabs: anAttendee ]
]

{ #category : #initialization }
ERContainerTabs >> initializeTabsWithoutBasicInformationWithNotGroupFor: anAttendee [
	"Initialize tabs form for update an registration, this tabs do not have a user information"
	tabs := OrderedCollection new
		add: ((self createContactInfoTab: anAttendee withContent: self) 
					activate; 
					previousTabName: nil; 
					cancelCallback: self cancelTab);
		add: ((self createRegConferenceInfoTab: anAttendee withContent: self)
			cancelCallback: self cancelTab);
		add: ((self createBillingInfoTab: anAttendee withContent: self)
			cancelCallback: self cancelTab);
		add: ((self createAdditionalInfoTab: anAttendee withContent: self)
			cancelCallback: self cancelTab);
		add: ((self createPaymentInfoTab: anAttendee withContent: self)
			buttonsOfTab: [ :html | self renderFinalizeButtonOn: html ]; 
			cancelCallback: self cancelTab);
		yourself.
	saveTabs := [ self saveAttendeeWithoutGroupTabs ]
]

{ #category : #initialization }
ERContainerTabs >> initializeWithGroupInformationFor: anAttendee [
	"Initialize tabs form for update an registration, this tabs do not have a user information"
	tabs := OrderedCollection new
		add: ((self createContactInfoTab: anAttendee withContent: self) 
					activate; 
					previousTabName: nil; 
					cancelCallback: self cancelTab);
		add: ((self createBillingInfoTab: anAttendee withContent: self)
			cancelCallback: self cancelTab);
		add: ((self createPaymentInfoTab: anAttendee withContent: self)
			buttonsOfTab: [ :html | self renderFinalizeButtonOn: html ]; 
			cancelCallback: self cancelTab);
		yourself.
	saveTabs := [ self saveGroupInformationTabs ]
]

{ #category : #rendering }
ERContainerTabs >> renderContentPageOn: html [
	
	html form
		method: 'post';
		id: 'registerForm';
		with: [
			html mdlTabs rippleEffect
				with: [ 
					html div
						style: 'overflow-x:auto;';
						with: [ 
							 html render: messageComponent.
							 html render: tabView ] ] ]
]

{ #category : #rendering }
ERContainerTabs >> renderFinalizeButtonOn: html [
	html mdlButton
		style: 'float:right';
		beSubmit;
		raised;
		primaryColor;
		rippleEffect;
		id: 'registerButton';
		callback: [ 
			saveTabs
				on: ERException
				do: [ :exception | messageComponent errorMessage: exception messageText ] ];
		with: 'Finalize Registration'
]

{ #category : #saving }
ERContainerTabs >> saveAdditionalInfoAt: index [
	(tabs at: index)contentTab save.
	attendee additionalInformation: (tabs at: index)contentTab model 
]

{ #category : #saving }
ERContainerTabs >> saveAffiliationInfoAt: index [
	(tabs at: index) contentTab save.
	attendee affiliationInformation: (tabs at: index) contentTab model
]

{ #category : #saving }
ERContainerTabs >> saveAffiliationInfoOfGroup: aGroup [
	
	"(tabs at: index) contentTab save."
	attendee affiliationInformation: aGroup affiliationInformation copy
]

{ #category : #saving }
ERContainerTabs >> saveAttendeeTabs [
	self saveUserAccountAt: 1.
	self saveContactInfoAt: 2.
	self saveRegConferenceInfoAt: 3.
	self saveAffiliationInfoAt: 4.
	self saveAdditionalInfoAt: 5.
	self savePaymentInfoAt: 6.
	callback cull: attendee
]

{ #category : #saving }
ERContainerTabs >> saveAttendeeToGroupManagerTabs: aGroup [
	self saveContactInfoOfGroup: aGroup.
	self saveRegConferenceInfoAt: 1.
	self saveAffiliationInfoOfGroup: aGroup.
	self saveAdditionalInfoAt: 2.
	callback cull: attendee
]

{ #category : #saving }
ERContainerTabs >> saveAttendeeWithoutGroupTabs [

	self saveContactInfoAt: 1.
	self saveRegConferenceInfoAt: 2.
	self saveAffiliationInfoAt: 3.
	self saveAdditionalInfoAt: 4.
	self savePaymentInfoAt: 5.
	callback cull: attendee
]

{ #category : #saving }
ERContainerTabs >> saveContactInfoAt: index [
	(tabs at: index) contentTab save.
	attendee contactInformation: (tabs at: index) contentTab model
]

{ #category : #saving }
ERContainerTabs >> saveContactInfoOfGroup: aGroup [

	"(tabs at: index) contentTab save."
	attendee contactInformation: aGroup contactInformation copy
]

{ #category : #saving }
ERContainerTabs >> saveGroupAttendeeTabs [
	self saveUserAccountAt: 1.
	self saveRegConferenceInfoAt: 2.
	self saveAdditionalInfoAt: 3.
	callback cull: attendee
]

{ #category : #saving }
ERContainerTabs >> saveGroupInformationTabs [

	self saveContactInfoAt: 1.
	self saveAffiliationInfoAt: 2.
	self savePaymentInfoAt: 3.
	callback cull: attendee
]

{ #category : #saving }
ERContainerTabs >> savePaymentInfoAt: index [
	(tabs at: index)contentTab save.
	attendee paymentInformation: (tabs at: index)contentTab model 
]

{ #category : #saving }
ERContainerTabs >> saveRegConferenceInfoAt: index [
	(tabs at: index)contentTab save.
	attendee conferenceInformation: (tabs at: index)contentTab model 
]

{ #category : #saving }
ERContainerTabs >> saveUserAccountAt: index [
	(tabs at: index) contentTab save.
	attendee userAccount: (tabs at: index) contentTab model
]

{ #category : #accessing }
ERContainerTabs >> tabView: anObject [
	tabView := anObject
]

{ #category : #accessing }
ERContainerTabs >> tabs [
	^ tabs
]

{ #category : #accessing }
ERContainerTabs >> tabs: anObject [
	tabs := anObject
]
