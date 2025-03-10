"
Description
--------------------

I am a container in tab
"
Class {
	#name : #ERContentTab,
	#superclass : #ERTab,
	#instVars : [
		'contentTab',
		'previousContentTab',
		'buttonsOfTab',
		'action',
		'nextTabName',
		'previousTabName',
		'cancelCallback'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #accessing }
ERContentTab >> action: anObject [
	action := anObject
]

{ #category : #accessing }
ERContentTab >> buttonsOfTab: anObject [
	buttonsOfTab := anObject
]

{ #category : #accessing }
ERContentTab >> cancelCallback: anObject [
	cancelCallback := anObject
]

{ #category : #rendering }
ERContentTab >> children [
	^ super children asOrderedCollection copyWithAll: (OrderedCollection new
		add: contentTab;
		yourself); yourself
]

{ #category : #accessing }
ERContentTab >> contentTab [
	^ contentTab
]

{ #category : #accessing }
ERContentTab >> contentTab: anObject [
	contentTab := anObject
]

{ #category : #initialization }
ERContentTab >> initialize [
	super initialize.
	messageComponent := ERAlert warningAlert.
	cancelCallback := [ :anAttendee | container content state: container content lastState ].
	action := [ :aValue |  ]
]

{ #category : #accessing }
ERContentTab >> nextTabName: anObject [
	nextTabName := anObject
]

{ #category : #accessing }
ERContentTab >> previousContentTab: anObject [
	previousContentTab := anObject
]

{ #category : #accessing }
ERContentTab >> previousTabName: anObject [
	previousTabName := anObject
]

{ #category : #rendering }
ERContentTab >> renderBackButtonOn: html [
	previousTabName ifNotNil: [
	html mdlAnchorButton
		colored;
		rippleEffect;
		class: 'btnPrevious';
		id: self tabId ,'-previousButton';
		with: 'Previous']
]

{ #category : #rendering }
ERContentTab >> renderButtonsOn: html [
	html horizontalRule.
	self renderGoBackToLogin: html.
	self renderBackButtonOn: html.
	
]

{ #category : #rendering }
ERContentTab >> renderContentOn: html [
	html render: messageComponent.
	self renderPreviousContentOn: html.
	html render: contentTab.
	self renderButtonsOn: html .
	buttonsOfTab ifNil:[self renderNextButtonOn: html]
		ifNotNil: [ buttonsOfTab cull: html ]
	
]

{ #category : #rendering }
ERContentTab >> renderGoBackToLogin: html [
	html mdlAnchorButton 
		colored;
		rippleEffect;
		onClick: 'return confirm(''You are sure to return? You will lose all your changes'');';
		id: self tabId ,'-goBackLoginButton';
		callback: [cancelCallback cull: attendee ];
		with: 'Cancel'
]

{ #category : #rendering }
ERContentTab >> renderNextButtonOn: html [
	nextTabName ifNotNil: [
	html mdlAnchorButton 
		style: 'float:right';
		raised;
		primaryColor;
		rippleEffect;
		class: 'btnNext';
		id: self tabId ,'-nextButton';
		with: 'Next']
]

{ #category : #rendering }
ERContentTab >> renderPreviousContentOn: html [
	previousContentTab isNotNil 
		ifTrue: [ html html: previousContentTab ]
]

{ #category : #accessing }
ERContentTab >> tabId: aString [
	tabId := aString.
	messageComponent  id: self tabId ,'-tabAlert'.
]
