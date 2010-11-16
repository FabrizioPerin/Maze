Class {
	#name : #MazeMavDraft,
	#superclass : #TestCase,
	#category : #'Maze-Tests-Importer'
}

{ #category : #'as yet unclassified' }
MazeMavDraft >> testProjectCreation [
	| xmlDocument project |
	
	xmlDocument := XMLDOMParser parse: self basicPOM.
	
	project := xmlDocument firstTagNamed: 'project'.
	
	self assert: (project isNil not).
	self assert: (xmlDocument root = project).
	
	
	
]
