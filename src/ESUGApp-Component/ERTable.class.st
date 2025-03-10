"
Description
--------------------

I am a personalized table, I render la list of objects.

Instance Variables
--------------------
	headers:     			list of strings.
	listObject:  			list of object.
	blockToExecute:    	block with info how render each object of the list.
	listToRenderButton:   block only necesary if tht table will have a buttons for each row (e.g. delete, update)
"
Class {
	#name : #ERTable,
	#superclass : #PSSortedTableCollectionComponent,
	#instVars : [
		'blockToExecute',
		'listToRenderButton',
		'levelTotal',
		'dictToRenderDownloadButton',
		'validation',
		'sortingMethod'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #accessing }
ERTable >> blockToExecute: anObject [
	blockToExecute := anObject
]

{ #category : #accessing }
ERTable >> dictToRenderDownloadButton: aDictionary [
	dictToRenderDownloadButton := aDictionary 
]

{ #category : #initialization }
ERTable >> initialize [
	"blockToExecute listToRenderButton listObject levelTotal headers"
	super initialize.
	listToRenderButton := OrderedCollection new.
	dictToRenderDownloadButton := Dictionary new.
	sortingMethod := #().
	levelTotal := 6.
]

{ #category : #accessing }
ERTable >> levelTotal: anObject [
	levelTotal := anObject
]

{ #category : #accessing }
ERTable >> listToRenderButton: anObject [
	listToRenderButton := anObject
]

{ #category : #rendering }
ERTable >> render: html with: aObject [
	| listContent |
	listContent := blockToExecute valueWithPossibleArgs: {aObject. html}.
	listContent do: [ :content |
		html mdlTableCell nonNumerical; with: content.
	].
	html mdlTableCell nonNumerical; with: [ self renderButton: html with: aObject ]
	
]

{ #category : #rendering }
ERTable >> renderButton: html with: aObject [
	listToRenderButton
		do: [ :dataButton | | classBtn |
			classBtn := dataButton at:7 ifAbsent: [[ :item | '' ] ].
			 
			html mdlAnchorButton colored; rippleEffect;
				id: (dataButton third value: aObject);
				class:  (classBtn value:aObject) ;
				onClick: dataButton fifth;
				disabled: ( (dataButton sixth) isBlock ifTrue: [ (dataButton sixth value:aObject) ifTrue: ['disabled' ] ] ifFalse: [(dataButton sixth) ifTrue: ['disabled' ] ]);
				callback: [ dataButton second value: aObject ];
				icon: ( dataButton first isBlock ifTrue: [dataButton first value:aObject ] ifFalse: dataButton first ).
			html div	class: 'mdl-tooltip'; 
				attributeAt: 'data-mdl-for' put: (dataButton third value: aObject);
				with: ( dataButton fourth isBlock ifTrue: [dataButton fourth value:aObject ] ifFalse: dataButton fourth ).
				 ].
	self renderDownloadButton: html with: aObject
]

{ #category : #rendering }
ERTable >> renderDownloadButton: html with: aObject [
	dictToRenderDownloadButton ifNotEmpty: [ 
		| downloadButton |
		downloadButton := html mdlAnchorButton colored;	rippleEffect;
			id: ((dictToRenderDownloadButton at: 'id') value: aObject).
		downloadButton isDisabled ifFalse: [ 
			downloadButton url: ((dictToRenderDownloadButton at: 'url') value: aObject);
			attributeAt: 'download' put: ((dictToRenderDownloadButton at: 'download') value: aObject)].
		downloadButton icon: (dictToRenderDownloadButton at: 'icon').
		html div	class: 'mdl-tooltip'; 
				attributeAt: 'data-mdl-for' put: ((dictToRenderDownloadButton at: 'id') value: aObject) ;
				with: 'Download invoice'].
]

{ #category : #rendering }
ERTable >> renderTotalRows: html [
	html heading
		level: levelTotal;
		with: [ html strong: 'Total: '.
			html text: rows size asString ]
]

{ #category : #sorting }
ERTable >> sortCollectionwith: aSelector OnRowIndex: aRowIndex [
	| method cellValue anotherCellValue |
	
	self filteredRows
		sort: [ :cell :anotherCell |
			method := (self sortingMethod at: aRowIndex).
			cellValue := method value: cell.
			anotherCellValue := method value: anotherCell.
			[
				cellValue
				perform: aSelector
				with: anotherCellValue ]
				on: MessageNotUnderstood
				do: [ true ] ]
]

{ #category : #accessing }
ERTable >> sortingMethod [

	^ sortingMethod
]

{ #category : #accessing }
ERTable >> sortingMethod: aCollection [

	sortingMethod := aCollection
]

{ #category : #'rendering-searching' }
ERTable >> validateFilterOf: aObject [

	^ self validation value: aObject value: self searchingText
]

{ #category : #accessing }
ERTable >> validation [

	^ validation
]

{ #category : #accessing }
ERTable >> validation: aObject [

	validation := aObject
]
