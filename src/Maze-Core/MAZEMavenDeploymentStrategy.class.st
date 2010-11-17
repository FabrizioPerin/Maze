Class {
	#name : #MAZEMavenDeploymentStrategy,
	#superclass : #Object,
	#instVars : [
		'poms'
	],
	#category : #'Maze-Core'
}

{ #category : #accessing }
MAZEMavenDeploymentStrategy >> initialize [
	poms := OrderedCollection new.
]

{ #category : #accessing }
MAZEMavenDeploymentStrategy >> poms [
	^ poms
]

{ #category : #accessing }
MAZEMavenDeploymentStrategy >> poms: aMavenPOMFile [
	poms addLast: aMavenPOMFile
]
