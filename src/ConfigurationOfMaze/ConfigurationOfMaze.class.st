Class {
	#name : #ConfigurationOfMaze,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #ConfigurationOfMaze
}

{ #category : #private }
ConfigurationOfMaze class >> ensureMetacello [
	Smalltalk at: #MetacelloProject ifAbsent: [
		Gofer new
				url: 'http://seaside.gemstone.com/ss/metacello';
				package: 'ConfigurationOfMetacello';
				load.
		(Smalltalk at: #ConfigurationOfMetacello) loadLatestVersion ]
]

{ #category : #testing }
ConfigurationOfMaze class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfMaze class >> loadDefault [

	(self project version: 'default') load.
]

{ #category : #accessing }
ConfigurationOfMaze class >> project [

	^self new project
]

{ #category : #defaults }
ConfigurationOfMaze >> default: spec [ 
	<version: 'default'>
	
	spec for: #common do: [
		spec blessing: #default.
		
		spec  project: 'XMLSupport for MooseJEE' with: [
			spec
				className: 'ConfigurationOfXMLSupport';
				file: 'ConfigurationOfXMLSupport';
				version: '1.2.0';
				repository: 'http://www.squeaksource.com/XMLSupport' ].
		
		spec			
			package: 'Maze-Core' with: [
				spec repository: 'http://www.squeaksource.com/Maze'.];
			package: 'Maze-XMLObjects' with: [
				spec repository: 'http://www.squeaksource.com/Maze'.
				spec requires: 'XMLSupport for MooseJEE'];
			package: 'Maze-Tests-Core' with: [
				spec repository: 'http://www.squeaksource.com/Maze'.
				spec requires: #('Maze-Core')];
			package: 'Maze-Tests-Importer' with: [
				spec repository: 'http://www.squeaksource.com/Maze'.
				spec requires: #('Maze-Core' 'Maze-XMLObjects')];
			package: 'Maze-Tests-XMLObjects' with: [
				spec repository: 'http://www.squeaksource.com/Maze'.
				spec requires: #('Maze-Core' 'Maze-XMLObjects')].
	]
]

{ #category : #accessing }
ConfigurationOfMaze >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project]
]
