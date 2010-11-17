Class {
	#name : #MAZEMavenProjectTests,
	#superclass : #TestCase,
	#category : #'Maze-Tests-Core'
}

{ #category : #'as yet unclassified' }
MAZEMavenProjectTests >> testCreation [
	| project |
	
	project := MAZEMavenProject new.
	project 
		groupID: 'org.codehaus.mojo';
		artifactID: 'my-project';
		version: '1.0';
		modelVersion: '4.0.0'.
	
	self assert: (project isMemberOf: MAZEMavenProject).
	self assert: (project groupID = 'org.codehaus.mojo').
	self assert: (project artifactID = 'my-project').
	self assert: (project version = '1.0').
	self assert: (project modelVersion = '4.0.0').
	self assert: (project fullyQualifiedArtifactName = 'org.codehaus.mojo.my-project:1.0').
]
