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
MAZEMavenProjectTests >> testAddReferencingProject [
	| project dependency dependency2 |
	
	project := MAZEMavenProject new.
	dependency := MAZEMavenDependency new.
	
	self assert: (project referencingProjects isMemberOf: FMMultivalueLink).
	self assert: (project referencingProjects size = 0).
	
	project addReferencingProjects: dependency.
	self assert: (project referencingProjects isMemberOf: FMMultivalueLink).
	self assert: (project referencingProjects isEmpty not).
	self assert: project referencingProjects size = 1.
	self assert: ((project referencingProjects at: 1) == dependency).
	
	dependency2 := MAZEMavenDependency new.
	
	project addReferencingProjects: dependency2.
	self assert: (project referencingProjects isMemberOf: FMMultivalueLink).
	self assert: (project referencingProjects isEmpty not).
	self assert: (project referencingProjects size = 2).
	self assert: ((project referencingProjects at: 2) == dependency2).
]

{ #category : #'as yet unclassified' }
MAZEMavenProjectTests >> testAssignClassTo2MavenProjects [
	| famixClass mavenProject1 mavenProject2 |
	
	famixClass := FAMIXClass new.
	mavenProject1 := MAZEMavenProject new.
	mavenProject2 := MAZEMavenProject new.
	
	self assert: famixClass mavenProject isNil.
	self assert: (mavenProject1 containedSourceCodeElements isMemberOf: FMMultivalueLink).
	self assert: mavenProject1 containedSourceCodeElements isEmpty.
	self assert: (mavenProject2 containedSourceCodeElements isMemberOf: FMMultivalueLink).
	self assert: mavenProject2 containedSourceCodeElements isEmpty.
	
	mavenProject1 addContainedSourceCodeElement: famixClass.
	
	self assert: mavenProject1 containedSourceCodeElements size equals: 1.
	self assert: mavenProject1 containedSourceCodeElements first equals: famixClass.
	self assert: (mavenProject2 containedSourceCodeElements isMemberOf: FMMultivalueLink).
	self assert: mavenProject2 containedSourceCodeElements isEmpty.	
	self assert: famixClass mavenProject isNil not.
	self assert: famixClass mavenProject equals: mavenProject1.
	
	mavenProject2 addContainedSourceCodeElement: famixClass.	
	
	self assert: mavenProject1 containedSourceCodeElements isEmpty.
	self assert: mavenProject2 containedSourceCodeElements size equals: 1.
	self assert: mavenProject2 containedSourceCodeElements first equals: famixClass.
	self assert: famixClass mavenProject isNil not.
	self assert: famixClass mavenProject equals: mavenProject2.
	
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
	self assert: (project parentProject = nil).
	self assert: (project childProjects isMemberOf: FMMultivalueLink).
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
	self assert: project artifactID isNil.
	self assert: project version isNil.
	self assert: project packaging isNil.
	self assert: project modelVersion isNil.
	self assert: project parentProject isNil.
	self assert: (project childProjects isMemberOf: FMMultivalueLink).
	self assert: project modelVersion isNil.
	self assert: (project referencedProjects isMemberOf: FMMultivalueLink).
	self assert: (project referencedProjects size = 0).
	self assert: (project referencingProjects isMemberOf: FMMultivalueLink).
	self assert: (project referencingProjects size = 0).
]

{ #category : #'as yet unclassified' }
MAZEMavenProjectTests >> testSetChildProject [
	| project childProject |
	
	project := MAZEMavenProject new.
	childProject := MAZEMavenProject new.
	
	self assert: (project childProjects isMemberOf: FMMultivalueLink).
	self assert: childProject parentProject isNil.
	
	project childProjects: childProject.
	
	self assert: project childProjects size equals: 1.
	self assert: project childProjects first equals: childProject.
	self assert: childProject parentProject equals: project.
	
]

{ #category : #'as yet unclassified' }
MAZEMavenProjectTests >> testSetMultipleChildProjects [
	| project childProject1 childProject2 |
	
	project := MAZEMavenProject new.
	childProject1 := MAZEMavenProject new.
	childProject2 := MAZEMavenProject new.
	
	self assert: (project childProjects isMemberOf: FMMultivalueLink).
	self assert: childProject1 parentProject isNil.
	self assert: childProject2 parentProject isNil.
	
	project childProjects: childProject1.
	
	self assert: project childProjects size equals: 1.
	self assert: project childProjects first equals: childProject1.
	self assert: childProject1 parentProject equals: project.
	
	project childProjects: childProject2.
	
	self assert: project childProjects size equals: 2.
	self assert: project childProjects first equals: childProject1.
	self assert: childProject1 parentProject equals: project.
	self assert: project childProjects second equals: childProject2.
	self assert: childProject2 parentProject equals: project.
	
	
]

{ #category : #'as yet unclassified' }
MAZEMavenProjectTests >> testSetParentProject [
	| project parentProject |
	
	project := MAZEMavenProject new.
	parentProject := MAZEMavenProject new.
	
	self assert: project parentProject isNil.
	self assert: (parentProject childProjects isMemberOf: FMMultivalueLink).
	
	project parentProject: parentProject.
	
	self assert: project parentProject equals: parentProject.
	self assert: parentProject childProjects first equals: project.
	
]
