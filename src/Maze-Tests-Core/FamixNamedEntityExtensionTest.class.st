Class {
	#name : #FamixNamedEntityExtensionTest,
	#superclass : #TestCase,
	#category : #'Maze-Tests-Core'
}

{ #category : #'as yet unclassified' }
FamixNamedEntityExtensionTest >> testAssign2MavenProjects [
	| famixClass mavenProject1 mavenProject2 |
	
	famixClass := FAMIXClass new.
	mavenProject1 := MAZEMavenProject new.
	mavenProject2 := MAZEMavenProject new.
	
	self assert: famixClass mavenProject isNil.
	
	famixClass mavenProject: mavenProject1.
	
	self assert: famixClass mavenProject isNil not.
	self assert: famixClass mavenProject equals: mavenProject1.
	self assert: mavenProject1 containedSourceCodeElements size equals: 1.
	self assert: mavenProject1 containedSourceCodeElements first equals: famixClass.
	self assert: mavenProject2 containedSourceCodeElements isEmpty.
		
	famixClass mavenProject: mavenProject2.
	
	self assert: famixClass mavenProject isNil not.
	self assert: famixClass mavenProject equals: mavenProject2.
	self assert: mavenProject1 containedSourceCodeElements isEmpty.
	self assert: mavenProject2 containedSourceCodeElements size equals: 1.
	self assert: mavenProject2 containedSourceCodeElements first equals: famixClass.
]

{ #category : #'as yet unclassified' }
FamixNamedEntityExtensionTest >> testAssignMavenProject [
	| famixClass mavenProject |
	
	famixClass := FAMIXClass new.
	mavenProject := MAZEMavenProject new.
	
	self assert: famixClass mavenProject isNil.
	self assert: (mavenProject containedSourceCodeElements isMemberOf: FMMultivalueLink).
	self assert: mavenProject containedSourceCodeElements isEmpty.
	
	famixClass mavenProject: mavenProject.
	
	self assert: famixClass mavenProject isNil not.
	self assert: famixClass mavenProject equals: mavenProject.
	self assert: mavenProject containedSourceCodeElements size equals: 1.
	self assert: mavenProject containedSourceCodeElements first equals: famixClass
]

{ #category : #'as yet unclassified' }
FamixNamedEntityExtensionTest >> testCreation [
	| famixClass |

	famixClass := FAMIXClass new.
	
	self assert: famixClass mavenProject isNil.
]
