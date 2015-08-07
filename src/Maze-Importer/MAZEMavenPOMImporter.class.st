Class {
	#name : #MAZEMavenPOMImporter,
	#superclass : #Object,
	#instVars : [
		'rootFolderName',
		'model',
		'visitor',
		'famixDependencies',
		'famixProjects',
		'famixPomFiles',
		'unconnectedElements'
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

{ #category : #private }
MAZEMavenPOMImporter >> addToModel [

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
MAZEMavenPOMImporter >> import [
	
	MooseCustomTask
		runWithProgress: [ :bar | 
			self importPOMs.
			bar increment.
			
			self reifyElements.
			bar increment.
			
			self addToModel.
			bar increment.
			
			self reifyMavenCodeConnections.
			bar increment ]
		description: 'Importing MAVEN info...'
		length: 4.
	
	^ self 
]

{ #category : #private }
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
		length: pomFiles size.

]

{ #category : #private }
MAZEMavenPOMImporter >> importProject: pomFile [
	| root projectNode famixPomFile  doc famixProject |
	
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
	projectNode dependenciesElement 
		ifNotNil: [ :de | 
	famixDependencies addAll: (de dependencies collect: [ :dependencyNode | dependencyNode accept: visitor ])].
	
	projectNode dependencyManagement 
		ifNotNil: [ :dm | 
			famixDependencies addAll: (dm dependenciesElement dependencies collect: [ :dependencyNode | dependencyNode accept: visitor ] ) ]
]

{ #category : #initialization }
MAZEMavenPOMImporter >> initialize [
	super initialize.
	
	visitor := MAZEPomFileVisitor new.
	
	famixDependencies := OrderedCollection new.
	famixProjects := OrderedCollection new.
	famixPomFiles := OrderedCollection new.
	unconnectedElements := OrderedCollection new.
	
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

{ #category : #private }
MAZEMavenPOMImporter >> reifyDependencies [
	| stubs |
	
	stubs := OrderedCollection new.
	
	"cicle on all the known projects to reify their parentNodes"
	famixDependencies 
		do: [ :famixDependency |
			famixProjects
				detect: [ :famixProject | famixProject isReferencedProject: famixDependency ]
				ifFound: [ :famixProject | famixDependency targetProject: famixProject ] 
				ifNone: [ 
					| stubProject |
					
					stubProject := famixDependency dependencyNode createTargetStubPrject.
					stubs add: stubProject.
					famixDependency targetProject: stubProject ] ].
			
	famixProjects addAll: stubs.
]

{ #category : #private }
MAZEMavenPOMImporter >> reifyElements [
		
	MooseCustomTask
		runWithProgress: [ :bar | 
			self reifyParents.
			bar increment.
			
			self reifyDependencies.
			bar increment ]
		description: 'Importing pom files'
		length: 2.
	
	^ model
]

{ #category : #private }
MAZEMavenPOMImporter >> reifyMavenCodeConnections [

	model allModelClasses
		do: [ :famixClass | 
			model allMavenProjects
				do: [ :famixMavProject | 
					(((MooseUtilities demoosify: famixClass belongsTo mooseName) findString: famixMavProject groupID) > 0
						and: [ (famixClass sourceAnchor mooseName findString: famixMavProject artifactID) > 0 ])
						ifTrue: [ famixClass mavenProject: famixMavProject ] ].
					
			(famixClass mavenProject isNil or: [ (famixClass mavenProject isMemberOf: MAZEMavenProject) not ])
				ifTrue: [ unconnectedElements add: famixClass ] ]
]

{ #category : #private }
MAZEMavenPOMImporter >> reifyParents [
	| parentProjectNodes stubs |
	parentProjectNodes := famixProjects collect: #parentProjectNode.
	stubs := OrderedCollection new.
	
	"cicle on all the known projects to reify their parentNodes"
	famixProjects
		do: [ :famixProject | 
			| parentNode |
			parentNode := famixProject parentProjectNode.
			"if a parentNode is attached to this famixPoject element add it as parentNode otherwise create a stub"
			parentNode
				ifNotNil: [ :pNode | 
					famixProjects 
						detect: [ :famixParentPrj | famixParentPrj isEqualsTo: pNode ] 
						ifFound: [ :famixParentPrj | famixProject parentProject: famixParentPrj ] 
						ifNone: [ | stubParent |
							stubParent := pNode accept: visitor.
							stubParent isStub: true.
							stubs add: stubParent.
							famixProject parentProject: stubParent ] ] ].
			
	famixProjects addAll: stubs.
]

{ #category : #accessing }
MAZEMavenPOMImporter >> rootFolderName [
	^ rootFolderName
]

{ #category : #initialization }
MAZEMavenPOMImporter >> rootFolderName: aString [
	rootFolderName := aString
]
