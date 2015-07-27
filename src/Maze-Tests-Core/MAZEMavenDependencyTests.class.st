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

	self assert: dependency targetProject isNil not.
	self assert: (dependency targetProject isMemberOf: MAZEMavenProject).
	self assert: (dependency targetProject = tp).
]

{ #category : #'as yet unclassified' }
MAZEMavenDependencyTests >> testCreationSimple [
	| dependency |
	
	dependency := MAZEMavenDependency new.
		
	self assert: dependency sourceProject isNil.
	self assert: dependency targetProject isNil.
]
