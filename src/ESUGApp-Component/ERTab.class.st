"
Description
--------------------

I am an abstract tab object, I know my tab Id and my tabName (necessary for render tab), I have a state active or inactive.

All my subclasses should be implement the ""renderContentOn: html "" method
"
Class {
	#name : #ERTab,
	#superclass : #ERStateContent,
	#instVars : [
		'active',
		'id',
		'container',
		'tabId',
		'messageComponent',
		'tabName',
		'disabled'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #action }
ERTab >> activate [
	active := true.
]

{ #category : #activation }
ERTab >> children [ 	
	^ Array with: messageComponent  
]

{ #category : #activation }
ERTab >> container: aContainer [
	container := aContainer
]

{ #category : #action }
ERTab >> deactivate [
	active := false.
]

{ #category : #accessing }
ERTab >> disabled [
	^ disabled 	
]

{ #category : #accessing }
ERTab >> disabled: anObject [
	disabled := anObject
]

{ #category : #activation }
ERTab >> initialize [
	super initialize.
	active := false.
	disabled := false.
	messageComponent := ERAlert warningAlert id: 'tabAlert'.
]

{ #category : #action }
ERTab >> isActive [
	^ active.
]

{ #category : #activation }
ERTab >> renderContentOn: html [
	self subclassResponsibility 
]

{ #category : #accessing }
ERTab >> tabId [
	^ tabId 
]

{ #category : #accessing }
ERTab >> tabId: anObject [
	tabId := anObject
]

{ #category : #accessing }
ERTab >> tabName [
	^ tabName 
]

{ #category : #accessing }
ERTab >> tabName: anObject [
	tabName := anObject
]

{ #category : #action }
ERTab >> updateStateTab: aString [
	container tabs detect: [ :tab | (tab tabName = aString) ]
	ifFound: [ :tab | tab activate.
		tab disabled: false.
		container tabs reject: [ :aTab | (aTab tabName = aString) ]
		thenDo: [ :aTab | aTab deactivate ]
	]
]
