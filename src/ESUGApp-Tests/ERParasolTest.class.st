Class {
	#name : #ERParasolTest,
	#superclass : #ERTest,
	#instVars : [
		'driver',
		'acceptFormButton'
	],
	#category : #'ESUGApp-Tests-Parasol'
}

{ #category : #accessing }
ERParasolTest class >> defaultTimeLimit [
	^ 1 minute
]

{ #category : #accessing }
ERParasolTest >> baseURL [
	"URL of ESUG App"

	^ 'http://localhost:8000/ESUG/'
]

{ #category : #actions }
ERParasolTest >> clickElementWithID: aString [
	(driver findElementByID: aString) click.
]

{ #category : #actions }
ERParasolTest >> createDownloadDirectory [
	('Download' asFileReference)
		 ensureCreateDirectory
]

{ #category : #actions }
ERParasolTest >> downloadFileOf: href to: directory [

	[ 
	ZnClient new
		url: (self baseURL withoutSuffix: 'ESUG/') , href;
		downloadTo: directory.
	(Delay forSeconds: 2) wait ]
		on: Exception
		do: [ self assert: false ]
]

{ #category : #messages }
ERParasolTest >> getTextErrorOf: anID [
	^ (driver findElementByID:  anID,'-error') getText
]

{ #category : #messages }
ERParasolTest >> getTextOfError [
	^ (((driver findElementByClassName: 'errors')findElementByTagName: 'ul')findElementByTagName: 'li') getText
]

{ #category : #messages }
ERParasolTest >> messageIsRequiredFor: aString [
	^  aString ,' (Required): Input is required but no input given'
]

{ #category : #messages }
ERParasolTest >> messageOnlyTextIsAcceptedFor: aString [
	^  aString ,' (Required): This field only accept a text'
]

{ #category : #actions }
ERParasolTest >> pressOptionAdmin [
	self clickElementWithID: 'My Account-option'
]

{ #category : #actions }
ERParasolTest >> selectElementWithID: aString1 send: aString2 [
	|element|
	element := driver findElementByID: aString1.
	element sendKeys: aString2
]

{ #category : #running }
ERParasolTest >> setUp [

	super setUp.
	BPRemoteWebDriver serverHost: 'selenium'.
	driver := BPRemoteWebDriver withCapabilities: BPChromeOptions new.
	driver get: self baseURL
]

{ #category : #running }
ERParasolTest >> tearDown [
	
	self deleteDownloadFolderIfExist.
	driver ifNotNil: #quit.
	super tearDown
]

{ #category : #actions }
ERParasolTest >> textOfElementWithID: aString [
	^ (driver findElementByID: aString) getText
]

{ #category : #actions }
ERParasolTest >> textOfElementWithID: aString1 andTagName: aString2 [
	^ ((driver findElementByID: aString1) findElementByTagName: aString2) getText
]

{ #category : #actions }
ERParasolTest >> textOfTagName: aString [
	^ (driver findElementByTagName: aString) getText
]

{ #category : #actions }
ERParasolTest >> updateField: anID with: aString [
	| confName |
	confName := driver findElementByID: anID.
	confName clear.
	confName sendKeys: aString.
	self clickElementWithID: acceptFormButton.
]
