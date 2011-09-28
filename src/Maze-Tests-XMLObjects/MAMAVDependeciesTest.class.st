Class {
	#name : #MAMAVDependeciesTest,
	#superclass : #TestCase,
	#category : #'Maze-Tests-XMLObjects'
}

{ #category : #tests }
MAMAVDependeciesTest >> testDependenciesElementCreation [

	| parser factory doc root |
	parser := XMLDOMParser on: MAMAVSamplePOMs basicPOMWithDependecies readStream.
	
	factory := XMLPluggableElementFactory new
				elementClass: MAPOMEntities;
				handleElement: 'dependencies' withClass: MAMAVDependencies.

	parser nodeFactory: factory. 
	
	doc := parser parseDocument.
	root := doc root.

	self assert: (root allElements select: [:each | each isMemberOf: MAMAVDependencies]) size = 1.
	self assert: (root allElements reject: [:each | each isMemberOf: MAMAVDependencies]) size = 12.
]

{ #category : #tests }
MAMAVDependeciesTest >> testDependenciesElementResolving [
	| parser root dependencies doc factory |
	
	parser := XMLDOMParser on: MAMAVSamplePOMs basicPOMWithDependecies readStream.
	
	factory := XMLPluggableElementFactory new
				elementClass: MAPOMEntities;
				handleElement: 'dependencies' withClass: MAMAVDependencies;
				handleElement: 'dependency' withClass: MAMAVDependency.

	parser nodeFactory: factory.  
	
	doc := parser parseDocument.
	root := doc root.

	self assert: (root allElements select: [:each | each isMemberOf: MAMAVDependencies ]) size = 1.
	
	dependencies := (root allElements select: [:each | each isMemberOf: MAMAVDependencies ]) first.
	
	self assert: (dependencies elements size = 1).
	self assert: (dependencies elements first isMemberOf: MAMAVDependency).
]
