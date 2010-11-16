Class {
	#name : #MAMAVModulesTest,
	#superclass : #TestCase,
	#category : #'Maze-Tests-OPAX'
}

{ #category : #tests }
MAMAVModulesTest >> testModulesElementCreation [

	self assert: ((OPGenericElement newElementWithTag: 'notAModules') isMemberOf: OPGenericElement).
	self assert: ((OPGenericElement newElementWithTag: 'modules') isMemberOf: MAMAVModules).
]

{ #category : #tests }
MAMAVModulesTest >> testModulesElementResolving [
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


]
