Class {
	#name : #MAMAVParentGroupIdTests,
	#superclass : #TestCase,
	#category : #'Maze-Tests-OPAX'
}

{ #category : #'as yet unclassified' }
MAMAVParentGroupIdTests >> testCreation [
	self assert: ((OPGenericElement newElementWithTag: 'groupId') isMemberOf: MAMAVGroupId).
	self assert: ((OPGenericElement newElementWithTag: 'groupId') isMemberOf: MAMAVParentGroupId).
	
]
