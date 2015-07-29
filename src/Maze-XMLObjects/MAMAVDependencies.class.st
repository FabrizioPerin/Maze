Class {
	#name : #MAMAVDependencies,
	#superclass : #MAMAVProject,
	#category : #'Maze-XMLObjects'
}

{ #category : #'as yet unclassified' }
MAMAVDependencies >> dependencies [
	^ self elements select: [ :each | each isMemberOf: MAMAVDependency ]
]
