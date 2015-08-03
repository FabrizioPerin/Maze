Class {
	#name : #MAZEPomFileVisitor,
	#superclass : #Object,
	#instVars : [
		'importer',
		'currentProject'
	],
	#category : #'Maze-Importer'
}

{ #category : #accessing }
MAZEPomFileVisitor >> importer [
	^ importer
]

{ #category : #accessing }
MAZEPomFileVisitor >> importer: anObject [
	importer := anObject
]

{ #category : #'as yet unclassified' }
MAZEPomFileVisitor >> visit: aMazeXMLNode [
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
MAZEPomFileVisitor >> visitDependencyNode: aMazeXMLDependencyNode [
	| famixDependency |
	
	famixDependency := aMazeXMLDependencyNode createFamixEntity.
	
	famixDependency sourceProject: currentProject.
	
	^ famixDependency
]

{ #category : #'as yet unclassified' }
MAZEPomFileVisitor >> visitProjectNode: aMazeXMLProjectNode [
	
	currentProject := aMazeXMLProjectNode createFamixEntity.
	
	^ currentProject
]
