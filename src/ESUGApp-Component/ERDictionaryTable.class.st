"
Description
--------------------

I am a personalized table, I render a dictionary in tab format
"
Class {
	#name : #ERDictionaryTable,
	#superclass : #WAComponent,
	#instVars : [
		'rows',
		'header',
		'tableId'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #accessing }
ERDictionaryTable >> header: aCollection [

	header := aCollection
]

{ #category : #initialization }
ERDictionaryTable >> initialize [
	super initialize.
	tableId := ''.
	rows := OrderedDictionary new.
	header := OrderedCollection new.
]

{ #category : #'rendering-table' }
ERDictionaryTable >> render: html with: anObject [
	"Render object on html"

	""
]

{ #category : #rendering }
ERDictionaryTable >> renderContentOn: html [

	html mdlTable
		id: self tableId;
		with: [
			self renderTableHeaderOn: html.
			self renderTableBodyOn: html ]
]

{ #category : #rendering }
ERDictionaryTable >> renderTableBodyOn: html [
	html
		tableBody: [ rows
				do: [ :object | html tableRow: [ 
						header do: 
							[ :each | html mdlTableCell nonNumerical; with:(object at: each) ] ] ] ]
]

{ #category : #rendering }
ERDictionaryTable >> renderTableHeaderOn: html [
	html
		tableHead: [ html
				tableRow: [ header do: [ :each | html mdlTableCell nonNumerical; with: each ] ] ]
]

{ #category : #accessing }
ERDictionaryTable >> rows: aCollection [

	rows := aCollection
]

{ #category : #accessing }
ERDictionaryTable >> tableId [

	^ tableId
]

{ #category : #accessing }
ERDictionaryTable >> tableId: anId [

	tableId := anId
]
