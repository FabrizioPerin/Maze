Class {
	#name : #MAZEMavenProject,
	#superclass : #FAMIXNamedEntity,
	#instVars : [
		'groupID',
		'artifactID',
		'version',
		'packaging',
		'modelVersion',
		'referencedProjects',
		'referencingProjects',
		'parentProject',
		'childProject',
		'pomFile',
		'parentProjectNode'
	],
	#category : #'Maze-Core'
}

{ #category : #'as yet unclassified' }
MAZEMavenProject class >> annotation [
	<MSEClass: #MavenProject super: #FAMIXNamedEntity>
	<package: #MAZE>
	^self
]

{ #category : #accessing }
MAZEMavenProject >> addReferencedProjects: aMazeMavenDependency [
	referencedProjects add: aMazeMavenDependency
]

{ #category : #accessing }
MAZEMavenProject >> addReferencingProjects: aMazeMavenDependency [
	referencingProjects add: aMazeMavenDependency
]

{ #category : #accessing }
MAZEMavenProject >> artifactID [
	^ artifactID
]

{ #category : #accessing }
MAZEMavenProject >> artifactID: aString [
	artifactID := aString
]

{ #category : #accessing }
MAZEMavenProject >> belongsTo [
^self
]

{ #category : #accessing }
MAZEMavenProject >> childProject [
	^ childProject
]

{ #category : #accessing }
MAZEMavenProject >> childProject: aMAZEMavenProject [

		(aMAZEMavenProject = self childProject)
		ifFalse: [ 
			childProject := aMAZEMavenProject.
			aMAZEMavenProject parentProject: self ]. 

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
MAZEMavenProject >> initialize [
	super initialize.
	referencedProjects := FMMultivalueLink on: self opposite: #sourceProject:.
	referencingProjects := FMMultivalueLink on: self opposite: #targetProject:.
]

{ #category : #'as yet unclassified' }
MAZEMavenProject >> isEqualTo: aMazeMavenProject [

	aMazeMavenProject ifNil: [^ false].
	self groupID = aMazeMavenProject groupID ifFalse: [ ^ false ].
	self artifactID = aMazeMavenProject artifactID ifFalse: [ ^ false ].
	self packaging = aMazeMavenProject packaging ifFalse: [ ^ false ].
	
	^ true
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
MAZEMavenProject >> parentProject [
	^ parentProject
]

{ #category : #accessing }
MAZEMavenProject >> parentProject: aMAZEMavenProject [

	(aMAZEMavenProject = self parentProject)
		ifFalse: [ 
			parentProject := aMAZEMavenProject.
			aMAZEMavenProject childProject: self ]. 

]

{ #category : #accessing }
MAZEMavenProject >> parentProjectNode [
	^ parentProjectNode
]

{ #category : #accessing }
MAZEMavenProject >> parentProjectNode: anObject [
	parentProjectNode := anObject
]

{ #category : #accessing }
MAZEMavenProject >> pomFile [
	^ pomFile
]

{ #category : #accessing }
MAZEMavenProject >> pomFile: aMazeMavenPOMFile [

	self pomFile = aMazeMavenPOMFile
		ifFalse: [ 
			pomFile := aMazeMavenPOMFile.
			aMazeMavenPOMFile project: self ]
]

{ #category : #accessing }
MAZEMavenProject >> printOn: aStream [

	self groupID ifNotNil: [ aStream nextPutAll: self groupID , '.' ].
	self artifactID ifNotNil: [ aStream nextPutAll: self artifactID ].
	self version ifNotNil: [ aStream nextPutAll: ':' , self version ].
	
	aStream nextPutAll: '(MAZEMavenProject)'
]

{ #category : #accessing }
MAZEMavenProject >> referencedProjects [
	<MSEProperty: #referencedProjects type: #MAZEMavenDependency opposite: #sourceProject> <multivalued> <derived>
	<MSEComment: 'Dependencies to other MAVEN projects. from-side of the association'>
	^ referencedProjects
]

{ #category : #accessing }
MAZEMavenProject >> referencedProjects: aMAZEMavenDependency [
	referencedProjects value: aMAZEMavenDependency
]

{ #category : #accessing }
MAZEMavenProject >> referencingProjects [
 	<MSEProperty: #referencingProjects type: #MAZEMavenDependency opposite: #targetProject> <multivalued> <derived>
	<MSEComment: 'Dependencies to other MAVEN projects. from-side of the association'>
	^ referencingProjects
]

{ #category : #accessing }
MAZEMavenProject >> referencingProjects: aMAZEMavenDependency [
	referencingProjects value: aMAZEMavenDependency
]

{ #category : #accessing }
MAZEMavenProject >> sourceText [
	^ ''
]

{ #category : #accessing }
MAZEMavenProject >> version [
	^ version
]

{ #category : #accessing }
MAZEMavenProject >> version: aString [
	version := aString
]
