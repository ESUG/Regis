"
Description
--------------------

I am a personalized mdlNavigation for page.
"
Class {
	#name : #ERNav,
	#superclass : #WAComponent,
	#instVars : [
		'title',
		'listOptions'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #hooks }
ERNav >> children [
	^ Array withAll: listOptions
]

{ #category : #initialization }
ERNav >> initialize [
	super initialize.
	title := 'Home'.
	listOptions := OrderedCollection new
]

{ #category : #accessing }
ERNav >> listOptions: anObject [
	listOptions := anObject
]

{ #category : #rendering }
ERNav >> renderContentOn: html [
	self renderHeaderOn: html.
	html mdlLayoutDrawer
		class:
			'demo-drawer mdl-color--blue-grey-900 mdl-color-text--blue-grey-50';
		with: [ self renderHeaderESUGOn: html.
			html mdlNavigation
				class: 'demo-navigation mdl-color--blue-grey-800';
				with: [ listOptions do: [ :each | html render: each ] ] ]
]

{ #category : #rendering }
ERNav >> renderHeaderESUGOn: html [
	html header class: 'demo-drawer-header';
	with: [ 
			html heading level4 class: 'demo-drawer-text'; with: 'ESUG'	
	]
]

{ #category : #rendering }
ERNav >> renderHeaderOn: html [
	html mdlLayoutHeader
	class: 'demo-header mdl-layout__header mdl-color--blue-grey-800 mdl-color-text--white';
	with: [ 
		html mdlLayoutHeaderRow with: [ 
			html mdlLayoutSpacer.
		]	
	].
]

{ #category : #accessing }
ERNav >> title: aString [
	title := aString
]
