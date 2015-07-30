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
MAZEMavenPOMImporter >> importEjbJarFromFolder: aString [
	
	| fileSystem entries directoryEntries parser factory doc root counter |
	
	fileSystem := FileSystem disk referenceTo: aString.
	entries := CollectVisitor breadthFirst: fileSystem.
	
	directoryEntries := entries select: [:entry| '.*ejb-jar.xml$' asRegex matches: entry reference name ].

	counter := 1.			
	UIManager default
		displayProgress: 'Importing From ejb-jar files'
		from: 1 
		to: directoryEntries size
		during: [ :bar | 
			bar  value: counter.
			
			directoryEntries do: [:entry |
				
					 | stream |
					
					stream := StandardFileStream readOnlyFileNamed: (entry reference name).
					parser := XMLDOMParser on: stream.
					factory := XMLPluggableElementFactory new
									elementClass: MJEJBeanElement;
									handleElement: 'entity' withClass: MJEntityElement;
									handleElement: 'message-driven' withClass: MJMessageDrivenElement;
									handleElement: 'session' withClass: MJSessionElement;
									handleElement: 'container-transaction' withClass: MJContainerTransactionElement.
					parser nodeFactory: factory.
					doc := parser parseDocument.
					root := doc root.
							
					(root allElements select: [:eachElement | eachElement class = MJSessionElement])  do: [:eachElement |
							eachElement populate: self].
					(root allElements select: [:eachElement | eachElement class = MJEntityElement])  do: [:eachElement |
							eachElement populate: self].
					(root allElements select: [:eachElement | eachElement class = MJMessageDrivenElement])  do: [:eachElement |
							eachElement populate: self].
					(root allElements select: [:eachElement | eachElement class = MJContainerTransactionElement]) do: [:eachElement |
							eachElement populate: self].
					counter := counter + 1.
					bar value: counter.
				]].

]

{ #category : #'as yet unclassified' }
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
					
					mm silentlyAdd: pomFile.
					mm silentlyAdd: projectNodes first.	
					
					"creating dependencies"
					dependenciesNodes := root allElements select: [ :el | el isMemberOf: MAMAVDependency] thenCollect: #createFamixEntity.
					
					
					bar increment ] ]
		description: 'Importing pom files'
		length: pomFileDocs size.
		
	^ pomFileDocs
]

{ #category : #'as yet unclassified' }
MAZEMavenPOMImporter >> initializeWith: aMooseModel on: aRootFolderName [
	mm := aMooseModel.
	rootFolderName := aRootFolderName.
	
	^ self
]
