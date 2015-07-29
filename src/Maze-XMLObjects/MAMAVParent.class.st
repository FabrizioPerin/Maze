Class {
	#name : #MAMAVParent,
	#superclass : #MAMAVProject,
	#category : #'Maze-XMLObjects'
}

{ #category : #accessing }
MAMAVParent >> relativePath [
	^ self elements
		detect: [ :each | each name = 'relativePath' ]
		ifFound: [ :element | element stringNodes first string ]
		ifNone: [ nil ]
]
