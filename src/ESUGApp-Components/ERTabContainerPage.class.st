Class {
	#name : #ERTabContainerPage,
	#superclass : #ERTab,
	#instVars : [
		'messageComponent',
		'content',
		'controller',
		'callback'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #'as yet unclassified' }
ERTabContainerPage class >> on: anAttendee withContent: aContent [
	| form |
	form := self new.
	form attendee: anAttendee.
	form content: aContent.
	^ form
]

{ #category : #accessing }
ERTabContainerPage >> callback [
	^ callback
]

{ #category : #accessing }
ERTabContainerPage >> callback: anObject [
	callback := anObject
]

{ #category : #accessing }
ERTabContainerPage >> content [
	^ content
]

{ #category : #accessing }
ERTabContainerPage >> content: anObject [
	content := anObject
]

{ #category : #accessing }
ERTabContainerPage >> controller [
	^ controller
]

{ #category : #accessing }
ERTabContainerPage >> controller: anObject [
	controller := anObject
]

{ #category : #'as yet unclassified' }
ERTabContainerPage >> formWithoutBasicInformationFor: anAttendee [
	^ OrderedCollection new
		add:
			(ERTabForAForm form: (ERContactInformation on: anAttendee))
				activate;
		add: (ERTabForAForm form: (ERConferenceOptions on: anAttendee));
		add:
			(ERTabForAForm form: (ERAffiliationInformation on: anAttendee));
		add: (ERTabForAForm form: (ERAdditionalInformation on: anAttendee));
		add: (ERTabForAForm form: (ERPaymentInformation on: anAttendee));
		add: (ERDoneForm on: anAttendee callback: callback);
		yourself
]

{ #category : #rendering }
ERTabContainerPage >> renderContainer: html [
	self subclassResponsibility 
]

{ #category : #rendering }
ERTabContainerPage >> renderContentOn: html [
	html heading level3; with: self title .
	self renderContainer: html
]

{ #category : #accessing }
ERTabContainerPage >> title [
	self subclassResponsibility 
]