/**
* Name: Corecrabe
* Based on the internal empty template. 
* Author: Rinelfi
* Tags: 
*/

model Corecrabe

import './Plan.gaml'
import './Crabe.gaml'
import './Personne.gaml'

global {
	int nombre_de_crabe_male;
	int nombre_de_crabe_femelle;
	int nombre_de_pecheur;
	
	init {
		create Crabe number: nombre_de_crabe_male with:(age: rnd(365 * 8));
		create Femelle number: nombre_de_crabe_femelle with:(age: rnd(365 * 8));
		create Pecheur number: nombre_de_pecheur;
	}
}
/* Insert your model definition here */

experiment personmodel type: gui {
	parameter "Mâle" var:nombre_de_crabe_male <- 10 min:10 max:30 category:"Crabe";
	parameter "Femelle" var:nombre_de_crabe_femelle <- 2 min:2 max:20 category:"Crabe";
	parameter "Pecheur" var:nombre_de_pecheur <- 1 min:1 max:50 category:"Population";
	
	output {
		display 'Simulation Corecrabe' type:java2D{
			grid Plan lines:#black;
			species Crabe;
			species Femelle;
			species Pecheur;
		}
	}
}