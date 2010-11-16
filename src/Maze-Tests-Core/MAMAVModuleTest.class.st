Class {
	#name : #MAMAVModuleTest,
	#superclass : #TestCase,
	#category : #'Maze-Tests-OPAX'
}

{ #category : #tests }
MAMAVModuleTest >> testModuleElementCreation [

	self assert: ((OPGenericElement newElementWithTag: 'notAModule') isMemberOf: OPGenericElement).
	self assert: ((OPGenericElement newElementWithTag: 'module') isMemberOf: MAMAVModule).
]

{ #category : #tests }
MAMAVModuleTest >> testModuleElementResolving [
	"<modules>
    <module>my-project</module>
    <module>another-project</module>
  </modules>"

	| parser root modules |
	
	parser := OPOpaxHandler on: MAMAVSamplePOMs basicPOMWithModules readStream.
	parser startDocument.
	parser parseDocument.
	root := parser stack first.
	
	self assert: (root allChildren select: [ :each | each isMemberOf: MAMAVModules ]) size = 1.
	
	modules := (root allChildren select: [ :each | each isMemberOf: MAMAVModules ]) first.

	self assert: (modules children size = 2).
	self assert: (modules children first characters = 'my-project').
	self assert: (modules children second characters = 'another-project').
		


]
