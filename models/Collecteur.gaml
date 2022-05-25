/**
* Name: Collecteur
* Based on the internal empty template. 
* Author: Rinelfi
* Tags: 
*/


model Collecteur
import './AgentCommercial.gaml'
/* Insert your model definition here */

species Collecteur parent: AgentCommercial {

	init {
		location <- any_location_in(environnement_marche);
	}

}