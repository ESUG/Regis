"
Description
--------------------

I am a model of an Attendee, an attendee is a composition of: ERUserAccount, ERContactInformation, ERRegisterConferenceInformation , ERAdditionalInformation , ERPaymentInformation , ERAffiliationInformation 
"
Class {
	#name : #ERAttendee,
	#superclass : #ERRegisteredObject,
	#instVars : [
		'userAccount',
		'conferenceInformation',
		'additionalInformation',
		'idGroup',
		'classId'
	],
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #accessing }
ERAttendee class >> countries [
	^ #('United States' 'United Kingdom' 'Afghanistan' 'Albania' 'Algeria' 'American Samoa' 'Andorra' 'Angola' 'Anguilla' 'Antarctica' 'Antigua and Barbuda' 'Argentina' 'Armenia' 'Aruba' 'Australia' 'Austria' 'Azerbaijan' 'Bahamas' 'Bahrain' 'Bangladesh' 'Barbados' 'Belarus' 'Belgium' 'Belize' 'Benin' 'Bermuda' 'Bhutan' 'Bolivia' 'Bosnia and Herzegovina' 'Botswana' 'Bouvet Island' 'Brazil' 'British Indian Ocean Territory' 'Brunei Darussalam' 'Bulgaria' 'Burkina Faso' 'Burundi' 'Cambodia' 'Cameroon' 'Canada' 'Cape Verde' 'Cayman Islands' 'Central African Republic' 'Chad' 'Chile' 'China' 'Christmas Island' 'Cocos (Keeling) Islands' 'Colombia' 'Comoros' 'Congo' 'Congo, The Democratic Republic of The' 'Cook Islands' 'Costa Rica' 'Cote D'' ivoire' 'Croatia' 'Cuba' 'Cyprus' 'Czech Republic' 'Denmark' 'Djibouti' 'Dominica' 'Dominican Republic' 'Ecuador' 'Egypt' 'El Salvador' 'Equatorial Guinea' 'Eritrea' 'Estonia' 'Ethiopia' 'Falkland Islands Malvinas' 'Faroe Islands' 'Fiji' 'Finland' 'France' 'French Guiana' 'French Polynesia' 'French Southern Territories' 'Gabon' 'Gambia' 'Georgia' 'Germany' 'Ghana' 'Gibraltar' 'Greece' 'Greenland' 'Grenada' 'Guadeloupe' 'Guam' 'Guatemala' 'Guinea' 'Guinea - bissau' 'Guyana' 'Haiti' 'Heard Island and Mcdonald Islands' 'Holy See Vatican City State' 'Honduras' 'Hong Kong' 'Hungary' 'Iceland' 'India' 'Indonesia' 'Iran , Islamic Republic of' 'Iraq' 'Ireland' 'Israel' 'Italy' 'Jamaica' 'Japan' 'Jordan' 'Kazakhstan' 'Kenya' 'Kiribati' 'Korea , Democratic People ''s Republic of' 'Korea, Republic of' 'Kuwait' 'Kyrgyzstan' 'Lao People''s Democratic Republic' 'Latvia' ' Lebanon' 'Lesotho' 'Liberia' 'Libyan Arab Jamahiriya' 'Liechtenstein' 'Lithuania' 'Luxembourg' 'Macao' 'Macedonia , The Former Yugoslav Republic of' 'Madagascar' ' Malawi ' ' Malaysia ' ' Maldives ' ' Mali ' ' Malta ' ' Marshall Islands ' ' Martinique ' ' Mauritania ' ' Mauritius ' ' Mayotte ' ' Mexico ' ' Micronesia , Federated States of ' ' Moldova , Republic of ' ' Monaco ' ' Mongolia ' ' Montserrat ' ' Morocco ' ' Mozambique ' ' Myanmar ' ' Namibia ' ' Nauru ' ' Nepal ' ' Netherlands ' ' Netherlands Antilles ' ' New Caledonia ' ' New Zealand ' ' Nicaragua ' ' Niger ' ' Nigeria ' ' Niue ' ' Norfolk Island ' ' Northern Mariana Islands ' ' Norway ' ' Oman ' ' Pakistan ' ' Palau ' ' Palestinian Territory , Occupied ' ' Panama ' ' Papua New Guinea ' ' Paraguay ' ' Peru ' ' Philippines ' ' Pitcairn ' ' Poland ' ' Portugal ' ' Puerto Rico ' ' Qatar ' ' Reunion ' ' Romania ' ' Russian Federation ' ' Rwanda ' ' Saint Helena ' ' Saint Kitts and Nevis ' ' Saint Lucia ' ' Saint Pierre and Miquelon ' ' Saint Vincent and The Grenadines ' ' Samoa ' ' San Marino ' ' Sao Tome and Principe ' ' Saudi Arabia ' ' Senegal ' ' Serbia and Montenegro ' ' Seychelles ' ' Sierra Leone ' ' Singapore ' ' Slovakia ' ' Slovenia ' ' Solomon Islands ' ' Somalia ' ' South Africa ' ' South Georgia and The South Sandwich Islands ' ' Spain ' ' Sri Lanka ' ' Sudan ' ' Suriname ' ' Svalbard and Jan Mayen ' ' Swaziland ' ' Sweden ' ' Switzerland ' ' Syrian Arab Republic ' ' Taiwan , Province of China ' ' Tajikistan ' ' Tanzania , United Republic of ' ' Thailand ' ' Timor - leste ' ' Togo ' ' Tokelau ' ' Tonga ' ' Trinidad and Tobago ' ' Tunisia ' ' Turkey ' ' Turkmenistan ' ' Turks and Caicos Islands ' ' Tuvalu ' ' Uganda ' ' Ukraine ' ' United Arab Emirates ' ' United Kingdom ' ' United States ' ' United States Minor Outlying Islands ' ' Uruguay ' ' Uzbekistan ' ' Vanuatu ' ' Venezuela ' ' Viet Nam ' ' Virgin Islands , British ' ' Virgin Islands , U.S.' ' Wallis and Futuna ' ' Western Sahara ' ' Yemen ' ' Zambia ' ' Zimbabwe ')
]

