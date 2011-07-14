Class {
	#name : #MAMAVParentTest,
	#superclass : #TestCase,
	#category : #'Maze-Tests-XMLObjects'
}

{ #category : #tests }
MAMAVParentTest >> testParentElementCreation [

	| parser factory doc root |
	parser := XMLDOMParser on: MAMAVSamplePOMs basicPOMWithInheritance readStream.
	
	factory := XMLPluggableElementFactory new
				elementClass: MAPOMEntities;
				handleElement: 'parent' withClass: MAMAVParent.

	parser nodeFactory: factory. 
	
	doc := parser parseDocument.
	root := doc root.

	self assert: (root allElements select: [:each | each isMemberOf: MAMAVParent]) size = 1.
	self assert: (root allElements reject: [:each | each isMemberOf: MAMAVParent]) size = 7.
]

{ #category : #tests }
MAMAVParentTest >> testParentElementResolving [

	"  <parent>
    <groupId>org.codehaus.mojo</groupId>
    <artifactId>my-parent</artifactId>
    <version>2.0</version>
    <relativePath>../my-parent</relativePath>
  </parent>"
	| parser root parent doc factory |
	
	parser := XMLDOMParser on: MAMAVSamplePOMs basicPOMWithInheritance readStream.
	
	factory := XMLPluggableElementFactory new
				elementClass: MAPOMEntities;
				handleElement: 'parent' withClass: MAMAVParent.

	parser nodeFactory: factory.  
	
	doc := parser parseDocument.
	root := doc root.

	self assert: (root allElements select: [:each | each isMemberOf: MAMAVParent ]) size = 1.
	
	parent := (root allElements select: [:each | each isMemberOf: MAMAVParent ]) first.
	
	self assert: (parent groupID = 'org.codehaus.mojo').
	self assert: (parent version = '2.0').
	self assert: (parent relativePath = '../my-parent').
	self assert: (parent artifactID = 'my-parent').
	
]
