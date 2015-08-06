Class {
	#name : #MAMAVDependencyManagement,
	#superclass : #MAMAVProject,
	#category : #'Maze-XMLObjects'
}

{ #category : #'as yet unclassified' }
MAMAVDependencyManagement >> dependenciesElement [
	^ self elements
		detect: [ :each | each isMemberOf: MAMAVDependencies ]
		ifFound: [ :element | element ]
		ifNone: [ nil ]
]
