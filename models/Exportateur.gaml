/**
* Name: Exportateur
* Based on the internal empty template. 
* Author: Rinelfi
* Tags: 
*/
model Exportateur

import './AgentCommercial.gaml'
/* Insert your model definition here */
species Exportateur parent: AgentCommercial {

	init {
		quota <- 1000;
		couleur <- #blue;
		location <- any_location_in(environnement_exportation);
	}
	
	reflex chercher_crabe when: nombre_de_crabe < quota {
		
	}

	aspect icone {
		draw circle(1) color: couleur border: #black;
	}

}