Class {
	#name : #MAMAVDependecyTest,
	#superclass : #TestCase,
	#category : #'Maze-Tests-OPAX'
}

{ #category : #tests }
MAMAVDependecyTest >> testDependencyElementCreation [

	| parser factory doc root |
	parser := XMLDOMParser on: MAMAVSamplePOMs basicPOMWithDependecies readStream.
	
	factory := XMLPluggableElementFactory new
				elementClass: MAPOMEntities;
				handleElement: 'dependency' withClass: MAMAVDependency.

	parser nodeFactory: factory. 
	
	doc := parser parseDocument.
	root := doc root.

	self assert: (root allElements select: [:each | each isMemberOf: MAMAVDependency]) size = 1.
	self assert: (root allElements reject: [:each | each isMemberOf: MAMAVDependency]) size = 12.
]

{ #category : #tests }
MAMAVDependecyTest >> testDependencyElementResolving [
	"<dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.0</version>
      <type>jar</type>
      <scope>test</scope>
      <optional>true</optional>
    </dependency>
  </dependencies>"

	| parser root dependency doc factory |
	
	parser := XMLDOMParser  on: MAMAVSamplePOMs basicPOMWithDependecies readStream.
	
	factory := XMLPluggableElementFactory new
				elementClass: MAPOMEntities;
				handleElement: 'dependency' withClass: MAMAVDependency.

	parser nodeFactory: factory.  
	
	doc := parser parseDocument.
	root := doc root.
	
	self assert: (root allElements select: [ :each | each isMemberOf: MAMAVDependency ]) size = 1.
	
	dependency := (root allElements select: [ :each | each isMemberOf: MAMAVDependency ]) first.
		
	self assert: dependency elements size = 6.
	self assert: dependency groupID = 'junit'.
	self assert: dependency artifactID = 'junit'.
	self assert: dependency version = '4.0'.
	self assert: dependency type = 'jar'.
	self assert: dependency scope = 'test'.
	self assert: dependency optional = true
]
