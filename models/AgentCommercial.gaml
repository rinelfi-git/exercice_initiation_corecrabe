/**
* Name: AgentCommercial
* Based on the internal empty template. 
* Author: Rinelfi
* Tags: 
*/


model AgentCommercial
import './Personne.gaml'
/* Insert your model definition here */

species AgentCommercial parent: Personne {
	int quota;
	int nombre_de_crabe;

	init {
		couleur <- #yellow;
		location <- any_location_in(environnement_marche);
	}

}