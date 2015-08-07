Class {
	#name : #MAMAVDependency,
	#superclass : #MAMAVDependencies,
	#category : #'Maze-XMLObjects'
}

{ #category : #accessing }
MAMAVDependency >> accept: aVisitor [
	^ aVisitor visitDependencyNode: self
]

{ #category : #accessing }
MAMAVDependency >> createFamixEntity [
	| dependency |
	
	dependency := MAZEMavenDependency new.
	dependency artifactID: self artifactID.
	dependency groupID: self groupID.
	dependency version: self version.
	dependency type: self type.
	dependency scope: self scope.
	dependency dependencyNode: self.
	
	^ dependency
]

{ #category : #accessing }
MAMAVDependency >> createTargetStubPrject [
	| stubProject |
	
	stubProject := MAZEMavenProject new.
	stubProject artifactID: self artifactID.
	stubProject groupID: self groupID.
	stubProject version: self version.
	stubProject packaging: self packaging.
	stubProject modelVersion: self modelVersion.
	stubProject version: self version.

	stubProject isStub: true.
	
	^ stubProject
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
