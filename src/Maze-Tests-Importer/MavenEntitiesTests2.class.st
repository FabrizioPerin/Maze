Class {
	#name : #MavenEntitiesTests2,
	#superclass : #TestCase,
	#category : #'Maze-Tests-Importer'
}

{ #category : #'as yet unclassified' }
MavenEntitiesTests2 >> basicPOM [
	^'<project xmlns="http://maven.apache.org/POM/4.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                      http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>org.codehaus.mojo</groupId>
  <artifactId>my-project</artifactId>
  <version>1.0</version>
</project>'
]

{ #category : #'as yet unclassified' }
MavenEntitiesTests2 >> basicPOMWithDependecies [

	^'<project xmlns="http://maven.apache.org/POM/4.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                      http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.0</version>
      <type>jar</type>
      <scope>test</scope>
      <optional>true</optional>
    </dependency>
  </dependencies>

  <groupId>org.codehaus.mojo</groupId>
  <artifactId>my-project</artifactId>
  <version>1.0</version>
</project>'
]

{ #category : #'as yet unclassified' }
MavenEntitiesTests2 >> basicPOMWithInheritance [

	^'<project xmlns="http://maven.apache.org/POM/4.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                      http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <parent>
    <groupId>org.codehaus.mojo</groupId>
    <artifactId>my-parent</artifactId>
    <version>2.0</version>
    <relativePath>../my-parent</relativePath>
  </parent>

  <artifactId>my-project</artifactId>
</project>'
]

{ #category : #'as yet unclassified' }
MavenEntitiesTests2 >> testMazeMavProjectCreation [
	| xmlDocument project |
	
	xmlDocument := XMLDOMParser parse: self basicPOM.
	
	project := xmlDocument findElementNamed: 'project'.
	
	self assert: (project isNil not).
	self assert: (xmlDocument root = project).
	
	
	self assert: (project isNil not).
]

{ #category : #'as yet unclassified' }
MavenEntitiesTests2 >> testProjectCreation [
	| xmlDocument project xmlDOMParser |
	
	xmlDOMParser := XMLDOMParser on: self basicPOM.
	
	xmlDocument := xmlDOMParser parseDocument.
	
	project := xmlDocument findElementNamed: 'project'.
	
	self assert: (project isNil not).
	self assert: (xmlDocument root = project).
	
	
	
]

{ #category : #'as yet unclassified' }
MavenEntitiesTests2 >> testProjectCreationWithParent [
	| xmlDocument project xmlDOMParser |
	
	xmlDOMParser := XMLDOMParser on: self basicPOMWithInheritance.
	
	xmlDocument := xmlDOMParser parseDocument.
	
	project := xmlDocument findElementNamed: 'project'.
	
	self assert: (project isNil not).
	self assert: (xmlDocument root = project).
	

	
	
	
]
