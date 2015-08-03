Class {
	#name : #MAZEMavenProjectGroup,
	#superclass : #MEEAbstractGroup,
	#category : #'Maze-Core'
}

{ #category : #'as yet unclassified' }
MAZEMavenProjectGroup >> findProjectByGroupID: aGroupID artifactID: anArtifactID [
	^ self
		detect: [ :project | project groupID = aGroupID and: [ project artifactID = anArtifactID ] ]
		ifNone: [ nil ]
]

{ #category : #'as yet unclassified' }
MAZEMavenProjectGroup >> findProjectByGroupID: aGroupID artifactID: anArtifactID version: aVersion [

	(self findProjectByGroupID: aGroupID artifactID: anArtifactID)
		ifNotNil: [ :prj |
			prj version = aVersion
				ifTrue: [ ^ prj ] ].
			
	^ nil
]
