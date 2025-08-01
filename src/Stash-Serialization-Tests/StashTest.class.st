Class {
	#name : #StashTest,
	#superclass : #TestCase,
	#category : #'Stash-Serialization-Tests'
}

{ #category : #tests }
StashTest >> testArray1 [

	| object source |
	object := {  }.
	source := Stash new serialize: object.
	self assert: source equals: '{}'.
]

{ #category : #tests }
StashTest >> testArray2 [

	| object source newObject |
	object := { 1. 2. 3 }.
	source := Stash new serialize: object.
	newObject := self class compiler
		             source: source;
		             evaluate.
	self assert: newObject equals: {1 . 
2 . 
3}
]

{ #category : #tests }
StashTest >> testArray3 [

	| object source |
	object := { Object new }.
	source := Stash new serialize: object.

	self assert: source equals: '{Object new}'.
]

{ #category : #tests }
StashTest >> testAssociation1 [

	| object source |
	object := Object new -> Object new.
	source := Stash new serialize: object.
	self assert: source equals: 'Object new -> Object new'
]

{ #category : #tests }
StashTest >> testAssociation2 [

	| object source |
	object := 1 -> 2.
	source := Stash new serialize: object.
	self assert: source equals: '1 -> 2'
]

{ #category : #tests }
StashTest >> testBlockClosure1 [

	| object source |
	object := [  ].
	source := Stash new serialize: object.
	self assert: source equals: '[  ]'
]

{ #category : #tests }
StashTest >> testBlockClosure10 [

	| object source |
	object := [ [ Object ] ].
	source := Stash new serialize: object.
	self assert: source equals: '[ [ Object ] ]'
]

{ #category : #tests }
StashTest >> testBlockClosure11 [

	| object source outerContext |
	outerContext := 1.
	object := [ :a | [ a + outerContext ] ].
	[ source := Stash new serialize: object ]
		on: StashCannotSerializeBlockClosure
		do: [
			self assert: true.
			^ self ].
	self fail
]

{ #category : #tests }
StashTest >> testBlockClosure12 [

	| object source newObject |
	object := [ :a | [ :b | b + a ] value: a ].
	source := Stash new serialize: object.
	self assert: (object value: 5) equals: 10.
	self assert: source equals: '[:a |  [:b |  b + a ] value: a ]'.
	newObject := Stash new materialize: source.
	self assert: (newObject value: 5) equals: 10
]

{ #category : #tests }
StashTest >> testBlockClosure2 [

	| object source |
	object := [ :a :b :c |  ].
	source := Stash new serialize: object.
	self assert: source equals: '[:a :b :c |   ]'
]

{ #category : #tests }
StashTest >> testBlockClosure3 [

	| object source newObject |
	object := [ :a | a + 1 ].
	source := Stash new serialize: object.
	self assert: (object value: 5) equals: 6.
	self assert: source equals: '[:a |  a + 1 ]'.
	newObject := Stash new materialize: source.
	self assert: (newObject value: 5) equals: 6.
]

{ #category : #tests }
StashTest >> testBlockClosure4 [

	| object source outerContext |
	outerContext := 1.
	object := [ :a | a + outerContext ].
	[source := Stash new serialize: object] on: StashCannotSerializeBlockClosure do: [ self assert: true. ^ self ].
self fail.

]

{ #category : #tests }
StashTest >> testBlockClosure5 [

	| object source newObject |
	object := [ :a | a + a + 1 ].
	source := Stash new serialize: object.
	self assert: (object value: 5) equals: 11.
	self assert: source equals: '[:a |  a + a + 1 ]'.
	newObject := Stash new materialize: source.
	self assert: (newObject value: 5) equals: 11
]

{ #category : #tests }
StashTest >> testBlockClosure6 [

	| object source newObject |
	object := [ :a | | innerContext | innerContext := 1 . a + a + innerContext ].
	source := Stash new serialize: object.
	self assert: (object value: 5) equals: 11.
	self assert: source equals: '[:a |  | innerContext |
innerContext := 1.
a + a + innerContext ]'.
	newObject := Stash new materialize: source.
	self assert: (newObject value: 5) equals: 11
]

{ #category : #tests }
StashTest >> testBlockClosure7 [

	| object source newObject |
	object := [ Color red ].
	source := Stash new serialize: object.
	self assert: (object value) equals: Color red.
	self assert: source equals: '[ Color red ]'.
	newObject := Stash new materialize: source.
	self assert: (object value) equals: Color red.
]

{ #category : #tests }
StashTest >> testBlockClosure8 [

	| object source newObject |
	object := [ | b c | c := Color red. #test . b := Object . 'tetet' . c].
	source := Stash new serialize: object.
	self assert: object value equals: Color red.
	self assert: source equals: '[ | b c |
c := Color red.
#test.
b := Object.
''tetet''.
c ]'.
	newObject := Stash new materialize: source.
	self assert: object value equals: Color red
]

{ #category : #tests }
StashTest >> testBlockClosure9 [

	| object source |
	object := [ [  ] ].
	source := Stash new serialize: object.
	self assert: source equals: '[ [  ] ]'.

]

{ #category : #tests }
StashTest >> testClass1 [

	| object source |
	object := Object.
	source := Stash new serialize: object.
	self assert: source equals: 'Object'
]

{ #category : #tests }
StashTest >> testClass2 [

	| object source |
	object := { Object . Object }.
	source := Stash new serialize: object.
	self assert: source equals: '| objectclass1 |
objectclass1 := Object.
{objectclass1 . 
objectclass1}'
]

{ #category : #tests }
StashTest >> testColor1 [

	| object source newObject |
	object := Color red.
	source := Stash new serialize: object.
	self assert: source equals: 'Color r: 1.0 g: 0.0 b: 0.0 alpha: 1.0'.

	newObject := self class compiler
		             source: source;
		             evaluate.
	self assert: newObject equals: Color red
]

{ #category : #tests }
StashTest >> testColor2 [

	| object source newObject |
	object := Color blue.
	source := Stash new serialize: object.
	self assert: source equals: 'Color r: 0.0 g: 0.0 b: 1.0 alpha: 1.0'.

	newObject := self class compiler
		             source: source;
		             evaluate.
	self assert: newObject equals: Color blue
]

{ #category : #tests }
StashTest >> testColor3 [

	| object source newObject |
	1 to: 10 do: [ :i |
		object := Color random.
		source := Stash new serialize: object.
		newObject := self class compiler
			             source: source;
			             evaluate.
		self assert: newObject equals: object ]
]

{ #category : #tests }
StashTest >> testColor4 [

	| object source newObject |
	object := Color blue alpha: 0.5.
	source := Stash new serialize: object.

	newObject := self class compiler
		             source: source;
		             evaluate.
	self assert: newObject alpha equals: object alpha
]

{ #category : #tests }
StashTest >> testDictionary1 [

	| object source |
	object := Dictionary new.
	source := Stash new serialize: object.
	self assert: source equals: 'Dictionary new'
]

{ #category : #tests }
StashTest >> testDictionary2 [

	| object source |
	object := Dictionary new at: #hello put: #world; yourself.
	source := Stash new serialize: object.
	self assert: source equals: 'Dictionary new
   at: #hello put: #world;
   yourself'
]

{ #category : #tests }
StashTest >> testDictionary3 [

	| object source |
	object := Dictionary new
		          at: #key1 put: #value1;
					 at: #key2 put: #value2;
					 at: #key3 put: #value3;
		          yourself.
	source := Stash new serialize: object.
	self assert: source equals: 'Dictionary new
   at: #key1 put: #value1;
   at: #key2 put: #value2;
   at: #key3 put: #value3;
   yourself'
]

{ #category : #tests }
StashTest >> testDictionary4 [

	| object source |
	object := Dictionary new
		          at: #key1 put: #value1;
		          at: #key2 put: #value2;
		          at: #key3 put: #value3;
		          yourself.
	object at: object put: object.

	source := Stash new serialize: object.
	self assert: source equals: '| dictionary1 |
dictionary1 := Dictionary new.
dictionary1
   at: dictionary1 put: dictionary1;
   at: #key1 put: #value1;
   at: #key2 put: #value2;
   at: #key3 put: #value3;
   yourself'
]

{ #category : #tests }
StashTest >> testLiteral1 [

	self assert: (Stash new serialize: 1) equals: '1'
]

{ #category : #tests }
StashTest >> testLiteral2 [

	self assert: (Stash new serialize: true) equals: 'true'
]

{ #category : #tests }
StashTest >> testLiteral3 [

	self assert: (Stash new serialize: 'hello') equals: '''hello'''
]

{ #category : #tests }
StashTest >> testLiteral4 [

	self assert: (Stash new serialize: #world) equals: '#world'
]

{ #category : #tests }
StashTest >> testObject1 [

	self assert: (Stash new serialize: Object new) equals: 'Object new'
]

{ #category : #tests }
StashTest >> testPoint1 [

	| object source |
	object := 6 @ 7.
	source := Stash new serialize: object.
	self assert: source equals: '6 @ 7'
]

{ #category : #tests }
StashTest >> testPoint2 [

	| object source |
	object := -45 @ 70.
	source := Stash new serialize: object.
	self assert: source equals: '-45 @ 70'
]

{ #category : #tests }
StashTest >> testString1 [

	| object source |
	object := 'hello'.
	source := Stash new serialize: object.
	self assert: source equals: '''hello'''
]

{ #category : #tests }
StashTest >> testString10 [

	| object source |
	object := #toto.
	source := Stash new serialize: object.
	self assert: source equals: '#toto'
]

{ #category : #tests }
StashTest >> testString11 [

	| object source |
	object := #'toto-titi'.
	source := Stash new serialize: object.
	self assert: source equals: '#''toto-titi'''
]

{ #category : #tests }
StashTest >> testString2 [

	| object source |
	object := '<?xml>'.
	source := Stash new serialize: object.
	self assert: source equals: '''<?xml>'''
]

{ #category : #tests }
StashTest >> testString3 [

	| object source |
	object := '<1>'.
	source := Stash new serialize: object.
	self assert: source equals: '''<1>'''
]

{ #category : #tests }
StashTest >> testString4 [

	| object source |
	object := '5 < 10'.
	source := Stash new serialize: object.
	self assert: source equals: '''5 < 10'''
]

{ #category : #tests }
StashTest >> testString5 [

	| object source |
	object := '%<2<3<>>5<%<?<8>><1<'.
	source := Stash new serialize: object.
	self assert: source equals: '''%<2<3<>>5<%<?<8>><1<'''
]

{ #category : #tests }
StashTest >> testString6 [

	| object source |
	object := '<'.
	source := Stash new serialize: object.
	self
		assert: source
		equals: '''<'''
]

{ #category : #tests }
StashTest >> testString7 [

	| object source |
	object := '%<'.
	source := Stash new serialize: object.
	self
		assert: source
		equals: '''%<'''
]

{ #category : #tests }
StashTest >> testString8 [

	| object source |
	object := '%%<'.
	source := Stash new serialize: object.
	self
		assert: source
		equals: '''%%<'''
]

{ #category : #tests }
StashTest >> testString9 [

	| object source |
	object := '%%%<%%%%%%%%<%%%<%%<%<<%'.
	source := Stash new serialize: object.
	self
		assert: source
		equals: '''%%%<%%%%%%%%<%%%<%%<%<<%'''
]
