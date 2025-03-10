"
Description
--------------------

I am a custom mdlNavigationLink, I have an icon, a label and callback
"
Class {
	#name : #ERItemNav,
	#superclass : #ERComponent,
	#instVars : [
		'callback',
		'icon',
		'label',
		'hasNotif',
		'notifCount'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #'instance creation' }
ERItemNav class >> label: aString icon: anIcon callback: aBlock [
	|instance|
	instance := self new.
	instance label: aString .
	instance icon: anIcon .
	instance callback: aBlock .
	^ instance 
]

{ #category : #action }
ERItemNav >> activateNotif [ 
	hasNotif:=true.
]

{ #category : #accessing }
ERItemNav >> callback: anObject [
	callback := anObject
]

{ #category : #action }
ERItemNav >> desactivateNotif [ 
	hasNotif:=false.
]

{ #category : #action }
ERItemNav >> evaluateCallBackBlock [
	callback value value.
]

{ #category : #action }
ERItemNav >> getCallback [ 
	self iAmClicked.
	self evaluateCallBackBlock.
	 
	
]

{ #category : #accessing }
ERItemNav >> hasNotif [ 
	^ hasNotif .
]

{ #category : #action }
ERItemNav >> iAmClicked [
	self session activeMenu:  label,'-option'.
]

{ #category : #accessing }
ERItemNav >> icon: anObject [
	icon := anObject
]

{ #category : #initialization }
ERItemNav >> initialize [  
	super initialize .
	hasNotif := false.
	notifCount := 0.
]

{ #category : #accessing }
ERItemNav >> isCurrentlyActive [ 
	^ self session activeMenu =  (label,'-option').
]

{ #category : #accessing }
ERItemNav >> label: anObject [
	label := anObject
]

{ #category : #accessing }
ERItemNav >> notifCount [  
	^	notifCount.
]

{ #category : #accessing }
ERItemNav >> notifCount: aNumber [ 
	notifCount:=aNumber.
]

{ #category : #rendering }
ERItemNav >> renderContentOn: html [
	html mdlNavigationLink
		id: label,'-option';
		callback: [self getCallback ];
		class: 'active-menu-option' if: (self isCurrentlyActive );
		with: [ 
			html mdlIcon
				class: 'mdl-color-text--white';
				with: [ html text: icon ].
				html text:  label . 
				self setBadge:html.
				]
]

{ #category : #accessing }
ERItemNav >> setBadge:html [
	|notifs|
	notifs := self notifCount.
	(self hasNotif and: (notifs > 0 ) ) 
	ifTrue: [ html mdlBadge dataBadge: notifs ; 
				title: notifs asString,' unaccepted talk(s).'. ]
	
]
