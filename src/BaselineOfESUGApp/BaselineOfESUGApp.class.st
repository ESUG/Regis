"
This baseline is used to load a ESUGApp from repository. 

Depends on:
- Seaside3
- MaterialDesignLite (with Magritte)
- Parasol
- NeoJSON
- NeoCSV
- Artefact

Load type: 
- atomic
"
Class {
	#name : 'BaselineOfESUGApp',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfESUGApp',
	#package : 'BaselineOfESUGApp'
}

{ #category : 'baselines' }
BaselineOfESUGApp >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			self setUpDependencies: spec.
			spec
				package: 'ESUGApp-PostMark-Core' with: [ spec requires: #('NeoJSON') ];
				package: 'ESUGApp-Model' with: [ spec requires: #('DatabaseEsug' 'Artefact') ];
				package: 'ESUGApp-Controller' with: [ spec requires: #('NeoCSV') ];
				package: 'ESUGApp-Core' with: [ spec requires: #('ESUGApp-View') ];		
				package: 'ESUGApp-Library' with: [ spec requires: #('MaterialDesignLite' 'Seaside3' 'ESUGApp-Model') ];
				package: 'ESUGApp-Form' with: [ spec requires: #('ESUGApp-View') ];
				package: 'ESUGApp-Component' with: [ spec requires: #('MaterialDesignLite' 'ESUGApp-Controller') ];
				package: 'ESUGApp-View' with: [ spec requires: #('ESUGApp-Library' 'ESUGApp-Component' 'PSTableSeaside') ];
				package: 'ESUGApp-Tests' with: [ spec requires: #('Parasol' 'ESUGApp-Core') ];
				package: 'ESUGApp-Extensions' with: [ spec requires: #('ESUGApp-Core') ].
			spec 
				group: 'Core' with: #('ESUGApp-PostMark-Core' 'ESUGApp-Form' 'ESUGApp-Extensions' 'ESUGApp-Core');
				group: 'Tests' with: #('Core' 'ESUGApp-Tests') ]
]

{ #category : 'accessing' }
BaselineOfESUGApp >> project [
	
	| aProject |
	
	aProject := super project.
	aProject loadType: #atomic.
	^ aProject.
]

{ #category : 'baselines' }
BaselineOfESUGApp >> setUpDependencies: spec [

	spec baseline: 'Seaside3' with: [ spec repository: 'github://SeasideSt/Seaside:v3.4.x/repository' ].

	spec baseline: 'MaterialDesignLite' with: [ 
		spec
			loads: 'all';
			repository: 'github://ESUG/MaterialDesignLite:Pharo14/src' ].

	spec baseline: 'DatabaseEsug' with: [ spec repository: 'github://ESUG/DatabaseEsug:master/src' ].
	"loaded in P10. Not a single test! Unbelievable"

	spec baseline: 'Parasol' with: [ 
		spec
			loads: 'default';
			repository: 'github://ESUG/Parasol:Pharo14/repository' ].
	"use default not to load Seaside again"

	spec baseline: 'PSTableSeaside' with: [ spec repository: 'github://ESUG/PSTableSeaside:master/src' ].

	spec baseline: 'NeoJSON' with: [ spec repository: 'github://svenvc/NeoJSON/repository' ].

	spec baseline: 'NeoCSV' with: [ spec repository: 'github://svenvc/NeoCSV/repository' ].

	spec baseline: 'Artefact' with: [ 
		spec
			loads: #( 'core' );
			repository: 'github://pharo-contributions/Artefact:v1.x.x/src' ]
]
