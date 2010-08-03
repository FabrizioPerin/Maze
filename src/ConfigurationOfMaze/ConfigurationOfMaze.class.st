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
		spec
			package: 'XML-Parser' with: [spec repository: 'http://www.squeaksource.com/XMLSupport'];				
			package: 'Maze-Core' with: [spec repository: 'http://www.squeaksource.com/Maze'.];
			package: 'Maze-OPAX' with: [
				spec repository: 'http://www.squeaksource.com/Maze'.
				spec requires: #('XML-Parser')];
			package: 'Maze-Tests' with: [
				spec repository: 'http://www.squeaksource.com/Maze'.
				spec requires: #('Maze-Core' 'Maze-OPAX')].
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
