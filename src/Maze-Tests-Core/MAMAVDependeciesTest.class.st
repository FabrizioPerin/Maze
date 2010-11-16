Class {
	#name : #MAMAVDependeciesTest,
	#superclass : #TestCase,
	#category : #'Maze-Tests-OPAX'
}

{ #category : #tests }
MAMAVDependeciesTest >> testDependenciesElementCreation [

	self assert: ((OPGenericElement newElementWithTag: 'notADependencies') isMemberOf: OPGenericElement).
	self assert: ((OPGenericElement newElementWithTag: 'dependencies') isMemberOf: MAMAVDependencies).
]

{ #category : #tests }
MAMAVDependeciesTest >> testDependenciesElementResolving [
	| parser root dependencies |
	
	parser := OPOpaxHandler on: MAMAVSamplePOMs basicPOMWithDependecies readStream.
	parser startDocument.
	parser parseDocument.
	root := parser stack first.

	self assert: (root allChildren select: [:each | each isMemberOf: MAMAVDependencies ]) size = 1.
	
	dependencies := (root allChildren select: [:each | each isMemberOf: MAMAVDependencies ]) first.
	
	self assert: (dependencies children size = 1).
	self assert: (dependencies children first isMemberOf: MAMAVDependency).
]
