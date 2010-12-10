Class {
	#name : #MAMAVProjectTest,
	#superclass : #TestCase,
	#category : #'Maze-Tests-OPAX'
}

{ #category : #tests }
MAMAVProjectTest >> testProjectElementCreation [

	self assert: ((OPGenericElement newElementWithTag: 'notAProject') isMemberOf: OPGenericElement).
	self assert: ((OPGenericElement newElementWithTag: 'project') isMemberOf: MAMAVProject).
]

{ #category : #tests }
MAMAVProjectTest >> testProjectElementResolving [

	| parser root project |
	
	parser := OPOpaxHandler on: MAMAVSamplePOMs basicPOM readStream.
	parser startDocument.
	parser parseDocument.
	root := parser stack first.

	self assert: (root allChildren select: [:each | each isMemberOf: MAMAVProject ]) size = 1.
	
	project := (root allChildren select: [:each | each isMemberOf: MAMAVProject ]) first.
	
	self assert: (project groupID = 'org.codehaus.mojo').
	self assert: (project version = '1.0').
	self assert: (project modelVersion = '4.0.0').
	self assert: (project artifactID = 'my-project').
	self assert: (project fullyQualifiedArtifactName = 'org.codehaus.mojo.my-project:1.0').
	
	self assert: (project attributes size = 3).
	
]
