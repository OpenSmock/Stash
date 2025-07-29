Class {
	#name : #StashTestSetterGetter1,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'Stash-Serialization-Tests'
}

{ #category : #accessing }
StashTestSetterGetter1 >> name [

	^ name
]

{ #category : #accessing }
StashTestSetterGetter1 >> name: anObject [

	name := anObject
]

{ #category : #'as yet unclassified' }
StashTestSetterGetter1 >> stashAccessors [

	<stashAccessors>

	^ { (#name: -> #name) }
]
