Class {
	#name : #MAMAVProjectTest,
	#superclass : #TestCase,
	#category : #'Maze-Tests-XMLObjects'
}

{ #category : #tests }
MAMAVProjectTest >> testParentProject [
	| parser root project factory |
	
	parser := XMLDOMParser on: MAMAVSamplePOMs basicPOMWithInheritance readStream.
	factory := XMLPluggableElementFactory new
		elementClass: MAPOMEntities;
		handleElement: 'project' withClass: MAMAVProject;
		handleElement: 'parent' withClass: MAMAVParent.
	parser nodeFactory: factory.
	
	root := parser parseDocument root.
	
	self assert: (root allElements select: [ :each | each isMemberOf: MAMAVProject ]) size = 1.
	project := (root allElements select: [ :each | each isMemberOf: MAMAVProject ]) first.
	
	self assert: project groupID = 'org.codehaus.mojo'.
	self assert: project version isNil.
	self assert: project modelVersion = '4.0.0'.
	self assert: project artifactID = 'my-project'.
	self assert: project fullyQualifiedArtifactName = 'org.codehaus.mojo.my-project:'.
	self assert: project parentProject isNil not.
	self assert: project dependenciesElement isNil.
	self assert: project attributes size = 1.
	self assert: project namespaceScope defaultNamespace = 'http://maven.apache.org/POM/4.0.0'.
	self assert: project namespaceScope prefixMappings keys size = 2.
	self assert: (project namespaceScope prefixMappings at: 'xsi') = 'http://www.w3.org/2001/XMLSchema-instance'.
	
	self assert: project parentProject isNil not.
	self assert: (project parentProject isMemberOf: MAMAVParent).
	self assert: project parentProject groupID = 'org.codehaus.mojo'.
	self assert: project parentProject artifactID = 'my-parent'.
	self assert: project parentProject version = '2.0'.
	self assert: project parentProject relativePath = '../my-parent'
]

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
MAMAVProjectTest >> testProjectElementDependenciesInsideManagedDependencyNode [
	| parser root project factory |
	
	parser := XMLDOMParser on: MAMAVSamplePOMs basicPOMWithManagedDependecies readStream.
	factory := XMLPluggableElementFactory new
				elementClass: MAPOMEntities;
				handleElement: 'project' withClass: MAMAVProject;
				handleElement: 'dependencyManagement' withClass: MAMAVDependencyManagement;
				handleElement: 'dependencies' withClass: MAMAVDependencies;
				handleElement: 'dependency' withClass: MAMAVDependency.
	parser nodeFactory: factory.
	
	root := parser parseDocument root.
	
	self assert: (root allElements select: [ :each | each isMemberOf: MAMAVProject ]) size = 1.
	project := (root allElements select: [ :each | each isMemberOf: MAMAVProject ]) first.
	
	self deny: project dependenciesElement isNil.
	self deny: project dependenciesElement dependencies isNil.
	self assert: project dependenciesElement dependencies size = 2.
	
]

{ #category : #tests }
MAMAVProjectTest >> testProjectElementResolving [
	| parser root project factory |
	
	parser := XMLDOMParser on: MAMAVSamplePOMs basicPOM readStream.
	factory := XMLPluggableElementFactory new
		elementClass: MAPOMEntities;
		handleElement: 'project' withClass: MAMAVProject.
	parser nodeFactory: factory.
	
	root := parser parseDocument root.
	
	self assert: (root allElements select: [ :each | each isMemberOf: MAMAVProject ]) size = 1.
	project := (root allElements select: [ :each | each isMemberOf: MAMAVProject ]) first.
	
	self assert: project groupID = 'org.codehaus.mojo'.
	self assert: project version = '1.0'.
	self assert: project modelVersion = '4.0.0'.
	self assert: project artifactID = 'my-project'.
	self assert: project fullyQualifiedArtifactName = 'org.codehaus.mojo.my-project:1.0'.
	self assert: project parentProject isNil.
	self assert: project dependenciesElement isNil.
	self assert: project attributes size = 1.
	self assert: project namespaceScope defaultNamespace = 'http://maven.apache.org/POM/4.0.0'.
	self assert: project namespaceScope prefixMappings keys size = 2.
	self assert: (project namespaceScope prefixMappings at: 'xsi') = 'http://www.w3.org/2001/XMLSchema-instance'.
	self assert: project parentProject isNil
]
