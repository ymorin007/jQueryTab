<!--- 

Author : YaNnIcK MoRiN
Find me at : Google+, Github or at the beach.

 --->

<cfcomponent output="false" mixin="controller">

	<cffunction name="init">
		<cfset this.version = "1.1.4">
		<cfreturn this>
	</cffunction>

	<cffunction name="createjQueryTab">
		<cfargument name="name" hint="Name of tab name or list of tab names" type="string" required="true" >
		<cfargument name="partial" hint="The name of the partial file or list of partial file names related to the name of the tab" type="string" required="true">
		<cfargument name="openMouserOver" type="boolean" hint="Open tab on mouse over" default="false" required="false">
		<cfargument name="belowContent" type="boolean" hint="Show tabs below content" default="false" required="false">
		<cfargument name="loadjQuery" type="boolean" hint="Load jQuery,UI and CSS from Google CDN" default="true" required="false">	
		<cfargument name="jQueryUIcss" type="string" hint="The jQuery UI Theme. You can select one of the theme available at : http://www.devcurry.com/2010/05/latest-jquery-and-jquery-ui-theme-links.html (make sur to use the name under the theme)" default="base">
			
		<cfsavecontent variable="script">
	
		<cfif arguments.loadjQuery EQ True>
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/jquery-ui.min.js"></script>
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/themes/<cfoutput>#arguments.jQueryUIcss#</cfoutput>/jquery-ui.css"></script>
		</cfif>
		
		<script>
		$(function() {
			$( "#tabs" ).tabs(<cfif arguments.openMouserOver EQ True>{event: "mouseover"}</cfif>);
			<cfif arguments.belowContent EQ True>
			$( ".tabs-bottom .ui-tabs-nav, .tabs-bottom .ui-tabs-nav > *" )
			.removeClass( "ui-corner-all ui-corner-top" )
			.addClass( "ui-corner-bottom" );		
			</cfif>
		});
		</script>
	
		<cfif arguments.belowContent EQ True>
		<style>
		#tabs { height: 200px; } 
		.tabs-bottom { position: relative; } 
		.tabs-bottom .ui-tabs-panel { height: 140px; overflow: auto; } 
		.tabs-bottom .ui-tabs-nav { position: absolute !important; left: 0; bottom: 0; right:0; padding: 0 0.2em 0.2em 0; } 
		.tabs-bottom .ui-tabs-nav li { margin-top: -2px !important; margin-bottom: 1px !important; border-top: none; border-bottom-width: 1px; }
		.ui-tabs-selected { margin-top: -3px !important; }
		</style>
		</cfif>
		
		</cfsavecontent>
		
		<cfhtmlhead text="#script#">
	
		<cfoutput>
		
		<div id="tabs" <cfif arguments.belowContent EQ True>class="tabs-bottom"</cfif>>
			<ul>
				<cfset counterName = 0>
				
				<cfloop list="#arguments.name#" index="i">
					<cfset counterName = counterName + 1>
					<li><a href="##tabs-#counterName#">#i#</a></li>
				</cfloop>
			</ul>
			
			<cfset counterPartial = 0>
			
			<cfloop list="#arguments.partial#" index="i">
				<cfset counterPartial = counterPartial + 1>
				<div id="tabs-#counterPartial#">
					<p>#includePartial(partial="#i#")#</p>
				</div>
			</cfloop>
			
		</div>
	
	</cfoutput>
	</cffunction>

</cfcomponent>		