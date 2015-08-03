Class {
	#name : #MAZEMavenPOMImporter,
	#superclass : #Object,
	#instVars : [
		'rootFolderName',
		'model',
		'visitor',
		'famixDependencies',
		'famixProjects',
		'famixPomFiles'
	],
	#category : #'Maze-Importer'
}

{ #category : #'as yet unclassified' }
MAZEMavenPOMImporter class >> with: aMooseModel on: aRootFolderName [
	| imp |
	
	imp := self new.
	
	imp model: aMooseModel.
	imp rootFolderName: aRootFolderName.
	
	^ imp
]

{ #category : #import }
MAZEMavenPOMImporter >> import [
	
	MooseCustomTask
		runWithProgress: [ :bar | 
			self importPOMs.
			bar increment.
			
			self reifyElements.
			bar increment.
			
			self importIntoModel.
			bar increment ]
		description: 'Importing MAVEN info...'
		length: 3.
	
	^ model
]

{ #category : #initialization }
MAZEMavenPOMImporter >> importIntoModel [

MooseCustomTask
		runWithProgress: [ :bar | 
			model silentlyAddAll: famixPomFiles.
			bar increment.
			
			model silentlyAddAll: famixProjects.
			bar increment.
			
			model silentlyAddAll: famixDependencies.
			bar increment ]
		description: 'Importing Into Model'
		length: 3.
	
	^ model
	
	
]

{ #category : #import }
MAZEMavenPOMImporter >> importPOMs [
	| rootFolder pomFiles |
	
	rootFolder := FileSystemResolver new resolveString: rootFolderName.
	pomFiles := rootFolder allEntries select: [ :entry | entry isFile and: [ entry name = 'pom.xml' ] ].
	
	MooseCustomTask
		runWithProgress: [ :bar | 
			pomFiles
				do: [ :pomFile | 					
					self importProject: pomFile.
					bar increment ] ]
		description: 'Importing pom files'
		length: (pomFiles size * 2).

]

{ #category : #import }
MAZEMavenPOMImporter >> importPOMsIntoMooseModel [
	| rootFolder pomFiles |
	
	rootFolder := FileSystemResolver new resolveString: rootFolderName.
	pomFiles := rootFolder allEntries select: [ :entry | entry isFile and: [ entry name = 'pom.xml' ] ].
	
	MooseCustomTask
		runWithProgress: [ :bar | 
			pomFiles
				do: [ :pomFile | 
					| root projectNodes famixPomFile dependenciesNodes doc |
					doc := MAZEPomFileParser parserFileNamed: pomFile reference.
					root := doc root.
					
					self halt.
					"creating project node"
					projectNodes := root allElements select: [ :el | el isMemberOf: MAMAVProject ] thenCollect: [:el | visitor visit: el ].
					
					self assert: projectNodes size = 1.
				
					famixPomFile := MAZEMavenPOMFile new name: pomFile reference asString.
					famixPomFile project: projectNodes first.
					
					model silentlyAdd: famixPomFile.
					model silentlyAdd: projectNodes first.	
					
					"creating dependencies"
					dependenciesNodes := root allElements select: [ :el | el isMemberOf: MAMAVDependency] thenCollect: #createFamixEntity.
					
					dependenciesNodes do: [ :dependency | dependency sourceProject: projectNodes first ].
					
					model silentlyAddAll: dependenciesNodes.
					
					bar increment ] ]
		description: 'Importing pom files'
		length: pomFiles size.
	self halt.
]

{ #category : #initialization }
MAZEMavenPOMImporter >> importProject: pomFile [
	| root projectNode famixPomFile dependencyNodes doc famixProject |
	
	doc := MAZEPomFileParser parserFileNamed: pomFile reference.
	root := doc root.	
		
	"creating project node"
	projectNode := (root allElements select: [ :el | el isMemberOf: MAMAVProject ]) first.
	famixProject := projectNode accept: visitor.
	famixProjects add: famixProject.	
	
	"creating file"
	famixPomFile := MAZEMavenPOMFile new name: pomFile reference asString.
	famixPomFile project: famixProject.
	famixPomFiles add: famixPomFile.
	
	"importing parent"
	famixProject parentProjectNode: projectNode parentProject.
	
	"creating dependencies"
	dependencyNodes := projectNode dependenciesElement dependencies.
	famixDependencies addAll: (dependencyNodes collect: [ :dependencyNode | dependencyNode accept: visitor ])
]

{ #category : #initialization }
MAZEMavenPOMImporter >> initialize [
	super initialize.
	
	visitor := MAZEPomFileVisitor new.
	
	famixDependencies := OrderedCollection new.
	famixProjects := OrderedCollection new.
	famixPomFiles := OrderedCollection new.
	
	^ self
]

{ #category : #accessing }
MAZEMavenPOMImporter >> model [
	^ model
]

{ #category : #initialization }
MAZEMavenPOMImporter >> model: aMooseModel [
	model := aMooseModel
]

{ #category : #import }
MAZEMavenPOMImporter >> reifyElements [
	| rootFolder pomFiles |
	
	rootFolder := FileSystemResolver new resolveString: rootFolderName.
	pomFiles := rootFolder allEntries select: [ :entry | entry isFile and: [ entry name = 'pom.xml' ] ].
	
	MooseCustomTask
		runWithProgress: [ :bar | 
			pomFiles
				do: [ :pomFile | 
					
					self importProject: pomFile.
					bar increment.
					
					self importIntoModel.
					bar increment ] ]
		description: 'Importing pom files'
		length: (pomFiles size * 2).
	
	^ model
]

{ #category : #initialization }
MAZEMavenPOMImporter >> reifyParents [
]

{ #category : #accessing }
MAZEMavenPOMImporter >> rootFolderName [
	^ rootFolderName
]

{ #category : #initialization }
MAZEMavenPOMImporter >> rootFolderName: aString [
	rootFolderName := aString
]
