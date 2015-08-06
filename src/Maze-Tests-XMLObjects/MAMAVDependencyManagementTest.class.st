Class {
	#name : #MAMAVDependencyManagementTest,
	#superclass : #TestCase,
	#category : #'Maze-Tests-XMLObjects'
}

{ #category : #'as yet unclassified' }
MAMAVDependencyManagementTest >> testDependenciesElementBasicCreation [
	| deps |

	deps := MAMAVDependencyManagement new.
	
	self deny: deps isNil.	
	self assert: deps dependenciesElement isNil.
]

{ #category : #'as yet unclassified' }
MAMAVDependencyManagementTest >> testDependencyManagementCreation [
	| parser factory doc root  managedDependency project |

	parser := XMLDOMParser on: MAMAVSamplePOMs basicPOMWithManagedDependecies readStream.
	
	factory := XMLPluggableElementFactory new
				elementClass: MAPOMEntities;
				handleElement: 'project' withClass: MAMAVProject;
				handleElement: 'dependencyManagement' withClass: MAMAVDependencyManagement;
				handleElement: 'dependencies' withClass: MAMAVDependencies;
				handleElement: 'dependency' withClass: MAMAVDependency.

	parser nodeFactory: factory. 
	
	doc := parser parseDocument.
	root := doc root.
	
	managedDependency := root allElements select: [:node | node isMemberOf: MAMAVDependencyManagement ].
	
	self assert: managedDependency isNotEmpty.
	self assert: managedDependency size = 1.
	
	self deny: managedDependency first dependenciesElement isNil.
	self assert: (managedDependency first dependenciesElement isMemberOf: MAMAVDependencies).
	self deny: (managedDependency first dependenciesElement dependencies isNil).
	self assert: (managedDependency first dependenciesElement dependencies size = 1).
	
	project := root allElements select: [:node | node isMemberOf: MAMAVProject ].
	
	self assert: project isNotEmpty.
	self assert: project size = 1.
	
	self deny: project first dependenciesElement isNil.
	self assert: project first dependenciesElement dependencies size = 2.	

]
