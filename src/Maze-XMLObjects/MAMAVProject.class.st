Class {
	#name : #MAMAVProject,
	#superclass : #MAPOMEntities,
	#category : #'Maze-XMLObjects'
}

{ #category : #'as yet unclassified' }
MAMAVProject >> artifactID [
	^ self elements
		detect: [ :each | each name = 'artifactId' ]
		ifFound: [ :element | element stringNodes first string ]
		ifNone: [ nil ]
]

{ #category : #'as yet unclassified' }
MAMAVProject >> createMooseEntity [
	| project |
	
	project := MAZEMavenProject new.
	project artifactID: self artifactID.
	project groupID: self groupID.
	project modelVersion: self modelVersion.
	project version: self version.
	
	^project
]

{ #category : #'as yet unclassified' }
MAMAVProject >> dependenciesElement [
	^ self elements
		detect: [ :each | each isMemberOf: MAMAVDependencies ]
		ifFound: [ :element | element ]
		ifNone: [ nil ]
]

{ #category : #'as yet unclassified' }
MAMAVProject >> fullyQualifiedArtifactName [
	^self groupID, '.', self artifactID, ':', self version
]

{ #category : #'as yet unclassified' }
MAMAVProject >> groupID [
	^ self elements
		detect: [ :each | each name = 'groupId' ]
		ifFound: [ :element | element stringNodes first string ]
		ifNone: [ nil ]
]

{ #category : #'as yet unclassified' }
MAMAVProject >> modelVersion [
	^ self elements
		detect: [ :each | each name = 'modelVersion' ]
		ifFound: [ :element | element stringNodes first string ]
		ifNone: [ nil ]
]

{ #category : #'as yet unclassified' }
MAMAVProject >> parentProject [
	^ self elements
		detect: [ :each | each isMemberOf: MAMAVParent ]
		ifFound: [ :element | element ]
		ifNone: [ nil ]
]

{ #category : #'as yet unclassified' }
MAMAVProject >> version [
	^ self elements
		detect: [ :each | each name = 'version' ]
		ifFound: [ :element | element stringNodes first string ]
		ifNone: [ nil ]
]
