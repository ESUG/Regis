Class {
	#name : #ERRegister,
	#superclass : #ERPageView,
	#instVars : [
		'tabs',
		'actionRegister',
		'messageComponent'
	],
	#category : #'ESUGApp-Views'
}

{ #category : #initialization }
ERRegister class >> initializeForm [
	| form |
	form := self new.
	form initializeTabForms.
	^ form
]

{ #category : #accessing }
ERRegister >> actionRegister: anObject [
	actionRegister := anObject
]

{ #category : #adding }
ERRegister >> addTab: aAttendeeTabForm [
	self tabs add: aAttendeeTabForm
]

{ #category : #initialization }
ERRegister >> convertToGroupManager [
	self attendee userAccount role: 'groupManager'
]

{ #category : #rendering }
ERRegister >> deactivateAllTabs [
	self tabs do: [ :each | each deactivate ].
]

{ #category : #initialization }
ERRegister >> initialize [
	super initialize.
	icon := 'assignment'.
	messageComponent := ERComponentAlert warningAlert
		id: 'messageAlertLogin'.
	pageController := ERRegistrationController new.
	id := 'all body-all'.
	classContainer := 'mdl-card-register'.
]

{ #category : #initialization }
ERRegister >> initializeTabForms [
	self subclassResponsibility 
]

{ #category : #'tools registry' }
ERRegister >> register [
	|user|
	user := pageController save.
	self validateRegister: user
]

{ #category : #initialization }
ERRegister >> registerAsGroupManager [
	|user|
	user := pageController saveAsGroupManager.
	self validateRegister: user
]

{ #category : #rendering }
ERRegister >> renderBackLoginButtonOn: html [
	html mdlButton
		colored;
		rippleEffect;
		id: 'backLogin';
		callback: [ self answer: nil ];
		with: 'Back Login'
]

{ #category : #rendering }
ERRegister >> renderPageOn: html [
	html mdlTabs class: 'mdl-js-ripple-effect';
	with: [ 
		html mdlGrid noSpacing 
		with: [ 
			html form
			method: 'post';
			id: 'formRegister';
			with: [ html render: messageComponent.
				html render: (ERTabsView tabs: self tabs) ].
			]
	].
	html
		form: [ self renderBackLoginButtonOn: html ]
]

{ #category : #rendering }
ERRegister >> tabActive [
	tabs
		do: [ :each | 
			each isActive
				ifTrue: [ ^ each ].
			^ nil ]
]

{ #category : #accessing }
ERRegister >> tabs [
	tabs ifNil: [ tabs:= OrderedCollection new].
	^ tabs.
]

{ #category : #'as yet unclassified' }
ERRegister >> validateRegister: user [

	user notNil
		ifTrue: [ self answer: user ]
		ifFalse:
			[ messageComponent errorMessage: 'This email is aleready registered' ]
]