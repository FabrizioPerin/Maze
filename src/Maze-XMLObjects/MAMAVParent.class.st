Class {
	#name : #MAMAVParent,
	#superclass : #MAMAVProject,
	#category : #'Maze-XMLObjects'
}

{ #category : #accessing }
MAMAVParent >> createFamixEntity [
	| project |
	
	project := MAZEMavenProject new.
	project artifactID: self artifactID.
	project groupID: self groupID.
	project modelVersion: self modelVersion.
	project version: self version.
	
	^project
]

{ #category : #accessing }
MAMAVParent >> relativePath [
	^ self elements
		detect: [ :each | each name = 'relativePath' ]
		ifFound: [ :element | element stringNodes first string ]
		ifNone: [ nil ]
]
