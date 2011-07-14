Class {
	#name : #MAMAVDependency,
	#superclass : #MAMAVDependencies,
	#category : #'Maze-OPAX'
}

{ #category : #accessing }
MAMAVDependency >> optional [

	((self elements detect: [:each | each name = 'optional']) stringNodes first string = 'true')
		ifTrue: [^true] 
		ifFalse: [^false] .
	
]

{ #category : #accessing }
MAMAVDependency >> scope [
	^(self elements detect: [:each | each name = 'scope']) stringNodes first string.
]

{ #category : #accessing }
MAMAVDependency >> type [
	^(self elements detect: [:each | each name = 'type']) stringNodes first string.
]
