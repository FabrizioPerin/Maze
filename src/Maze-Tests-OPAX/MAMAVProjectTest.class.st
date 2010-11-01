Class {
	#name : #MAMAVProjectTest,
	#superclass : #TestCase,
	#category : #'Maze-Tests-OPAX'
}

{ #category : #tests }
MAMAVProjectTest >> testCreation [
	self assert: ((OPGenericElement newElementWithTag: 'ProjectTest') isMemberOf: OPGenericElement).
	self assert: ((OPGenericElement newElementWithTag: 'project') isMemberOf: MAMAVProject).
]
