Extension { #name : #MooseModel }

{ #category : #'*maze-core' }
MooseModel >> importMazePomModel [
	<menuItem: 'Import poms in folder structure' category: 'JEAs Importers'>

	| aFolder |
	aFolder := UITheme builder chooseDirectory: 'Choose poms root folder'.
	aFolder isNil
		ifTrue: [DialogWindow new alert: 'Folder not found.']
		ifFalse: [ MAZEMavenPOMImporter with: self on: aFolder pathString ]

]
