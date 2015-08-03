Class {
	#name : #MAZEMavenDependency,
	#superclass : #MEEAssociation,
	#instVars : [
		'sourceProject',
		'targetProject',
		'artifactID',
		'groupID',
		'version',
		'type',
		'scope'
	],
	#category : #'Maze-Core'
}

{ #category : #'as yet unclassified' }
MAZEMavenDependency class >> annotation [
	<MSEClass: #MavenDependency super: #MEEAssociation>
	<package: #MAZE>
	^self
]

{ #category : #accessing }
MAZEMavenDependency >> artifactID [
	^ artifactID
]

{ #category : #accessing }
MAZEMavenDependency >> artifactID: aString [
	artifactID := aString
]

{ #category : #accessing }
MAZEMavenDependency >> from [
	^ self sourceProject
]

{ #category : #accessing }
MAZEMavenDependency >> groupID [
	^ groupID
]

{ #category : #accessing }
MAZEMavenDependency >> groupID: aString [
	groupID := aString
]

{ #category : #accessing }
MAZEMavenDependency >> initialize [

	super initialize.
	
	sourceProject := nil.
	targetProject := nil.
	
"	sourceProject := FMNullMultivalueLink 
		on: self
		opposite: #referencedProjects:
		selector: #sourceProject.
	targetProject := FMNullMultivalueLink 
		on: self
		opposite: #referencingProjects:
		selector: #targetProject."
		
	^ self
	
]

{ #category : #accessing }
MAZEMavenDependency >> scope [
	^ scope
]

{ #category : #accessing }
MAZEMavenDependency >> scope: anObject [
	scope := anObject
]

{ #category : #accessing }
MAZEMavenDependency >> sourceProject [
	<MSEProperty: #sourceProject type: #MAZEMavenProject opposite: #referencedProjects>
	<MSEComment: 'Project referencing another project. from-side of the association'>
	^ sourceProject
]

{ #category : #accessing }
MAZEMavenDependency >> sourceProject: aMAZEMAVENProject [
	sourceProject := FMMultivalueLink 
		on: self
		update: #referencedProjects
		from: self sourceProject
		to: aMAZEMAVENProject
]

{ #category : #accessing }
MAZEMavenDependency >> targetProject [
	<MSEProperty: #targetProject type: #MAZEMavenProject opposite: #referencingProjects>
	<MSEComment: 'Project referencing another project. to-side of the association'>
	^ targetProject
]

{ #category : #accessing }
MAZEMavenDependency >> targetProject: aMAZEMAVENProject [
	targetProject := FMMultivalueLink 
		on: self
		update: #referencingProjects
		from: self targetProject
		to: aMAZEMAVENProject
]

{ #category : #accessing }
MAZEMavenDependency >> to [
	^ self targetProject
]

{ #category : #accessing }
MAZEMavenDependency >> type [
	^ type
]

{ #category : #accessing }
MAZEMavenDependency >> type: anObject [
	type := anObject
]

{ #category : #accessing }
MAZEMavenDependency >> version [
	^ version
]

{ #category : #accessing }
MAZEMavenDependency >> version: anObject [
	version := anObject
]
