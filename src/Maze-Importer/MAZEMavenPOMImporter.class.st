Class {
	#name : #MAZEMavenPOMImporter,
	#superclass : #Object,
	#instVars : [
		'rootFolderName',
		'model'
	],
	#category : #'Maze-Importer'
}

{ #category : #'as yet unclassified' }
MAZEMavenPOMImporter class >> with: aMooseModel on: aRootFolderName [ 
	^ self new initializeWith: aMooseModel on: aRootFolderName 
]

{ #category : #import }
MAZEMavenPOMImporter >> importPOMsIntoMooseModel [
	| rootFolder pomFileDocs pomFiles |
	
	rootFolder := FileSystemResolver new resolveString: rootFolderName.
	pomFiles := rootFolder allEntries select: [ :entry | entry isFile and: [ entry name = 'pom.xml' ] ].
	pomFileDocs := pomFiles collect: [ :pomFile | MAZEPomFileParser parserFileNamed: pomFile reference ].
	
	MooseCustomTask
		runWithProgress: [ :bar | 
			pomFileDocs
				do: [ :doc | 
					| root projectNodes pomFile dependenciesNodes |
					
					root := doc root.
					
					"creating project node"
					projectNodes := root allElements select: [ :el | el isMemberOf: MAMAVProject ] thenCollect: #createFamixEntity.
					
					self assert: projectNodes size = 1.
					
					pomFile := MAZEMavenPOMFile new.
					pomFile project: projectNodes first.
					
					model silentlyAdd: pomFile.
					model silentlyAdd: projectNodes first.	
					
					"creating dependencies"
					dependenciesNodes := root allElements select: [ :el | el isMemberOf: MAMAVDependency] thenCollect: #createFamixEntity.
					
					dependenciesNodes do: [ :dependency | dependency sourceProject: projectNodes first ].
					
					model silentlyAddAll: dependenciesNodes.
					
					bar increment ] ]
		description: 'Importing pom files'
		length: pomFileDocs size.
	
]

{ #category : #initialization }
MAZEMavenPOMImporter >> initializeWith: aMooseModel on: aRootFolderName [
	model := aMooseModel.
	rootFolderName := aRootFolderName.
	
	^ self
]

{ #category : #accessing }
MAZEMavenPOMImporter >> model [
	^ model
]

{ #category : #accessing }
MAZEMavenPOMImporter >> rootFolderName [
	^ rootFolderName
]
