"
Description
--------------------

I am a model of Information of conference preferences of an Attendee, such as: size of T-shirts, food preference, go to social dinner, add person to social dinner, days of assistance
"
Class {
	#name : #ERRegisterConferenceInformation,
	#superclass : #Object,
	#instVars : [
		'attendance',
		'gender',
		'tshirtSize',
		'foodPreference',
		'attendSocialEvent',
		'addedToMainList',
		'addPersonToSocialDinner',
		'personAddedFoodPreference',
		'id',
		'classId'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #'as yet unclassified' }
ERRegisterConferenceInformation class >> foodPreferences [
	^ #('Normal' 'Vegan' 'Vegetarian')
]

{ #category : #accessing }
ERRegisterConferenceInformation class >> genders [
	^ #('Male' 'Female')
]

{ #category : #'as yet unclassified' }
ERRegisterConferenceInformation class >> tShirtSizes [
	^ #('No thanks' 'XS' 'S' 'M' 'L' 'XL' 'XXL' 'XXXL' 'XXXXL')
]

{ #category : #adding }
ERRegisterConferenceInformation >> addMyPreferenceForLuchTo: aDictionary [
	aDictionary keysDo: [ :key | (self perform: key) 
		ifTrue: [ 
			(aDictionary at: key) at: foodPreference put: ((aDictionary at: key) at: foodPreference) + 1 ] ] .
	^ aDictionary 
]

{ #category : #adding }
ERRegisterConferenceInformation >> addMyPreferenceForSocialDinnerTo: aDictionary [
	self addPersonToSocialDinner ifTrue: [ aDictionary at: personAddedFoodPreference put: (aDictionary at: personAddedFoodPreference) + 1 ].
	self attendSocialEvent ifTrue: [ aDictionary at: foodPreference put: (aDictionary at: foodPreference) + 1 ].
	^ aDictionary 
]

{ #category : #adding }
ERRegisterConferenceInformation >> addMytShirtTo: aDictionary [
	(aDictionary at: tshirtSize) at: gender put: ((aDictionary at: tshirtSize) at: gender) + 1.
	^ aDictionary 
]

{ #category : #accessing }
ERRegisterConferenceInformation >> addPersonToSocialDinner [
	^ addPersonToSocialDinner
]

{ #category : #accessing }
ERRegisterConferenceInformation >> addPersonToSocialDinner: anObject [
	addPersonToSocialDinner := anObject
]

{ #category : #accessing }
ERRegisterConferenceInformation >> addedToMainList [
	^ addedToMainList
]

{ #category : #accessing }
ERRegisterConferenceInformation >> addedToMainList: anObject [
	addedToMainList := anObject
]

{ #category : #accessing }
ERRegisterConferenceInformation >> attendSocialEvent [
	^ attendSocialEvent
]

{ #category : #accessing }
ERRegisterConferenceInformation >> attendSocialEvent: anObject [
	attendSocialEvent := anObject
]

{ #category : #accessing }
ERRegisterConferenceInformation >> attendance [
	^ attendance
]

{ #category : #accessing }
ERRegisterConferenceInformation >> attendance: anObject [
	attendance := anObject
]

{ #category : #accessing }
ERRegisterConferenceInformation >> classId: anId [

	classId := anId
]

{ #category : #accessing }
ERRegisterConferenceInformation >> daysOfAssistance [
	| aString |
	aString := ''.
	#(#monday #tuesday #wednesday #thursday "#friday")
		do: [ :each | 
			(self perform: each)
				ifTrue: [ aString isEmpty
						ifTrue: [ aString := each asString capitalized ]
						ifFalse: [ aString :=  aString , ', ' , each asString capitalized ] ] ].
	^ aString
]

{ #category : #'magrittes-descriptions' }
ERRegisterConferenceInformation >> descriptionAddPersonToSocialDinner [
	<magritteDescription>
	| tmp2 |
	tmp2 := MABooleanDescription new.
	tmp2 
		checkboxLabel: 'Check if you add a person to the Social Dinner';
		accessor: #addPersonToSocialDinner;
		beRequired ;
		componentClass: MDLMACheckboxComponent;
		priority: 120;
		withoutLabel: true.
	classId
		ifNil: [ tmp2 id: 'addPersonToSocialDinner' ]
		ifNotNil: [ tmp2 id: 'addPersonToSocialDinner', classId printString ].
	^ tmp2 yourself
]

{ #category : #'magrittes-descriptions' }
ERRegisterConferenceInformation >> descriptionAddedToMainList [
	<magritteDescription>
	| tmp2 |
	tmp2 := MABooleanDescription new.
	tmp2 
		checkboxLabel: 'Check if you want to be added to the Mailling List';
		accessor: #addedToMainList;
		beRequired;
		componentClass: MDLMACheckboxComponent;
		priority: 110;
		withoutLabel: true.
	classId
		ifNil: [ tmp2 id: 'addedToMainList' ]
		ifNotNil: [ tmp2 id: 'addedToMainList', classId printString ].
	^ tmp2 yourself
]

{ #category : #'magrittes-descriptions' }
ERRegisterConferenceInformation >> descriptionAttendSocialEvent [
	<magritteDescription>
	| tmp2 |
	tmp2 := MABooleanDescription new.
	tmp2 
		checkboxLabel: 'Check if you will you go to the social Event';
		accessor: #attendSocialEvent;
		beRequired ;
		componentClass: MDLMACheckboxComponent;
		priority: 100;
		withoutLabel: true.
	classId
		ifNil: [ tmp2 id: 'attendSocialEvent' ]
		ifNotNil: [ tmp2 id: 'attendSocialEvent', classId printString ].
	^ tmp2 yourself
]

{ #category : #'magrittes-descriptions' }
ERRegisterConferenceInformation >> descriptionFood [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #foodPreference;
		priority: 80;
		required: true;
		cssClass: 'third';
		default: 'Normal';
		options: self class foodPreferences;
		withoutLabel: true;
		componentClass: MDLMASelectListComponent.
	classId
		ifNil: [ tmp1 id: 'foodPreference' ]
		ifNotNil: [ tmp1 id: 'foodPreference', classId printString ].
	^ tmp1 yourself
]

{ #category : #'magrittes-descriptions' }
ERRegisterConferenceInformation >> descriptionFoodPreferenceOfExtraPerson [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #personAddedFoodPreference;
		priority: 130;
		required: true;
		default: 'Normal';
		options: self class foodPreferences;
		withoutLabel: true;
		componentClass: MDLMASelectListComponent.
	classId
		ifNil: [ tmp1 id: 'personAddedFoodPreference' ]
		ifNotNil: [ tmp1 id: 'personAddedFoodPreference', classId printString ].
	^ tmp1 yourself
]

{ #category : #'magrittes-descriptions' }
ERRegisterConferenceInformation >> descriptionFriday [
"	<magritteDescription>
"	| tmp2 |
	tmp2 := MABooleanDescription new.
	tmp2 
		checkboxLabel: 'Friday';
		accessor: #friday;
		componentClass: MDLMACheckboxComponent;
		priority: 50;
		withoutLabel: true.
	classId
		ifNil: [ tmp2 id: 'friday' ]
		ifNotNil: [ tmp2 id: 'friday', classId printString ].
	^ tmp2 yourself
]

{ #category : #'magrittes-descriptions' }
ERRegisterConferenceInformation >> descriptionGender [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #gender;
		priority: 60;
		required: true;
		cssClass: 'third';
		options: self class genders;
		withoutLabel: true;
		componentClass: MDLMASelectListComponent.
	classId
		ifNil: [ tmp1 id: 'gender' ]
		ifNotNil: [ tmp1 id: 'gender', classId printString ].
	^ tmp1 yourself
]

{ #category : #'magrittes-descriptions' }
ERRegisterConferenceInformation >> descriptionMonday [
	<magritteDescription>
	| tmp2 |
	tmp2 := MABooleanDescription new.
	tmp2 
		checkboxLabel: 'Monday';
		accessor: #monday;
		group: 'Days: ';
		componentClass: MDLMACheckboxComponent;
		priority: 10;
		withoutLabel: true.
	classId
		ifNil: [ tmp2 id: 'monday' ]
		ifNotNil: [ tmp2 id: 'monday', classId printString ].
	^ tmp2 yourself
]

{ #category : #'magrittes-descriptions' }
ERRegisterConferenceInformation >> descriptionThursday [
	<magritteDescription>
	| tmp2 |
	tmp2 := MABooleanDescription new.
	tmp2 
		checkboxLabel: 'Thursday';
		accessor: #thursday;
		componentClass: MDLMACheckboxComponent;
		priority: 40;
		withoutLabel: true.
	classId
		ifNil: [ tmp2 id: 'thursday' ]
		ifNotNil: [ tmp2 id: 'thursday', classId printString ].
	^ tmp2 yourself
]

{ #category : #'magrittes-descriptions' }
ERRegisterConferenceInformation >> descriptionTshirtSize [
	<magritteDescription>
	| tmp1 |
	tmp1 := MASingleOptionDescription new.
	tmp1
		accessor: #tshirtSize;
		priority: 70;
		required: true;
		cssClass: 'third';
		default: 'L';
		options: self class tShirtSizes;
		withoutLabel: true;
		componentClass: MDLMASelectListComponent.
	classId
		ifNil: [ tmp1 id: 'tshirtSize' ]
		ifNotNil: [ tmp1 id: 'tshirtSize', classId printString ].
	^ tmp1 yourself
]

{ #category : #'magrittes-descriptions' }
ERRegisterConferenceInformation >> descriptionTuesday [
	<magritteDescription>
	| tmp2 |
	tmp2 := MABooleanDescription new.
	tmp2 
		checkboxLabel: 'Tuesday';
		accessor: #tuesday;
		componentClass: MDLMACheckboxComponent;
		priority: 20;
		withoutLabel: true.
	classId
		ifNil: [ tmp2 id: 'tuesday' ]
		ifNotNil: [ tmp2 id: 'tuesday', classId printString ].
	^ tmp2 yourself
]

{ #category : #'magrittes-descriptions' }
ERRegisterConferenceInformation >> descriptionWednesday [
	<magritteDescription>
	| tmp2 |
	tmp2 := MABooleanDescription new.
	tmp2 
		checkboxLabel: 'Wednesday';
		accessor: #wednesday;
		componentClass: MDLMACheckboxComponent;
		priority: 30;
		withoutLabel: true.
	classId
		ifNil: [ tmp2 id: 'wednesday' ]
		ifNotNil: [ tmp2 id: 'wednesday', classId printString ].
	^ tmp2 yourself
]

{ #category : #accessing }
ERRegisterConferenceInformation >> foodPreference [
	^ foodPreference
]

{ #category : #accessing }
ERRegisterConferenceInformation >> foodPreference: anObject [
	foodPreference := anObject
]

{ #category : #initialization }
ERRegisterConferenceInformation >> friday [
	^ self attendance at: 'friday'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> friday: aBoolean [
	self attendance at: 'friday' put: aBoolean
]

{ #category : #accessing }
ERRegisterConferenceInformation >> gender [
	^ gender
]

{ #category : #accessing }
ERRegisterConferenceInformation >> gender: anObject [
	gender := anObject
]

{ #category : #accessing }
ERRegisterConferenceInformation >> id: anObject [

	id := anObject
]

{ #category : #initialization }
ERRegisterConferenceInformation >> initialize [
	super initialize.
	foodPreference :=  'Normal'.
	gender :='Male'.
	tshirtSize :='XS'.
	self attendSocialEvent: true.
	self addedToMainList: true.
	self addPersonToSocialDinner: false.
	self gender: 'Male'.
	self
		attendance:
			(Dictionary
				newFrom:
					{('monday' -> true).
					('tuesday' -> true).
					('wednesday' -> true).
					('thursday' -> true).
					('friday' -> true)})
]

{ #category : #initialization }
ERRegisterConferenceInformation >> isFemale [
	^ gender = 'Female'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> isMale [
	^ gender = 'Male'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> isNormal [
	^ foodPreference ='Normal' 
]

{ #category : #initialization }
ERRegisterConferenceInformation >> isNormal: aString [
	^ aString ='Normal' 
]

{ #category : #initialization }
ERRegisterConferenceInformation >> isVegan [
	^ foodPreference = 'Vegan'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> isVegan: aString [
	^ aString = 'Vegan'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> isVegetarian [
	^ foodPreference =  'Vegetarian'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> isVegetarian: aString [
	^ aString =  'Vegetarian'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> monday [
	^ self attendance at: 'monday'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> monday: aBoolean [
	self attendance at: 'monday' put: aBoolean
]

{ #category : #accessing }
ERRegisterConferenceInformation >> personAddedFoodPreference [
	^ personAddedFoodPreference
]

{ #category : #accessing }
ERRegisterConferenceInformation >> personAddedFoodPreference: anObject [
	personAddedFoodPreference := anObject
]

{ #category : #initialization }
ERRegisterConferenceInformation >> thursday [
	^ self attendance at: 'thursday'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> thursday: aBoolean [
	self attendance at: 'thursday' put: aBoolean
]

{ #category : #accessing }
ERRegisterConferenceInformation >> tshirtSize [
	^ tshirtSize
]

{ #category : #accessing }
ERRegisterConferenceInformation >> tshirtSize: anObject [
	tshirtSize := anObject
]

{ #category : #initialization }
ERRegisterConferenceInformation >> tuesday [
	^ self attendance at: 'tuesday'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> tuesday: aBoolean [
	self attendance at: 'tuesday' put: aBoolean
]

{ #category : #initialization }
ERRegisterConferenceInformation >> wednesday [
	^ self attendance at: 'wednesday'
]

{ #category : #initialization }
ERRegisterConferenceInformation >> wednesday: aBoolean [
	self attendance at: 'wednesday' put: aBoolean
]
