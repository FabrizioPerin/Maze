Class {
	#name : #MAMAVProject,
	#superclass : #MAPOMEntities,
	#category : #'Maze-XMLObjects'
}

{ #category : #'as yet unclassified' }
MAMAVProject >> artifactID [
	^(self elements detect: [:each | each name = 'artifactId']) stringNodes first string.
]

{ #category : #'as yet unclassified' }
MAMAVProject >> fullyQualifiedArtifactName [
	^self groupID, '.', self artifactID, ':', self version
]

{ #category : #'as yet unclassified' }
MAMAVProject >> groupID [
	^(self elements detect: [:each | each name = 'groupId']) stringNodes first string.
]

{ #category : #'as yet unclassified' }
MAMAVProject >> modelVersion [
	^(self elements detect: [:each | each name = 'modelVersion']) stringNodes first string.
]

{ #category : #'as yet unclassified' }
MAMAVProject >> version [
	^(self elements detect: [:each | each name = 'version']) stringNodes first string.
]
