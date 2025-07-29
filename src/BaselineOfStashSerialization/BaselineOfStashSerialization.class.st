Class {
	#name : #BaselineOfStashSerialization,
	#superclass : #BaselineOf,
	#category : #BaselineOfStashSerialization
}

{ #category : #baselines }
BaselineOfStashSerialization >> baseline: spec [

	<baseline>
	spec for: #common do: [ self baselineForCommon: spec ]

]

{ #category : #baselines }
BaselineOfStashSerialization >> baselineForCommon: spec [

	<baseline>
	spec package: #'Stash-Serialization'.
	spec
		package: 'Stash-Serialization-Tests'
		with: [ spec requires: #( 'Stash-Serialization' ) ]

]
