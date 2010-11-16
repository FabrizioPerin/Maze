Class {
	#name : #MAMAVParent,
	#superclass : #MAMAVProject,
	#category : #'Maze-OPAX'
}

{ #category : #'as yet unclassified' }
MAMAVParent class >> xmlTags [
	^OrderedCollection with: 'parent'
]

{ #category : #accessing }
MAMAVParent >> relativePath [
	^(self children detect: [:each | each tag = 'relativePath']) characters.
]
