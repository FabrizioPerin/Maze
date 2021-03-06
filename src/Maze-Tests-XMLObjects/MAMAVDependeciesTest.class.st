Class {
	#name : #MAMAVDependeciesTest,
	#superclass : #TestCase,
	#category : #'Maze-Tests-XMLObjects'
}

{ #category : #'as yet unclassified' }
MAMAVDependeciesTest >> testDependenciesElementBasicCreation [
	| deps |

	deps := MAMAVDependencies new.
	
	self deny: deps isNil.	
	self assert: deps dependencies isCollection.
	self assert: (deps dependencies size = 0)
]

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
	self assert: (root allElements reject: [:each | each isMemberOf: MAMAVDependencies]) size = 18.
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
	
	self assert: (root allElements select: [ :each | each isMemberOf: MAMAVDependencies ]) size = 1.
	
	dependencies := (root allElements select: [ :each | each isMemberOf: MAMAVDependencies ]) first.
	
	self assert: dependencies dependencies isCollection.
	self assert: dependencies dependencies size = 2.
	self assert: (dependencies dependencies first isMemberOf: MAMAVDependency)
]
