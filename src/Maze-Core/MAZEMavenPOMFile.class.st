Class {
	#name : #MAZEMavenPOMFile,
	#superclass : #MEEEntity,
	#instVars : [
		'project'
	],
	#category : #'Maze-Core'
}

{ #category : #'as yet unclassified' }
MAZEMavenPOMFile class >> annotation [
	<MSEClass: #MavenPOMFile super: #FAMIXNamedEntity>
	<package: #MA>
	^self
]

{ #category : #accessing }
MAZEMavenPOMFile >> project [
	^ project
]

{ #category : #accessing }
MAZEMavenPOMFile >> project: aMazeMavenProject [
	self project = aMazeMavenProject
		ifFalse: [ 
			project := aMazeMavenProject.
			aMazeMavenProject pomFile: self ]
]
