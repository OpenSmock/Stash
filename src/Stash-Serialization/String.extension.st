Extension { #name : #String }

{ #category : #'*Stash-Serialization' }
String >> asStashObject [

	| correctedString |
	correctedString := self copyReplaceAll: '%' with: '%%'.
	correctedString := correctedString copyReplaceAll: '<' with: '%<'.
	^ StashObject new
		  object: correctedString;
		  yourself
]
