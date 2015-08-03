"
I'm MAPOMEntities the root of the hierarchy of XML node contained into a MAVEN POM file.

I'm a place holder where all the XML Elements belong to a MAVEN POM file should be attached.

Public API and Key Messages

createFamixEntity - abstract method that should be implemented by subclass nodes to create a Famix entity out of them. 
"
Class {
	#name : #MAPOMEntities,
	#superclass : #XMLElement,
	#category : #'Maze-XMLObjects'
}

{ #category : #'as yet unclassified' }
MAPOMEntities >> accept: aVisitor [
	^ aVisitor visit: self
]

{ #category : #'as yet unclassified' }
MAPOMEntities >> createFamixEntity [

	^ self subclassResponsibility
]
