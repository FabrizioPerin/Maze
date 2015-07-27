Class {
	#name : #MAZEMavenProjectTests,
	#superclass : #TestCase,
	#category : #'Maze-Tests-Core'
}

{ #category : #'as yet unclassified' }
MAZEMavenProjectTests >> testAddReferencedProject [
	| project dependency dependency2 |
	
	project := MAZEMavenProject new.
	dependency := MAZEMavenDependency new.
	
	self assert: (project referencedProjects isMemberOf: FMMultivalueLink).
	self assert: (project referencedProjects size = 0).
	
	project addReferencedProjects: dependency.
	self assert: (project referencedProjects isMemberOf: FMMultivalueLink).
	self assert: (project referencedProjects isEmpty not).
	self assert: project referencedProjects size = 1.
	self assert: ((project referencedProjects at: 1) == dependency).
	
	dependency2 := MAZEMavenDependency new.
	
	project addReferencedProjects: dependency2.
	self assert: (project referencedProjects isMemberOf: FMMultivalueLink).
	self assert: (project referencedProjects isEmpty not).
	self assert: (project referencedProjects size = 2).
	self assert: ((project referencedProjects at: 2) == dependency2).
]

{ #category : #'as yet unclassified' }
MAZEMavenProjectTests >> testCreation [
	| project |
	
	project := MAZEMavenProject new.
	project 
		groupID: 'org.codehaus.mojo';
		artifactID: 'my-project';
		version: '1.0';
		modelVersion: '4.0.0'.
	
	self assert: (project isMemberOf: MAZEMavenProject).
	self assert: (project groupID = 'org.codehaus.mojo').
	self assert: (project artifactID = 'my-project').
	self assert: (project version = '1.0').
	self assert: (project modelVersion = '4.0.0').
	self assert: (project fullyQualifiedArtifactName = 'org.codehaus.mojo.my-project:1.0').
	self assert: (project referencedProjects isMemberOf: FMMultivalueLink).
	self assert: (project referencedProjects size = 0).
	self assert: (project referencingProjects isMemberOf: FMMultivalueLink).
	self assert: (project referencingProjects size = 0).
]

{ #category : #'as yet unclassified' }
MAZEMavenProjectTests >> testCreationSimple [
	| project |
	
	project := MAZEMavenProject new.
		
	self assert: (project isMemberOf: MAZEMavenProject).
	self assert: project groupID isNil.
	self assert: project groupID isNil.
	self assert: project groupID isNil.
	self assert: project groupID isNil.
	self assert: project groupID isNil.
	self assert: (project referencedProjects isMemberOf: FMMultivalueLink).
	self assert: (project referencedProjects size = 0).
	self assert: (project referencingProjects isMemberOf: FMMultivalueLink).
	self assert: (project referencingProjects size = 0).
]
