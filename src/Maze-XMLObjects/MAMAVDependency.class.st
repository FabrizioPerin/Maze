Class {
	#name : #MAMAVDependency,
	#superclass : #MAMAVDependencies,
	#category : #'Maze-XMLObjects'
}

{ #category : #accessing }
MAMAVDependency >> createFamixEntity [
	| project |
	
	project := MAZEMavenDependency new.
	project artifactID: self artifactID.
	project groupID: self groupID.
	project version: self version.
	project type: self type.
	project scope: self scope.
	
	^ project
]

{ #category : #accessing }
MAMAVDependency >> optional [
	^ self elements
		detect: [ :each | each name = 'optional' ]
		ifFound: [ :element | element stringNodes first string = 'true' ]
		ifNone: [ nil ]
]

{ #category : #accessing }
MAMAVDependency >> scope [
	^ self elements
		detect: [ :each | each name = 'scope' ]
		ifFound: [ :element | element stringNodes first string ]
		ifNone: [ nil ]
]

{ #category : #accessing }
MAMAVDependency >> type [
	^ self elements
		detect: [ :each | each name = 'type' ]
		ifFound: [ :element | element stringNodes first string ]
		ifNone: [ nil ]
]
