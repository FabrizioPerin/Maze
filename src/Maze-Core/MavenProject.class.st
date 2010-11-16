Class {
	#name : #MavenProject,
	#superclass : #Object,
	#instVars : [
		'groupID',
		'artifactID',
		'version',
		'packaging'
	],
	#category : #'Maze-Core'
}

{ #category : #accessing }
MavenProject >> artifactID [
	^ artifactID
]

{ #category : #accessing }
MavenProject >> artifactID: aString [
	artifactID := aString
]

{ #category : #accessing }
MavenProject >> groupID [
	^ groupID
]

{ #category : #accessing }
MavenProject >> groupID: aString [
	groupID := aString
]

{ #category : #accessing }
MavenProject >> packaging [
	^ packaging
]

{ #category : #accessing }
MavenProject >> packaging: aString [
	packaging := aString
]

{ #category : #accessing }
MavenProject >> version [
	^ version
]

{ #category : #accessing }
MavenProject >> version: aString [
	version := aString
]
