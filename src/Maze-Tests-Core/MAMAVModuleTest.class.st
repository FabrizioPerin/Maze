Class {
	#name : #MAMAVModuleTest,
	#superclass : #TestCase,
	#category : #'Maze-Tests-OPAX'
}

{ #category : #tests }
MAMAVModuleTest >> testModuleElementCreation [

	| parser factory doc root |
	parser := XMLDOMParser on: MAMAVSamplePOMs basicPOMWithModules readStream.
	
	factory := XMLPluggableElementFactory new
				elementClass: MAPOMEntities;
				handleElement: 'module' withClass: MAMAVModule.

	parser nodeFactory: factory. 
	
	doc := parser parseDocument.
	root := doc root.

	self assert: (root allElements select: [:each | each isMemberOf: MAMAVModule]) size = 2.
	self assert: (root allElements reject: [:each | each isMemberOf: MAMAVModule]) size = 7.
]

{ #category : #tests }
MAMAVModuleTest >> testModuleElementResolving [
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
	self assert: (modules elements first stringNodes first string = 'my-project').
	self assert: (modules elements second stringNodes first string = 'another-project').
		


]
