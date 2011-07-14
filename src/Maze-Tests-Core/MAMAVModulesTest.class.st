Class {
	#name : #MAMAVModulesTest,
	#superclass : #TestCase,
	#category : #'Maze-Tests-OPAX'
}

{ #category : #tests }
MAMAVModulesTest >> testModulesElementCreation [

	| parser factory doc root |
	parser := XMLDOMParser on: MAMAVSamplePOMs basicPOMWithModules readStream.
	
	factory := XMLPluggableElementFactory new
				elementClass: MAPOMEntities;
				handleElement: 'modules' withClass: MAMAVModules.

	parser nodeFactory: factory. 
	
	doc := parser parseDocument.
	root := doc root.

	self assert: (root allElements select: [:each | each isMemberOf: MAMAVModules]) size = 1.
	self assert: (root allElements reject: [:each | each isMemberOf: MAMAVModules]) size = 8.
]

{ #category : #tests }
MAMAVModulesTest >> testModulesElementResolving [
	"<modules>
    <module>my-project</module>
    <module>another-project</module>
  </modules>"

	| parser root modules doc factory |
	
	parser := XMLDOMParser on: MAMAVSamplePOMs basicPOMWithModules readStream.

	factory := XMLPluggableElementFactory new
				elementClass: MAPOMEntities;
				handleElement: 'modules' withClass: MAMAVModules.

	parser nodeFactory: factory.  
	
	doc := parser parseDocument.
	root := doc root.
	
	self assert: (root allElements select: [ :each | each isMemberOf: MAMAVModules ]) size = 1.
	
	modules := (root allElements select: [ :each | each isMemberOf: MAMAVModules ]) first.

	self assert: (modules elements size = 2).


]
