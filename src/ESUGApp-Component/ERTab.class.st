Class {
	#name : #ERTab,
	#superclass : #ERStateContent,
	#instVars : [
		'active',
		'id'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #'instance creation' }
ERTab class >> on: anAttendee [
	| form |
	form := self new.
	form attendee: anAttendee.
	^ form
]

{ #category : #activation }
ERTab >> activate [
	active := true.
]

{ #category : #accessing }
ERTab >> attendee: anObject [
	attendee := anObject
]

{ #category : #private }
ERTab >> deactivate [
	active := false.
]

{ #category : #initialization }
ERTab >> initialize [
	super initialize.
	active := false.
]

{ #category : #testing }
ERTab >> isActive [
	^ active.
]

{ #category : #rendering }
ERTab >> renderContentOn: html [
	self subclassResponsibility 
]

{ #category : #accessing }
ERTab >> tabId [
	^ self subclassResponsibility.
]

{ #category : #accessing }
ERTab >> tabName [
	^ self subclassResponsibility.
]