"
Description
--------------------

I am a personalized card.

Instance Variables
--------------------
	content: 			 a block renderizable
	title: 			 string that will be title of the card
	iconPage: 		 name of icon as string
	classContainer: additional class of card
	classColorIcon: string with color of icon, e.g. ""mdl-color--green""
	actionsBody:    additional block with renderible objects, this will be at the bottom of card
"
Class {
	#name : #ERCard,
	#superclass : #ERComponent,
	#instVars : [
		'content',
		'title',
		'iconPage',
		'classContainer',
		'classColorIcon',
		'actionsBody'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #'instance creation' }
ERCard class >> title: aString icon: anIcon content: aBlock id: anId colorIcon: anColor actions: aBlockActions [
	| instance |
	instance := self new.
	instance title: aString.
	instance iconPage: anIcon .
	instance content: aBlock .
	instance id: anId .
	instance classColorIcon: anColor.
	instance actionsBody: aBlockActions.
	^ instance
]

{ #category : #accessing }
ERCard >> actionsBody: anObject [
	actionsBody := anObject
]

{ #category : #accessing }
ERCard >> classColorIcon: anObject [
	classColorIcon := anObject
]

{ #category : #accessing }
ERCard >> classContainer: anObject [
	classContainer := anObject
]

{ #category : #accessing }
ERCard >> content [
	^ content
]

{ #category : #accessing }
ERCard >> content: anObject [
	content := anObject
]

{ #category : #accessing }
ERCard >> iconPage: anObject [
	iconPage := anObject
]

{ #category : #initialization }
ERCard >> initialize [
	super initialize.
	classContainer := ''.
	classColorIcon := 'mdl-color--red'.
]

{ #category : #rendering }
ERCard >> renderContentOn: html [
	html mdlCard id: self id;
	class: classContainer, ' mdl-shadow--16dp';
	with: [ 
		html mdlCardTextContainer 
		with: [ 
			self renderIconCardOn: html.
			html div id: 'card-heading';
			with: self title.
			self content value.
		].	
		actionsBody value.
	].
]

{ #category : #rendering }
ERCard >> renderIconCardOn: html [
	html div id: 'login-fab';
	class: classColorIcon, ' mdl-color-text--white';
	with: [ 
		html mdlIcon id: 'lock-icon';
		with: iconPage
	].
]

{ #category : #accessing }
ERCard >> title [
	^ title
]

{ #category : #accessing }
ERCard >> title: anObject [
	title := anObject
]
