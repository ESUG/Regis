"
Description
-----------------------------------

I am a model of ERPDFInvoice, I generate a pdf document of invoive of an attendee.

Example
-----------------------------------

ERPDFInvoice pdfDocOf: groupOrAttendee.

this script generate a invoice file of an attendee
"
Class {
	#name : #ERPDFInvoice,
	#superclass : #Object,
	#instVars : [
		'controller'
	],
	#classInstVars : [
		'demoPath'
	],
	#category : #'ESUGApp-Model'
}

{ #category : #tool }
ERPDFInvoice class >> demoPath [
	^ demoPath ifNil: ['pdf/']
]

{ #category : #accessing }
ERPDFInvoice class >> demoPath: aString [
	demoPath := aString
]

{ #category : #'as yet unclassified' }
ERPDFInvoice class >> pdfDocOf: user [
	<script>
	| nameFile |
	nameFile := 'RegistrationInvoice_', user id, '.pdf'.
	^ self new templateRegistrationInvoice: (self streamNamed: nameFile) of: user
]

{ #category : #tool }
ERPDFInvoice class >> streamNamed: aName [

	^ (FileSystem memory / aName) binaryWriteStream
]

{ #category : #'as yet unclassified' }
ERPDFInvoice class >> templateRegistrationInvoice: user [
	<script>
	| nameFile |
	nameFile := 'RegistrationInvoice_', user id, '.pdf'.
	self new templateRegistrationInvoice: (self streamNamed: nameFile) of: user.
	^ (self demoPath, nameFile) asFileReference
]

{ #category : #adding }
ERPDFInvoice >> addBorder: pdfPage [
	pdfPage add: (self lineElementFrom: 20 mm @ 115 mm to: 190 mm @ 115 mm);
	add: (self lineElementFrom: 20 mm @ 121 mm to: 190 mm @ 121 mm);
	add: (self lineElementFrom: 20 mm @ 115 mm to: 20 mm @ 137 mm);
	add: (self lineElementFrom: 20 mm @ 137 mm to: 190 mm @ 137 mm);
	add: (self lineElementFrom: 190 mm @ 115 mm to: 190 mm @ 137 mm);
	add: (self lineElementFrom: 20 mm @ 142 mm to: 190 mm @ 142 mm);
	add: (self lineElementFrom: 20 mm @ 157 mm to: 190 mm @ 157 mm);
	add: (self lineElementFrom: 20 mm @ 142 mm to: 20 mm @ 157 mm);
	add: (self lineElementFrom: 190 mm @ 142 mm to: 190 mm @ 157 mm).
]

{ #category : #adding }
ERPDFInvoice >> addDateInvoice: aPage [
	| fontInvoice |
	fontInvoice := PDFTimesFont size: 25pt.
	fontInvoice bold: true.
	aPage add: (PDFFormattedTextElement new
		textColor: self colorTitle;
		font: fontInvoice;
		dimension: 190 mm @ 20 mm;
		from: 0 mm @ 35 mm;
		text: 'Invoice';
		alignment: PDFAlignment right);
	add: (PDFFormattedTextElement new
		font: self fontContent;
		dimension: 190 mm @ 20 mm;
		from: 0 mm @ 48 mm;
		text: self dateToday;
		alignment: PDFAlignment right).
]

{ #category : #accessing }
ERPDFInvoice >> addFooter: pdfPage [
	pdfPage add: (PDFTextElement new
		textColor: self colorTitle;
		font: self fontFooter;
		from: 20 mm @ 276 mm;
		text: controller conference configuration organizer name);
	add: (PDFTextElement new
		textColor: self colorLink;
		font: self fontFooter;
		from: 20 mm @ 280 mm;
		text: controller conference configuration organizer webPageUrl);
	add: (PDFFormattedTextElement new
		textColor: self colorTitle;
		font: self fontFooter;
		dimension: 190 mm @ 3 mm;
		from: 0 mm @ 272 mm;
		text: controller conference configuration organizer fiscalSituation;
		alignment: PDFAlignment right);
	add: (PDFFormattedTextElement new
		font: self fontFooter;
		textColor: self colorTitle;
		dimension: 190 mm @ 3 mm;
		from: 0 mm @ 276 mm;
		text: controller conference configuration organizer addressString;
		alignment: PDFAlignment right).
]

{ #category : #adding }
ERPDFInvoice >> addHeader: aPage [
	self addInfoESUG: aPage.
	self addDateInvoice: aPage.
]

{ #category : #adding }
ERPDFInvoice >> addInfoESUG: aPage [
	| fontHeader |
	fontHeader := PDFTimesFont size: 10pt.
	aPage add: (PDFTextElement new
		textColor: self colorTitle;
		font: fontHeader;
		from: 20 mm @ 45 mm;
		text: 'European Smalltalk User Group (ESUG)');
	add: (PDFTextElement new
		textColor: self colorTitle;
		font: fontHeader;
		from: 20 mm @ 49 mm;
		text: 'Association Loi 1901 n W751167780');
	add: (PDFTextElement new
		textColor: self colorTitle;
		font: fontHeader;
		from: 20 mm @ 53 mm;
		text: 'c/o Mr. Stéphane Ducasse');
	add: (PDFTextElement new
		textColor: self colorTitle;
		font: fontHeader;
		from: 20 mm @ 57 mm;
		text: '1 rue Cesar Franck');
	add: (PDFTextElement new
		textColor: self colorTitle;
		font: fontHeader;
		from: 20 mm @ 61 mm;
		text: '59800 Lille');
	add: (PDFTextElement new
		textColor: self colorTitle;
		font: fontHeader;
		from: 20 mm @ 65 mm;
		text: 'France');
	add: (PDFTextElement new
		textColor: self colorLink;
		font: fontHeader;
		from: 20 mm @ 69 mm;
		text: 'http://www.esug.org').
]

{ #category : #adding }
ERPDFInvoice >> addInfoInvoice: pdfPage of: user [

	| fullname listOfPosition registeredName |
	user organizationAddress2  
		ifNotNil: [ listOfPosition := #(70 75 80 85 90 95) ]
		ifNil: [ listOfPosition := #(70 75 nil 80 85 90) ].

	fullname := (self encode: user organizationName).
	registeredName := self encode: user lastName , ', ' , user firstName. 

	pdfPage add: (PDFTextElement new
		textColor: self colorTitle;
		font: self fontContent;
		from: 20 mm @ 82 mm;
		text: 'Invoice No.');
	add: (PDFTextElement new
		font: self fontContent;
		from: 45 mm @ 82 mm;
		text: user invoiceNumber);
	add: (PDFFormattedTextElement new
		textColor: self colorTitle;
		font: self fontContent;
		dimension: (190-'Bill to:' size-(fullname size*1.9) ) mm @ (listOfPosition at: 1) mm;
		from: 0 mm @ ((listOfPosition at: 1) + 8) mm;
		text: 'Bill to:';
		alignment: (PDFAlignment right));
	add: (PDFFormattedTextElement new
		font: self fontContent;
		dimension: 190 mm @ (listOfPosition at: 1) mm;
		from: 0 mm @ ((listOfPosition at: 1) + 8) mm;
		text: fullname;
		alignment: (PDFAlignment right));
	add: (PDFFormattedTextElement new
		textColor: self colorTitle;
		font: self fontContent;
		from: 20 mm @ 70 mm;
		text: 'Attendee:';
		alignment: (PDFAlignment right));
	add: (PDFFormattedTextElement new
		font: self fontContent;
		from: 45 mm @ 70 mm;
		text: registeredName;
		alignment: (PDFAlignment right));

	add: (PDFFormattedTextElement new
		font: self fontContent;
		dimension: 190 mm @ (listOfPosition at: 2) mm;
		from: 0 mm @ ((listOfPosition at: 2) + 8) mm;
		text: (self encode: user organizationAddress1);
		alignment: (PDFAlignment right));
		
	add: (PDFFormattedTextElement new
		font: self fontContent;
		dimension: 190 mm @ (listOfPosition at: 4) mm;
		from: 0 mm @ ((listOfPosition at: 4)+8) mm;
		text: (self encode: user organizationPostal, ' ', user organizationCity);
		alignment: (PDFAlignment right));
	
	add: (PDFFormattedTextElement new
		font: self fontContent;
		dimension: 190 mm @ (listOfPosition at: 5) mm;
		from: 0 mm @ ((listOfPosition at: 5) + 8) mm;
		text: (self encode: user organizationCountry);
		alignment: (PDFAlignment right)).
		
	user organizationAddress2 ifNotNil: [ 
		pdfPage add:(PDFFormattedTextElement new
			font: self fontContent;
			dimension: 190 mm @ (listOfPosition at: 3) mm;
			from: 0 mm @ ((listOfPosition at: 3) + 8) mm;
			text: (self encode: user organizationAddress2);
			alignment: (PDFAlignment right)) ].

	(user affiliationInformation extraInformation) ifNotNil: [ 
		pdfPage add:(PDFFormattedTextElement new
			font: self fontContent;
			dimension: 190 mm @ (listOfPosition at: 6) mm;
			from: 0 mm @ ((listOfPosition at: 6) + 8) mm;
			text: (self encode: (user affiliationInformation extraInformation));
			alignment: (PDFAlignment right)) ]
]

{ #category : #adding }
ERPDFInvoice >> addInfoPayment: pdfPage of: user [
	pdfPage add: (PDFTextElement new
		textColor: self colorTitle;
		font: self fontBoldContent;
		from: 20 mm @ 178 mm;
		text: 'Pay by Credit Card');
	add: (PDFTextElement new
		font: self fontContent;
		from: 30 mm @ 183 mm;
		text: 'Pay to our HelloAsso account: ESUG');
	add: (PDFTextElement new
		textColor: self colorLink;
		font: self fontContent;
		from: 30 mm @ 188 mm;
		text: 'https://www.helloasso.com/associations/esug/paiements/esug-2025');
	add: (PDFTextElement new
		font: self fontContent;
		from: 30 mm @ 193 mm;
		text: 'More infos: ');
	add: (PDFTextElement new
		textColor: self colorLink;
		font: self fontContent;
		from: 55 mm @ 193 mm;
		text: 'https://esug.org/support_esug.html');
	add: (PDFTextElement new
		textColor: self colorTitle;
		font: self fontBoldContent;
		from: 20 mm @ 201 mm;
		text: 'Pay by Bank Transfer:');
	add: (PDFDataTableElement new
		data: (Array with: (
			Array with: 'Account Owner:' with: controller conference fee bankAccountInformation owner) with:
			(Array with: 'Bank name:' with: controller conference fee bankAccountInformation bankInformation name) with:
			(Array with: 'IBAN:' with: controller conference fee bankAccountInformation iban ) with:
			(Array with: 'BIC/SWIFT Code:' with: controller conference fee bankAccountInformation bankInformation bic)
		);
		font: self fontContent;
		from: 30 mm @ 207 mm;
		dimension: 160 mm @ 20 mm;
		style: #noBorder; yourself
	);
	add: (PDFTextElement new
		textColor: self colorTitle;
		font: self fontBoldContent;
		from: 20 mm @ 230 mm;
		text: 'Payment status:');
	add: (PDFTextElement new
		font: self fontContent;
		from: 30 mm @ 235 mm;
		text: (self paymentStatus: user)).
]

{ #category : #adding }
ERPDFInvoice >> addTablePayment: pdfPage of: user [

	| fontLegend currency showedInfo |
	showedInfo := 'Full Registration to ESUG' , self controller conference year.
	(user isKindOf: ERGroup) ifTrue: [ showedInfo := user listAttends size asString , ' registrations to ESUG22' ].
	currency := 128 asCharacter asString , ' ' , (user paymentAmount ifNil: [ 0 ]) asString.
	fontLegend := PDFTimesFont size: 10 pt.
	pdfPage
		add: (PDFDataTableWithColumnsCaptionElement new
				 captions: #( 'Description' 'Total' );
				 data: (Array with: (Array with: showedInfo with: currency));
				 from: 20 mm @ 115 mm;
				 dimension: 170 mm @ 22 mm;
				 customizationBlock: [ :cell :x :y :data | 
					 y = 1 ifTrue: [ 
							 x = 1
								 ifTrue: [ cell dimension: 140 mm @ 4 mm ]
								 ifFalse: [ cell dimension: 30 mm @ 4 mm ] ].
					 x even ifTrue: [ cell alignment: PDFAlignment right ] ];
				 style: #dataTableWithColoredCaption;
				 yourself);
		add: (PDFDataTableElement new
				 data: (Array
						  with: (Array with: 'Total to pay:' with: currency)
						  with: (Array with: 'Not subjected to VAT' with: '')
						  with: (Array with: 'Amounts are in Euro (EUR)' with: ''));
				 from: 20 mm @ 142 mm;
				 dimension: 170 mm @ 15 mm;
				 customizationBlock: [ :cell :x :y :data | 
					 y = 1
						 ifTrue: [ 
							 x = 1 ifTrue: [ 
									 cell
										 textColor: self colorTitle;
										 font: self fontBoldContent ] ]
						 ifFalse: [ cell font: self fontFooter ] ];
				 yourself);
		add: (PDFTextElement new
				 font: fontLegend;
				 from: 22 mm @ 158 mm;
				 text: 'ESUG is a French Association of 1901 law (non-profit organization)');
		add: (PDFTextElement new
				 font: fontLegend;
				 from: 22 mm @ 163 mm;
				 text: 'and it is not subjected to VAT, "TVA non applicable - article 293 B du CGI".')
]

{ #category : #colors }
ERPDFInvoice >> colorBorder [
	^ PDFColor r: 255 g: 255 b: 255
]

{ #category : #colors }
ERPDFInvoice >> colorLink [
	^ PDFColor r: 230 g: 0 b: 115
]

{ #category : #colors }
ERPDFInvoice >> colorTitle [
	^ PDFColor r: 0 g: 0 b: 128
]

{ #category : #accessing }
ERPDFInvoice >> controller [
	^ controller
]

{ #category : #accessing }
ERPDFInvoice >> controller: anObject [
	controller := anObject
]

{ #category : #adding }
ERPDFInvoice >> dateToday [
	^ Date today monthName asString, ' ', Date today dayOfMonth asString, ', ', Date today year asString
]

{ #category : #adding }
ERPDFInvoice >> encode: aString [
	|encoder|
	encoder := (ZnCharacterEncoder newForEncoding: 'utf16').
	^ (encoder encodeString: aString) select: [ :e | e > 0 ]
]

{ #category : #fonts }
ERPDFInvoice >> fontBoldContent [
	^ (self fontContent) bold: true.
]

{ #category : #fonts }
ERPDFInvoice >> fontContent [
	^ PDFTimesFont size: 13pt.
]

{ #category : #fonts }
ERPDFInvoice >> fontFooter [
	^ PDFTimesFont size: 10 pt.
]

{ #category : #adding }
ERPDFInvoice >> lineElementFrom: aPoint1 to: aPoint2 [
	^ (PDFLineElement
		from: aPoint1
		to: aPoint2) drawColor: self colorTitle
]

{ #category : #adding }
ERPDFInvoice >> paymentStatus: user [
	user paymentInformation hasPaid 
		ifTrue: [ ^ 'Paid'].
		^ 'Unpaid'
]

{ #category : #templates }
ERPDFInvoice >> templateRegistrationInvoice: aStream of: user [
	| pharoLogo pdfDoc pdfPage |
	controller := ERController new .
	pharoLogo := CssForLoginMDL new esugJpg.
	pdfDoc := PDFDocument new.
	pdfDoc styleSheet > #noBorder drawColor: self colorBorder.
	pdfDoc styleSheet > #noBorder > #cell alignment: PDFAlignment left.
	pdfDoc styleSheet > #dataTableWithColoredCaption 
		font: self fontContent;
		drawColor: self colorBorder;
		margin: 10 pt.
	pdfDoc styleSheet > #dataTableWithColoredCaption > #caption
		font: ((self fontContent) bold: true);
		textColor: self colorTitle.
	pdfDoc styleSheet > #dataTableWithColoredCaption > #cell alignment: PDFAlignment left.
	pdfDoc styleSheet > #datatable drawColor: self colorBorder.
	pdfDoc styleSheet > #datatable > #cell 
		font: self fontContent;
		alignment: PDFAlignment right; 
		margin: 20 pt.
	pdfPage := PDFPage new.
	pdfPage add: ((PDFJpegElement fromStream: pharoLogo readStream)
			from: 70 mm @ 10 mm;
			width: 60mm). 
	self addHeader: pdfPage.
	self addInfoInvoice: pdfPage of: user.
	self addTablePayment: pdfPage of: user.
	self addBorder: pdfPage.
	self addInfoPayment: pdfPage of: user.
	self addFooter: pdfPage.
	pdfDoc add: pdfPage.
	pdfDoc exportTo: aStream.
	^ pdfDoc
]
