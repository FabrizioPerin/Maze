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

{ #category : #loading }
ConfigurationOfMaze class >> loadDevelopment [

	(self project version: #development) load.
]

{ #category : #accessing }
ConfigurationOfMaze class >> project [

	^self new project
]

{ #category : #defaults }
ConfigurationOfMaze >> baseline10: spec [ 
	<version: '1.0-baseline'>
	
	spec for: #common do: [
		spec blessing: #default.
		
		spec			
			package: 'Maze-Core' with: [
				spec repository: 'http://www.squeaksource.com/Maze'.];
			package: 'Maze-XMLObjects' with: [
				spec repository: 'http://www.squeaksource.com/Maze'.
				"spec requires: 'XMLSupport for MooseJEE'"];
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

{ #category : #defaults }
ConfigurationOfMaze >> baseline20: spec [ 
	<version: '2.0-baseline'>
	
	spec for: #common do: [
		spec repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Maze/main'.
		spec blessing: #development.
		
		spec			
			package: 'Maze-Core';
			package: 'Maze-XMLObjects';
			
			"Tests"
			package: 'Maze-Tests-Core' with: [	spec requires: #( 'Maze-Core') ];
			package: 'Maze-Tests-Importer' with: [	spec requires: #( 'Maze-Core' 'Maze-XMLObjects' ) ];
			package: 'Maze-Tests-XMLObjects' with: [ spec requires: #('Maze-Core' 'Maze-XMLObjects' ) ].
	]
]

{ #category : #defaults }
ConfigurationOfMaze >> baseline30: spec [ 
	<version: '3.0-baseline'>
	
	spec for: #common do: [
		spec repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Maze/main'.
		spec blessing: #baseline.
		
		spec			
			package: 'Maze-Core';
			package: 'Maze-XMLObjects';
			package: 'Maze-Importer';
			
			"Tests"
			package: 'Maze-Tests-Core' with: [	spec requires: #( 'Maze-Core') ];
			package: 'Maze-Tests-Importer' with: [	spec requires: #( 'Maze-Core' 'Maze-Importer' ) ];
			package: 'Maze-Tests-XMLObjects' with: [ spec requires: #('Maze-Core' 'Maze-XMLObjects' ) ].
	]
]

{ #category : #accessing }
ConfigurationOfMaze >> development: spec [
	<symbolicVersion: #development>

	spec for: #'pharo1.4.x' version: '1.0-baseline'.
	spec for: #'pharo2.x' version: '2.0'.
	spec for: #'pharo3.x' version: '3.0-baseline'.
	spec for: #'pharo4.x' version: '3.0-baseline'.
	spec for: #'pharo5.x' version: '3.0-baseline'.
	spec for: #'pharo7.x' version: '3.0-baseline'.
	spec for: #'pharo8.x' version: '3.0-baseline'.
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

{ #category : #defaults }
ConfigurationOfMaze >> version20: spec [ 
	<version: '2.0' imports: #('2.0-baseline')>
	
	spec for: #common do: [
		spec repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Maze/main'.
		spec blessing: #development.
		
		spec			
			package: 'Maze-Core' with: 'Maze-Core-FabrizioPerin.3';
			package: 'Maze-XMLObjects' with: 'Maze-XMLObjects-FabrizioPerin.1';
			
			"Tests"
			package: 'Maze-Tests-Core' with: 'Maze-Tests-Core-FabrizioPerin.1';
			package: 'Maze-Tests-Importer' with: 'Maze-Tests-Importer-FabrizioPerin.1';
			package: 'Maze-Tests-XMLObjects' with: 'Maze-Tests-XMLObjects-FabrizioPerin.2' ]
]

{ #category : #defaults }
ConfigurationOfMaze >> version21: spec [ 
	<version: '2.1' imports: #('2.0-baseline')>
	
	spec for: #common do: [
		spec repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Maze/main'.
		spec blessing: #release.
		
		spec			
			package: 'Maze-Core' with: 'Maze-Core-FabrizioPerin.5';
			package: 'Maze-XMLObjects' with: 'Maze-XMLObjects-FabrizioPerin.1';
			
			"Tests"
			package: 'Maze-Tests-Core' with: 'Maze-Tests-Core-FabrizioPerin.3';
			package: 'Maze-Tests-Importer' with: 'Maze-Tests-Importer-FabrizioPerin.1';
			package: 'Maze-Tests-XMLObjects' with: 'Maze-Tests-XMLObjects-FabrizioPerin.3' ]
]

{ #category : #defaults }
ConfigurationOfMaze >> version30: spec [ 
	<version: '3.0' imports: #('3.0-baseline')>
	
	spec for: #common do: [
		spec repository: 'http://www.smalltalkhub.com/mc/FabrizioPerin/Maze/main'.
		spec blessing: #release.
		
		spec			
			package: 'Maze-Core' with: 'Maze-Core-FabrizioPerin.5';
			package: 'Maze-XMLObjects' with: 'Maze-XMLObjects-FabrizioPerin.1';
			
			"Tests"
			package: 'Maze-Tests-Core' with: 'Maze-Tests-Core-FabrizioPerin.3';
			package: 'Maze-Tests-Importer' with: 'Maze-Tests-Importer-FabrizioPerin.1';
			package: 'Maze-Tests-XMLObjects' with: 'Maze-Tests-XMLObjects-FabrizioPerin.3' ]
]
