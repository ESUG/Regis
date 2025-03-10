"
I work as class of accordion tab
"
Class {
	#name : #ERAccordionTab,
	#superclass : #ERStateAccordionContent,
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

{ #category : #activation }
ERAccordionTab >> activate [
	active := true.
]

{ #category : #hooks }
ERAccordionTab >> children [ 	
	^ Array with: messageComponent  
]

{ #category : #accessing }
ERAccordionTab >> container: aContainer [
	container := aContainer
]

{ #category : #activation }
ERAccordionTab >> deactivate [
	active := false.
]

{ #category : #accessing }
ERAccordionTab >> disabled [
	^ disabled 	
]

{ #category : #accessing }
ERAccordionTab >> disabled: anObject [
	disabled := anObject
]

{ #category : #initialization }
ERAccordionTab >> initialize [
	super initialize.
	active := false.
	disabled := false.
	messageComponent := ERAlert warningAlert id: 'tabAlert'.
]

{ #category : #testing }
ERAccordionTab >> isActive [
	^ active.
]

{ #category : #rendering }
ERAccordionTab >> renderContentOn: html [

	self subclassResponsibility 
]

{ #category : #accessing }
ERAccordionTab >> tabId [
	^ tabId 
]

{ #category : #accessing }
ERAccordionTab >> tabId: anObject [
	tabId := anObject
]

{ #category : #accessing }
ERAccordionTab >> tabName [
	^ tabName 
]

{ #category : #accessing }
ERAccordionTab >> tabName: anObject [
	tabName := anObject
]

{ #category : #action }
ERAccordionTab >> updateStateTab: aString [
	container tabs detect: [ :tab | (tab tabName = aString) ]
	ifFound: [ :tab | tab activate.
		tab disabled: false.
		container tabs reject: [ :aTab | (aTab tabName = aString) ]
		thenDo: [ :aTab | aTab deactivate ]
	]
]
