Class {
	#name : #MAMAVParent,
	#superclass : #MAMAVProject,
	#category : #'Maze-OPAX'
}

{ #category : #accessing }
MAMAVParent >> relativePath [
	^(self elements detect: [:each | each name = 'relativePath']) stringNodes first string.
]
