Class {
	#name : #MAPOMEntities,
	#superclass : #XMLElement,
	#instVars : [
		'path'
	],
	#category : #'Maze-XMLObjects'
}

{ #category : #'as yet unclassified' }
MAPOMEntities >> createMooseEntity [

	^ self subclassResponsibility
]
