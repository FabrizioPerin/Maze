Class {
	#name : #MAMAVProject,
	#superclass : #MAPOMEntities,
	#category : #'Maze-OPAX'
}

{ #category : #'as yet unclassified' }
MAMAVProject class >> xmlTags [
	^OrderedCollection with: 'project'
]

{ #category : #'as yet unclassified' }
MAMAVProject >> artifactID [
	^(self children detect: [:each | each tag = 'artifactId']) characters.
]

{ #category : #'as yet unclassified' }
MAMAVProject >> fullyQualifiedArtifactName [
	^self groupID, '.', self artifactID, ':', self version
]

{ #category : #'as yet unclassified' }
MAMAVProject >> groupID [
	^(self children detect: [:each | each tag = 'groupId']) characters.
]

{ #category : #'as yet unclassified' }
MAMAVProject >> modelVersion [
	^(self children detect: [:each | each tag = 'modelVersion']) characters.
]

{ #category : #'as yet unclassified' }
MAMAVProject >> version [
	^(self children detect: [:each | each tag = 'version']) characters.
]
