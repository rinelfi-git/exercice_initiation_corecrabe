/**
* Name: Corecrabe
* Based on the internal empty template. 
* Author: Rinelfi
* Tags: 
*/
model Corecrabe

import './Plan.gaml'
import './Crabe.gaml'
import './Pecheur.gaml'
import './Mareyeur.gaml'
import './Collecteur.gaml'
import './Exportateur.gaml'

global {
	int nombre_de_crabe_male_evolution;
	int nombre_de_crabe_femelle_evolution;
	int nombre_de_crabe_male;
	int nombre_de_crabe_femelle;
	int nombre_de_pecheur;
	int nombre_de_mareyeur;
	int nombre_de_collecteur;
	int nombre_d_exportateur;

	init {
		create Crabe number: nombre_de_crabe_male with: (age: rnd(365 * 8));
		create Femelle number: nombre_de_crabe_femelle with: (age: rnd(365 * 8));
		create Pecheur number: nombre_de_pecheur;
		create Mareyeur number: nombre_de_mareyeur;
	}

	reflex nombre_de_population {
		nombre_de_crabe_male_evolution <- 0;
		nombre_de_crabe_femelle_evolution <- 0;
		ask Crabe {
			nombre_de_crabe_male_evolution <- nombre_de_crabe_male_evolution + 1;
		}

		ask Femelle {
			nombre_de_crabe_femelle_evolution <- nombre_de_crabe_femelle_evolution + 1;
		}

	}

	reflex arreter_simulation {
		if (length(agents of_generic_species Crabe) = 0) {
			do pause;
		}

	} }
/* Insert your model definition here */
experiment 'Modélisation Coracrabe' type: gui {
	parameter "Mâle" var: nombre_de_crabe_male <- 30 min: 30 max: 100 category: "Crabe";
	parameter "Femelle" var: nombre_de_crabe_femelle <- 30 min: 30 max: 100 category: "Crabe";
	parameter "Pecheur" var: nombre_de_pecheur <- 10 min: 1 max: 50 category: "Population";
	parameter "Mareyeur" var: nombre_de_mareyeur <- 10 min: 1 max: 50 category: "Population";
	parameter "Collecteur" var: nombre_de_collecteur <- 5 min: 1 max: 50 category: "Population";
	parameter "Exportateur" var: nombre_d_exportateur <- 5 min: 1 max: 50 category: "Population";
	output {
		display 'Simulation Corecrabe' type: java2D {
			grid Plan lines: #black;
			species Personne;
			species Crabe;
			species Femelle;
			species Pecheur;
			species Mareyeur;
			species Collecteur;
			species Exportateur;
		}

		display 'Graphique Crabe' type: java2D {
			chart 'chart' type: histogram {
				data 'Crabe Mâle' value: nombre_de_crabe_male_evolution color: #yellow;
				data 'Crabe Femelle' value: nombre_de_crabe_femelle_evolution color: #red;
			}

		}

	}

}