"
I am a state content to register an user
"
Class {
	#name : #ERStateContent,
	#superclass : #ERComponentFactory,
	#instVars : [
		'content'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #'instance creation' }
ERStateContent class >> content: aContent [
	| instance |
	instance := self new.
	instance content: aContent.
	^ instance
]

{ #category : #accessing }
ERStateContent >> content [
	^ content
]

{ #category : #accessing }
ERStateContent >> content: anObject [
	content := anObject.
	content state: self
]

{ #category : #rendering }
ERStateContent >> renderContentOn: html [
	self subclassResponsibility 
]

{ #category : #rendering }
ERStateContent >> returnToThePreviousState [
	content state: content lastState
]
