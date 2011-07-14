Class {
	#name : #MazeMavDraft,
	#superclass : #TestCase,
	#category : #'Maze-Tests-Importer'
}

{ #category : #'as yet unclassified' }
MazeMavDraft >> testProjectCreation [
	| xmlDocument project |
	
	xmlDocument := XMLDOMParser parse: MAMAVSamplePOMs basicPOM.
	
	project := xmlDocument findElementNamed: 'project'.
	
	self assert: (project isNil not).
	self assert: (xmlDocument root = project).
	
	
	
]
