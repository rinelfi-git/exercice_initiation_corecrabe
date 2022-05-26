/**
* Name: Collecteur
* Based on the internal empty template. 
* Author: Rinelfi
* Tags: 
*/


model Collecteur
import './Exportateur.gaml'
/* Insert your model definition here */

species Collecteur parent: AgentCommercial {

	init {
		quota <- 400;
		couleur <- #yellow;
		location <- any_location_in(environnement_marche);
	}
	
	reflex rechercher_crabe when: nombre_de_crabe < quota {
		location <- any_location_in(environnement_marche);
	}
	
	reflex vendre_crabe when: nombre_de_crabe = quota {
		location <- any_location_in(environnement_exportation);
		Exportateur expotrateur <- Exportateur where(each.nombre_de_crabe < each.quota and each overlaps environnement_exportation) closest_to(self);
	}

	aspect icone{
		draw circle(1) color: couleur border: #black;
	}
}