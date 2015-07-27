Class {
	#name : #MAZEMavenDependencyTests,
	#superclass : #TestCase,
	#category : #'Maze-Tests-Core'
}

{ #category : #'as yet unclassified' }
MAZEMavenDependencyTests >> testCreation [
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
MAZEMavenDependencyTests >> testCreationSimple [
	| dependency |
	
	dependency := MAZEMavenDependency new.
		
	self assert: dependency sourceProject isNil.
	self assert: dependency targetProject isNil.
]
