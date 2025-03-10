"
Description
--------------------

I am div with alert style by default.
I am a component to display messages of success or error.
I am visible when they change the content of the message that I have to show.
	
Instance Variables
--------------------
	class:     string with class of type of alert { 'errors', 'alert-success' }, only chnge the color of alert.
	message:   string of the message that will showed.
	wasShown:  state of visibility of alert
"
Class {
	#name : #ERAlert,
	#superclass : #ERComponent,
	#instVars : [
		'message',
		'class',
		'role',
		'wasShown'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #'instance creation' }
ERAlert class >> warningAlert [
	^ self new
		class: 'errors';
		role: 'alert';
		yourself .
]

{ #category : #updateClassOfAlert }
ERAlert >> changeToAlertOfError [
	class := 'errors'
]

{ #category : #updateClassOfAlert }
ERAlert >> changeToAlertSuccess [
	class := 'alert-success'
]

{ #category : #accessing }
ERAlert >> class: anObject [
	class := anObject
]

{ #category : #rendering }
ERAlert >> errorMessage: aString [
	aString ifNotEmpty: [
		self message: aString;
			  wasShown: false
			]
]

{ #category : #initialization }
ERAlert >> initialize [

 super initialize.
 self wasShown: true
]

{ #category : #accessing }
ERAlert >> message: anObject [
	message := anObject
]

{ #category : #rendering }
ERAlert >> renderContentOn: html [
	wasShown ifTrue: [ ^ self ].
	html div
		id: id;
		class: class, ' alert';
		attributeAt: 'role' put: role;
		with: message .
	self wasShown: true
]

{ #category : #accessing }
ERAlert >> role: anObject [
	role := anObject
]

{ #category : #accessing }
ERAlert >> wasShown: anObject [
	wasShown := anObject
]