{ #category : #accessing }
ERAttendee class >> days [
	^ #('monday' 'tuesday' 'wednesday' 'thursday' 'friday')
]

{ #category : #accessing }
ERAttendee class >> roles [
	^ #('admin' 'attendee' 'groupManager' 'studentVolunter')
]

{ #category : #accessing }
ERAttendee class >> rolesForAdminRegister [

	^ #('Administrator' 'Student Volunteer')
]

{ #category : #accessing }
ERAttendee >> additionalInformation [
	additionalInformation classId: classId.
	^ additionalInformation
]

{ #category : #accessing }
ERAttendee >> additionalInformation: anObject [
	additionalInformation := anObject
]

{ #category : #accessing }
ERAttendee >> classId: anId [

	classId := anId
]

{ #category : #accessing }
ERAttendee >> conferenceInformation [
	conferenceInformation classId: classId.
	^ conferenceInformation
]

{ #category : #accessing }
ERAttendee >> conferenceInformation: anObject [
	conferenceInformation := anObject
]

{ #category : #addRole }
ERAttendee >> convertToStudentVolunter [
	self userAccount isStudent ifFalse:[
	(self userAccount) roleAdd: 'studentVolunter'; save]
]

{ #category : #accessing }
ERAttendee >> daysOfAssistance [

	"We set the friday to false, as there is no friday. This is a problem when there are registers already generated"
	self conferenceInformation attendance at: #friday put: false.
	^ self conferenceInformation attendance values count: [ :each | each ]
]

{ #category : #accessing }
ERAttendee >> descriptionAdd [
	<magritteDescription>
	| tmp1 |
	tmp1 := MAClassDescription new .
	tmp1
		accessor: #additionalInformation ;
		label: 'add';
		priority: 100;
		required: true.
	^ tmp1 yourself
]

{ #category : #accessing }
ERAttendee >> descriptionUser [
	<magritteDescription>
	| tmp1 |
	tmp1 := MAClassDescription new .
	tmp1
		accessor: #userAccount;
		label: 'user';
		priority: 10;
		required: true.
	^ tmp1 yourself
]

{ #category : #accessing }
ERAttendee >> firstName [ 
	^ userAccount firstName
]

{ #category : #accessing }
ERAttendee >> hasCoupon [
	self paymentInformation coupon isNil 
	ifFalse: [ self paymentInformation coupon isEmpty 
		ifTrue:[^ false ]]
	ifTrue: [ ^ false ].
	^ true
]

{ #category : #accessing }
ERAttendee >> idGroup [
	^ idGroup
]

{ #category : #accessing }
ERAttendee >> idGroup: anObject [
	idGroup := anObject
]

{ #category : #initialization }
ERAttendee >> initialize [ 
	super initialize.
	userAccount := ERUserAccount new.
	conferenceInformation := ERRegisterConferenceInformation new.
	additionalInformation := ERAdditionalInformation new
]

{ #category : #'accessing-state' }
ERAttendee >> isAbleToModifyRegister [
	^ paymentInformation hasPaid
]

{ #category : #'accessing-state' }
ERAttendee >> isAbleToPay [
	^ (idGroup isNotNil) or: (paymentInformation hasPaid)
]

{ #category : #accessing }
ERAttendee >> lastName [ 
	^ userAccount lastName
]

{ #category : #accessing }
ERAttendee >> organizationAddress1 [
	^ affiliationInformation organizationAddrees1 
]

{ #category : #accessing }
ERAttendee >> organizationAddress2 [
	^ affiliationInformation organizationAddrees2
]

{ #category : #accessing }
ERAttendee >> organizationCity [ 	
	^ affiliationInformation organizationCity 
]

{ #category : #accessing }
ERAttendee >> organizationCountry [
	^ affiliationInformation organizationCountry
]

{ #category : #accessing }
ERAttendee >> organizationName [
	^ affiliationInformation organizationName
]

{ #category : #accessing }
ERAttendee >> organizationPostal [
	^ affiliationInformation organizationPostal 
]

{ #category : #printing }
ERAttendee >> printOn: aStream [

	super printOn: aStream.

	self userAccount firstName ifNotNil: [ :n | 
		aStream
			nextPutAll: ' [';
			nextPutAll: n;
			nextPut: $] ]
]

{ #category : #deleteRole }
ERAttendee >> removeStudentVolunterRole [
	self userAccount isStudent ifTrue: [
	(self userAccount) deleteRole: 'studentVolunter'; save. ]
]

{ #category : #updating }
ERAttendee >> updateValuesFor: aGroup [
	self paymentInformation invoiceNumber: aGroup paymentInformation invoiceNumber.
	self idGroup: aGroup id.
]

{ #category : #accessing }
ERAttendee >> userAccount [
	userAccount classId: classId.
	^ userAccount
]

{ #category : #accessing }
ERAttendee >> userAccount: anObject [
	userAccount := anObject
]
