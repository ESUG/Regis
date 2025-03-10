"
I am a container of accordion element
"
Class {
	#name : #ERAccordionContainer,
	#superclass : #ERStateAccordionContent,
	#category : #'ESUGApp-Component'
}

{ #category : #accessing }
ERAccordionContainer class >> attendee: anAttendee [
	| instance |
	instance := self new.
	instance attendee: anAttendee.
	^ instance
]

{ #category : #rendering }
ERAccordionContainer >> renderContentOn: html [

	self renderContentPageOn: html
]

{ #category : #rendering }
ERAccordionContainer >> renderContentPageOn: html [

	self subclassResponsibility
]
