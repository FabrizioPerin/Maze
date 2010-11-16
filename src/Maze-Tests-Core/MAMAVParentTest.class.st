Class {
	#name : #MAMAVParentTest,
	#superclass : #TestCase,
	#category : #'Maze-Tests-OPAX'
}

{ #category : #tests }
MAMAVParentTest >> testParentElementCreation [

	self assert: ((OPGenericElement newElementWithTag: 'notAParent') isMemberOf: OPGenericElement).
	self assert: ((OPGenericElement newElementWithTag: 'parent') isMemberOf: MAMAVParent).
]

{ #category : #tests }
MAMAVParentTest >> testParentElementResolving [

	"  <parent>
    <groupId>org.codehaus.mojo</groupId>
    <artifactId>my-parent</artifactId>
    <version>2.0</version>
    <relativePath>../my-parent</relativePath>
  </parent>"
	| parser root parent |
	
	parser := OPOpaxHandler on: MAMAVSamplePOMs basicPOMWithInheritance readStream.
	parser startDocument.
	parser parseDocument.
	root := parser stack first.

	self assert: (root allChildren select: [:each | each isMemberOf: MAMAVParent ]) size = 1.
	
	parent := (root allChildren select: [:each | each isMemberOf: MAMAVParent ]) first.
	
	self assert: (parent groupID = 'org.codehaus.mojo').
	self assert: (parent version = '2.0').
	self assert: (parent relativePath = '../my-parent').
	self assert: (parent artifactID = 'my-parent').
	
]
