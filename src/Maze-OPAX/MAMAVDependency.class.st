Class {
	#name : #MAMAVDependency,
	#superclass : #MAMAVDependencies,
	#category : #'Maze-OPAX'
}

{ #category : #'as yet unclassified' }
MAMAVDependency class >> xmlTags [
	^OrderedCollection with: 'dependency'
]

{ #category : #accessing }
MAMAVDependency >> optional [

	((self children detect: [:each | each tag = 'optional']) characters = 'true')
		ifTrue: [^true] 
		ifFalse: [^false] .
	
]

{ #category : #accessing }
MAMAVDependency >> scope [
	^(self children detect: [:each | each tag = 'scope']) characters
]

{ #category : #accessing }
MAMAVDependency >> type [
	^(self children detect: [:each | each tag = 'type']) characters
]
