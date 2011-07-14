Class {
	#name : #MAMAVProjectTest,
	#superclass : #TestCase,
	#category : #'Maze-Tests-OPAX'
}

{ #category : #tests }
MAMAVProjectTest >> testProjectElementCreation [

	| parser factory doc root |
	parser := XMLDOMParser on: MAMAVSamplePOMs basicPOM readStream.
	
	factory := XMLPluggableElementFactory new
				elementClass: MAPOMEntities;
				handleElement: 'project' withClass: MAMAVProject.

	parser nodeFactory: factory. 
	
	doc := parser parseDocument.
	root := doc root.

	self assert: (root allElements select: [:each | each isMemberOf: MAMAVProject]) size = 1.
	self assert: (root allElements reject: [:each | each isMemberOf: MAMAVProject]) size = 4.
]

{ #category : #tests }
MAMAVProjectTest >> testProjectElementResolving [

	| parser root project doc factory |
	
	parser := XMLDOMParser on: MAMAVSamplePOMs basicPOM readStream.
	factory := XMLPluggableElementFactory new
				elementClass: MAPOMEntities;
				handleElement: 'project' withClass: MAMAVProject.

	parser nodeFactory: factory.  
	
	doc := parser parseDocument.
	root := doc root.

	self assert: (root allElements select: [:each | each isMemberOf: MAMAVProject ]) size = 1.
	
	project := (root allElements select: [:each | each isMemberOf: MAMAVProject ]) first.
	
	self assert: (project groupID = 'org.codehaus.mojo').
	self assert: (project version = '1.0').
	self assert: (project modelVersion = '4.0.0').
	self assert: (project artifactID = 'my-project').
	self assert: (project fullyQualifiedArtifactName = 'org.codehaus.mojo.my-project:1.0').
	
	self assert: (project attributes size = 1).
	self assert: (project namespaceScope defaultNamespace = 'http://maven.apache.org/POM/4.0.0').
	self assert: (project namespaceScope prefixMappings keys size = 1).
	self assert: ((project namespaceScope prefixMappings at: 'xsi') = 'http://www.w3.org/2001/XMLSchema-instance').
	
]
