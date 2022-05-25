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
		couleur <- #blue;
		location <- any_location_in(environnement_exportation);
	}

}