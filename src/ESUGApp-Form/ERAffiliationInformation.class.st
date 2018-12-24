Class {
	#name : #ERAffiliationInformation,
	#superclass : #ERForm,
	#category : #'ESUGApp-Form'
}

{ #category : #'as yet unclassified' }
ERAffiliationInformation >> formId [
	^ 'affiliationInfoForm'
]

{ #category : #'as yet unclassified' }
ERAffiliationInformation >> formName [
	^ 'Affiliation'
]

{ #category : #rendering }
ERAffiliationInformation >> renderContentOn: html [
	self
		createTextField: 'Organization Name:'
		for: #orgName:
		with: #orgName
		on: html.
	self
		createTextField: 'Address1'
		for: #orgAddrees1:
		with: #orgAddrees1
		percent: 49
		on: html.
	self
		createTextField: 'Address2'
		for: #orgAddrees2:
		with: #orgAddrees2
		percent: 49
		on: html.
	self
		createTextField: 'City'
		for: #orgCity:
		with: #orgCity
		percent: 49
		on: html.
	self
		createSelectField: 'Country'
		for: #orgCountry:
		with: #orgCountry
		list: ERAttendee countries
		percent: 49
		on: html.
	self
		createTextField: 'Province/State'
		for: #orgProvince:
		with: #orgProvince
		percent: 49
		on: html.
	self
		createTextField: 'Postal/Zipcode'
		for: #orgPostal:
		with: #orgPostal
		percent: 49
		on: html.
	self
		createSelectField: 'Membership Type'
		for: #membershipType:
		with: #membershipType
		list: ERAttendee membershipTypes
		on: html
]