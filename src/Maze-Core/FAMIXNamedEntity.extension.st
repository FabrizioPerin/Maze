Extension { #name : #FAMIXNamedEntity }

{ #category : #'*maze-core' }
FAMIXNamedEntity >> mavenProject [
	
	^ self privateState attributeAt: #mavenProject ifAbsent: [ nil ]
]

{ #category : #'*maze-core' }
FAMIXNamedEntity >> mavenProject: aMazeMavenProject [
	
	^ self privateState
		attributeAt: #mavenProject
		put: [ 
			FMMultivalueLink
				on: self
				update: #containedSourceCodeElements
				from: self mavenProject
				to: aMazeMavenProject.
				 ] value
]
