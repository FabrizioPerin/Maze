Extension { #name : #MooseAbstractGroup }

{ #category : #'*maze-core' }
MooseAbstractGroup >> allMavenProjects [
	<navigation: 'All Maven Projects'>
	^ self allWithType: MAZEMavenProject ofGroupClass: MAZEMavenProjectGroup 
]

{ #category : #'*maze-core' }
MooseAbstractGroup >> allPomFiles [
	<navigation: 'All pom files'>
	^ self allWithSubTypesOf: MAZEMavenPOMFile
]
