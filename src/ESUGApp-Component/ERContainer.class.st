"
Description
--------------------

I am a card component used to show the content of page


"
Class {
	#name : #ERContainer,
	#superclass : #ERStateContent,
	#category : #'ESUGApp-Component'
}

{ #category : #'instance creation' }
ERContainer class >> attendee: anAttendee [
	| instance |
	instance := self new.
	instance attendee: anAttendee.
	^ instance
]

{ #category : #rendering }
ERContainer >> renderContentOn: html [
	html mdlLayoutContent 
		class: ' mdl-color--grey-100';
		with: [ html mdlCard
				class:
					'mdl-card__supporting-text mdl-color--white mdl-shadow--2dp mdl-cell mdl-cell--12-col';
				with: [ self renderContentPageOn: html ] ]
]

{ #category : #rendering }
ERContainer >> renderContentPageOn: html [
	self subclassResponsibility 
]
