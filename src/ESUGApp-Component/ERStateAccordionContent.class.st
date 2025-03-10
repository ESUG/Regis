"
I a state content to accordion elements
"
Class {
	#name : #ERStateAccordionContent,
	#superclass : #ERAccordionComponentFactory,
	#instVars : [
		'content'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #accessing }
ERStateAccordionContent class >> content: aContent [
	| instance |
	instance := self new.
	instance content: aContent.
	^ instance
]

{ #category : #rendering }
ERStateAccordionContent >> renderContentOn: html [

	self subclassResponsibility 
]
