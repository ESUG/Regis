"
I am a content tab of accordion element
"
Class {
	#name : #ERAccordionContentTab,
	#superclass : #ERAccordionTab,
	#instVars : [
		'contentTab',
		'previousContentTab',
		'buttonsOfTab',
		'action',
		'nextTabName',
		'previousTabName',
		'cancelCallback',
		'classId'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #accessing }
ERAccordionContentTab >> action: anObject [
	action := anObject
]

{ #category : #accessing }
ERAccordionContentTab >> buttonsOfTab: anObject [

	buttonsOfTab := anObject
]

{ #category : #accessing }
ERAccordionContentTab >> cancelCallback: anObject [

	cancelCallback := anObject
]

{ #category : #hooks }
ERAccordionContentTab >> children [
	^ super children asOrderedCollection copyWithAll: (OrderedCollection new
		add: contentTab;
		yourself); yourself
]

{ #category : #accessing }
ERAccordionContentTab >> classId: anId [

	classId := anId
]

{ #category : #accessing }
ERAccordionContentTab >> contentTab [
	^ contentTab
]

{ #category : #accessing }
ERAccordionContentTab >> contentTab: anObject [

	contentTab := anObject
]

{ #category : #initialization }
ERAccordionContentTab >> initialize [

	super initialize.
	messageComponent := ERAlert warningAlert.
	action := [ :aValue |  ]
]

{ #category : #accessing }
ERAccordionContentTab >> nextTabName: anObject [
	nextTabName := anObject
]

{ #category : #accessing }
ERAccordionContentTab >> previousContentTab: anObject [
	previousContentTab := anObject
]

{ #category : #accessing }
ERAccordionContentTab >> previousTabName: anObject [
	previousTabName := anObject
]

{ #category : #rendering }
ERAccordionContentTab >> renderBackButtonOn: html [
	previousTabName ifNotNil: [
	html mdlAnchorButton
		colored;
		rippleEffect;
		class: 'btnPreviousAccordion', classId printString;
		id: self tabId ,'-previousButton';
		with: 'Previous']
]

{ #category : #rendering }
ERAccordionContentTab >> renderButtonsOn: html [
	html horizontalRule.
	self renderRemoveRegisterUserButtonOn: html.
	self renderBackButtonOn: html.
	
]

{ #category : #rendering }
ERAccordionContentTab >> renderContentOn: html [
	html render: messageComponent.
	self renderPreviousContentOn: html.
	html render: contentTab.
	self renderButtonsOn: html.
	buttonsOfTab ifNil:[ self renderNextButtonOn: html ]
		ifNotNil: [ buttonsOfTab cull: html ]
]

{ #category : #rendering }
ERAccordionContentTab >> renderNextButtonOn: html [

	nextTabName ifNotNil: [
		html mdlAnchorButton 
			style: 'float:right';
			raised;
			primaryColor;
			rippleEffect;
			class: 'btnNextAccordion', classId printString;
			id: self tabId ,'-nextButton';
			with: 'Next' ]
]

{ #category : #rendering }
ERAccordionContentTab >> renderPreviousContentOn: html [
	previousContentTab isNotNil 
		ifTrue: [ html html: previousContentTab ]
]

{ #category : #rendering }
ERAccordionContentTab >> renderRemoveRegisterUserButtonOn: html [

	html mdlAnchorButton 
		colored;
		rippleEffect;
		id: self tabId ,'-removeRegister';
		callback: cancelCallback;
		with: 'Remove user'
]

{ #category : #accessing }
ERAccordionContentTab >> tabId [
	^ tabId 
]

{ #category : #accessing }
ERAccordionContentTab >> tabId: aString [
	tabId := aString.
	messageComponent  id: self tabId ,'-tabAlert'.
]
