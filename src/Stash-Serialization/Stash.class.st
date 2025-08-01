Class {
	#name : #Stash,
	#superclass : #Object,
	#instVars : [
		'rootObject',
		'steps',
		'taggedObject',
		'stream',
		'uuid',
		'dictionary'
	],
	#category : #'Stash-Serialization-stash'
}

{ #category : #adding }
Stash >> addOnSourceCode: aString [

	stream << aString
]

{ #category : #adding }
Stash >> addTaggedObject: aStashObject [

	self taggedObject add: aStashObject.
	aStashObject tag: (self newTagFor: aStashObject)
]

{ #category : #accessing }
Stash >> at: anObject [

	^ dictionary at: anObject
]

{ #category : #accessing }
Stash >> at: anObject ifPresent: aBlockPresent ifAbsentPut: aBlockAbsent [ 
	dictionary at: anObject ifPresent: aBlockPresent ifAbsentPut: aBlockAbsent
]

{ #category : #accessing }
Stash >> do: aBlock [

	dictionary do: aBlock
]

{ #category : #private }
Stash >> initialize [

	uuid := 0.
	stream := String new writeStream.
	dictionary := IdentityDictionary new.
	taggedObject := OrderedCollection new.
	steps := {
		         StashPrepareObjectStep new.
		         StashTagObjectStep new.
		         StashTagVariablesStep new.
		         StashConstructTagObjectsStep new.
		         StashContructGeneralObjectsStep new }
]

{ #category : #private }
Stash >> materialize: aString [

	^ self class compiler
		             source: aString;
		             evaluate.
]

{ #category : #'instance creation' }
Stash >> newTagFor: aStashObject [

	^ aStashObject object class printString asLowercase onlyLetters
	  , self nextUUID printString
]

{ #category : #'as yet unclassified' }
Stash >> nextUUID [

	^ uuid := uuid + 1
]

{ #category : #accessing }
Stash >> rootObject [

	^ rootObject
]

{ #category : #accessing }
Stash >> rootObject: anObject [

	rootObject := anObject
]

{ #category : #private }
Stash >> run [

	self steps do: [ :step | step runOn: self ].

	
]

{ #category : #private }
Stash >> serialize: anObject [

	self rootObject: anObject.
	self run.
	^ self sourceCode
]

{ #category : #adding }
Stash >> sourceCode [

	| expr |
	expr := RBParser parseExpression: stream contents expandMacros.
	^ RBSimpleFormatter format: expr
]

{ #category : #private }
Stash >> steps [

	^ steps
]

{ #category : #accessing }
Stash >> taggedObject [

	^ taggedObject
]
