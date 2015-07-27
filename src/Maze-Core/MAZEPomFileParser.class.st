Class {
	#name : #MAZEPomFileParser,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'parser',
		'factory'
	],
	#category : #'Maze-Core'
}

{ #category : #'as yet unclassified' }
MAZEPomFileParser class >> parserFileNamed: aString [
	^self new fileName: aString; parser.
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

	factory := XMLPluggableElementFactory new
		elementClass: MAPOMEntities;
		handleElement: 'parent' withClass: MAMAVParent;
		handleElement: 'project' withClass: MAMAVProject;
		handleElement: 'modules' withClass: MAMAVModules;
		handleElement: 'module' withClass: MAMAVModule;
		handleElement: 'dependencies' withClass: MAMAVDependencies;
		handleElement: 'dependency' withClass: MAMAVDependency
]

{ #category : #'as yet unclassified' }
MAZEPomFileParser >> parse [
	
	| doc root dependencies |
	parser := XMLDOMParser parseFileNamed: fileName.	

	parser nodeFactory: factory.  
	
	doc := parser parseDocument.
	root := doc root.

	self assert: (root allElements select: [:each | each isMemberOf: MAMAVDependencies ]) size = 1.
	
	dependencies := (root allElements select: [:each | each isMemberOf: MAMAVDependencies ]) first.
	
	self assert: (dependencies elements size = 1).
	self assert: (dependencies elements first isMemberOf: MAMAVDependency).
]
