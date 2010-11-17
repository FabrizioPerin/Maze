Class {
	#name : #MAZEMavenProject,
	#superclass : #Object,
	#instVars : [
		'groupID',
		'artifactID',
		'version',
		'packaging',
		'modelVersion'
	],
	#category : #'Maze-Core'
}

{ #category : #accessing }
MAZEMavenProject >> artifactID [
	^ artifactID
]

{ #category : #accessing }
MAZEMavenProject >> artifactID: aString [
	artifactID := aString
]

{ #category : #'as yet unclassified' }
MAZEMavenProject >> fullyQualifiedArtifactName [
	^self groupID, '.', self artifactID, ':', self version
]

{ #category : #accessing }
MAZEMavenProject >> groupID [
	^ groupID
]

{ #category : #accessing }
MAZEMavenProject >> groupID: aString [
	groupID := aString
]

{ #category : #accessing }
MAZEMavenProject >> modelVersion [
	^ modelVersion
]

{ #category : #accessing }
MAZEMavenProject >> modelVersion: aString [
	modelVersion := aString
]

{ #category : #accessing }
MAZEMavenProject >> packaging [
	^ packaging
]

{ #category : #accessing }
MAZEMavenProject >> packaging: anObject [
	packaging := anObject
]

{ #category : #accessing }
MAZEMavenProject >> version [
	^ version
]

{ #category : #accessing }
MAZEMavenProject >> version: aString [
	version := aString
]
