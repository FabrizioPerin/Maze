Class {
	#name : #MAZEMavenPOMImporter,
	#superclass : #Object,
	#instVars : [
		'mm',
		'rootFolderName'
	],
	#category : #'Maze-Importer'
}

{ #category : #'as yet unclassified' }
MAZEMavenPOMImporter class >> with: aMooseModel on: aRootFolderName [ 
	^ self new initializeWith: aMooseModel on: aRootFolderName 
]

{ #category : #'as yet unclassified' }
MAZEMavenPOMImporter >> importPOMsIntoMooseModel [
	| rootFolder pomFileDocs pomFiles |
	
	rootFolder := FileSystemResolver new resolveString: rootFolderName.
	pomFiles := rootFolder allEntries select: [ :entry | entry isFile and: [ entry name = 'pom.xml' ] ].
	pomFileDocs := pomFiles collect: [ :pomFile | MAZEPomFileParser parserFileNamed: pomFile reference ].
	
	
	
	^ pomFileDocs
]

{ #category : #'as yet unclassified' }
MAZEMavenPOMImporter >> initializeWith: aMooseModel on: aRootFolderName [
	mm := aMooseModel.
	rootFolderName := aRootFolderName.
	
	^ self
]
