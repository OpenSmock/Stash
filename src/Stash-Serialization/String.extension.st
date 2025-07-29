Extension { #name : #String }

{ #category : #'*Stash-Serialization' }
String >> asStashObject [

	| correctedString |
	correctedString := self copyReplaceAll: '%' with: '%%'.
	correctedString := correctedString copyReplaceAll: '<' with: '%<'.
	self isSymbol ifTrue: [ correctedString := correctedString asSymbol ].
	^ StashObject new
		  object: correctedString;
		  yourself
]
