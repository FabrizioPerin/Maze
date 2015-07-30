Class {
	#name : #MAZEPomFileParser,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'factory'
	],
	#category : #'Maze-Importer'
}

{ #category : #'as yet unclassified' }
MAZEPomFileParser class >> parserFileNamed: aString [
	^self new fileName: aString; parse.
]

{ #category : #'as yet unclassified' }
MAZEPomFileParser >> fileName [
	^fileName
]

{ #category : #'as yet unclassified' }
MAZEPomFileParser >> fileName: aString [
	fileName := aString
]

{ #category : #'as yet unclassified' }
MAZEPomFileParser >> initialize [
	
	super initialize.
	
	factory := XMLPluggableElementFactory new
		elementClass: MAPOMEntities;
		handleElement: 'parent' withClass: MAMAVParent;
		handleElement: 'project' withClass: MAMAVProject;
		handleElement: 'modules' withClass: MAMAVModules;
		handleElement: 'module' withClass: MAMAVModule;
		handleElement: 'dependencies' withClass: MAMAVDependencies;
		handleElement: 'dependency' withClass: MAMAVDependency.
	
	^ self
]

{ #category : #'as yet unclassified' }
MAZEPomFileParser >> parse [
	| doc parser |
	
	parser := XMLDOMParser onFileNamed: fileName.
	parser nodeFactory: factory.

	doc := parser parseDocument.
	
	^ doc
]
