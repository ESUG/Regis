"
Description
--------------------s

A ERTestConfigurationController is a test class for testing the behavior of Configuration Controller
"
Class {
	#name : #ERConfigurationControllerTest,
	#superclass : #ERTest,
	#instVars : [
		'fileNames'
	],
	#category : #'ESUGApp-Tests-UnitTest'
}

{ #category : #accessing }
ERConfigurationControllerTest >> csvFileNames [
	^ #('attendees.cvs' 'awards.cvs' 'groupManagers.cvs' 'talks.cvs' 'users.cvs')
]

{ #category : #actions }
ERConfigurationControllerTest >> deleteFiles [

	fileNames do: [ :each | (File named: each) delete ]
]

{ #category : #accessing }
ERConfigurationControllerTest >> idOfAdmin [
	^ (controller conference findUserByEmail: 'admin@esug.org') id asString
]

{ #category : #running }
ERConfigurationControllerTest >> setUp [

	super setUp.
	controller := ERConfigurationController new.
	fileNames := self csvFileNames
]

{ #category : #running }
ERConfigurationControllerTest >> tearDown [

	self deleteFiles.
	super tearDown
]

{ #category : #tests }
ERConfigurationControllerTest >> testExportAttends [
	| aFile |
	aFile := controller conference exportAttends: 'attendees'.
	self assert: aFile equals: '"InvoiceNumber","FirstName","LastName","Email","Country","Org. Name"', String crlf
]

{ #category : #tests }
ERConfigurationControllerTest >> testExportAwards [
	
	| aFile |
	aFile := controller conference exportAwards: 'awards'.
	self assert: aFile equals: '"Name","Submitted by","Other Developers","Affiliation","Country","Dialect","Keywords","Licence","Download Url","Demo Url","Submittion Date"', String crlf
]

{ #category : #tests }
ERConfigurationControllerTest >> testExportGroupManagers [
	
	| aFile |
	aFile := controller conference exportGroupManagers: 'groupManagers'.
	self assert: aFile equals: '"Invoice Number","First Name","Last Name","Email","Org. Name","Org. Address1","Org. City","Org. Country","Org. Postal","Org. Membership"', String crlf
]

{ #category : #tests }
ERConfigurationControllerTest >> testExportTalks [
	
	| aFile |
	aFile := controller conference exportTalks: 'talks'.
	self assert: aFile equals: '"Name","Submitted By","Uploaded File"', String crlf 
]

{ #category : #tests }
ERConfigurationControllerTest >> testExportUsers [
	| aFile |
	aFile := controller conference exportUsers: 'users'.
	self assert: aFile equals: '"id","firstName","lastName","email","password","role"',
	String crlf,
'"',self idOfAdmin,'","Admin","Admin","admin@esug.org","|""/²}ò/Y!4è$c|
"," admin"', String crlf
]