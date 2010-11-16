Class {
	#name : #MAMAVDependecyTest,
	#superclass : #TestCase,
	#category : #'Maze-Tests-OPAX'
}

{ #category : #tests }
MAMAVDependecyTest >> testDependencyElementCreation [

	self assert: ((OPGenericElement newElementWithTag: 'notADepenency') isMemberOf: OPGenericElement).
	self assert: ((OPGenericElement newElementWithTag: 'dependency') isMemberOf: MAMAVDependency).
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

	| parser root dependency |
	
	parser := OPOpaxHandler on: MAMAVSamplePOMs basicPOMWithDependecies readStream.
	parser startDocument.
	parser parseDocument.
	root := parser stack first.
	
	self assert: (root allChildren select: [ :each | each isMemberOf: MAMAVDependency ]) size = 1.
	
	dependency := (root allChildren select: [ :each | each isMemberOf: MAMAVDependencies ]) first children first.
		
	self assert: dependency children size = 6.
	self assert: dependency groupID = 'junit'.
	self assert: dependency artifactID = 'junit'.
	self assert: dependency version = '4.0'.
	self assert: dependency type = 'jar'.
	self assert: dependency scope = 'test'.
	self assert: dependency optional = true
]
