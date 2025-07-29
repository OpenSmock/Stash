Trait {
	#name : #TStashTest,
	#category : #'Stash-Serialization-Tests'
}

{ #category : #'as yet unclassified' }
TStashTest >> model4 [

	^ self shouldBeImplemented
]

{ #category : #'as yet unclassified' }
TStashTest >> stashAccessorsForTraitsWithPragmas [

	<stashAccessors>
	^ { #test4 }
]

{ #category : #tests }
TStashTest >> test4 [

	^ self model4 test
]

{ #category : #tests }
TStashTest >> test4: anObject [

	self model4 test: anObject
]
