Class {
	#name : #MAZEMavenDependencyTests,
	#superclass : #TestCase,
	#category : #'Maze-Tests-Core'
}

{ #category : #'as yet unclassified' }
MAZEMavenDependencyTests >> testArtifactID [
	| dependency |

	dependency := MAZEMavenDependency new.

	self assert: dependency artifactID isNil.

	dependency artifactID: 'mainproj_ejb_prj'.
	
	self assert: dependency artifactID equals: 'mainproj_ejb_prj'
]

{ #category : #'as yet unclassified' }
MAZEMavenDependencyTests >> testCreateTargetStubPrject [
	| dependency |
	dependency := MAZEMavenDependency new.
	

]

{ #category : #'as yet unclassified' }
MAZEMavenDependencyTests >> testCreationSimple [
	| dependency |
	
	dependency := MAZEMavenDependency new.
		
	self assert: dependency sourceProject isNil.
	self assert: dependency targetProject isNil.
	self assert: dependency artifactID isNil. 
	self assert: dependency groupID isNil.
	self assert: dependency version isNil.
	self assert: dependency type isNil.
	self assert: dependency scope isNil.
	self assert: dependency dependencyNode isNil
]

{ #category : #'as yet unclassified' }
MAZEMavenDependencyTests >> testGroupID [
	| dependency |
	
	dependency := MAZEMavenDependency new.

	self assert: dependency groupID isNil.

	dependency groupID: 'ch.mainproj.prj'.
	
	self assert: dependency groupID equals: 'ch.mainproj.prj'
]

{ #category : #'as yet unclassified' }
MAZEMavenDependencyTests >> testSourceAndTargetProjects [
	| dependency sp tp |
	
	sp := MAZEMavenProject new.
	tp := MAZEMavenProject new.
	
	dependency := MAZEMavenDependency new.
	dependency sourceProject: sp.
	dependency targetProject: tp.

	self assert: dependency sourceProject isNil not.
	self assert: (dependency sourceProject isMemberOf: MAZEMavenProject).
	self assert: (dependency sourceProject = sp).
	
	self assert: sp referencedProjects isNil not.
	self assert: (sp referencedProjects size = 1).
	self assert: ((sp referencedProjects at: 1) =dependency).

	self assert: dependency targetProject isNil not.
	self assert: (dependency targetProject isMemberOf: MAZEMavenProject).
	self assert: (dependency targetProject = tp).
	
	self assert: tp referencingProjects isNil not.
	self assert: (tp referencingProjects size = 1).
	self assert: ((tp referencingProjects at: 1) = dependency).
]

{ #category : #'as yet unclassified' }
MAZEMavenDependencyTests >> testType [
	| dependency |
	
	dependency := MAZEMavenDependency new.
		
	self assert: dependency type isNil.

	dependency type: 'ch.mainproj.prj'.
	
	self assert: dependency type equals: 'ch.mainproj.prj'

]

{ #category : #'as yet unclassified' }
MAZEMavenDependencyTests >> testVesrion [
	| dependency |
	
	dependency := MAZEMavenDependency new.
		
	self assert: dependency version isNil.

	dependency version: '1.0.0'.
	
	self assert: dependency version equals: '1.0.0'
	
]
