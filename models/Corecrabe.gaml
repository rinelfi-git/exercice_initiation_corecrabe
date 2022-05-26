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
	int achat_de_crabe_pecheur_evolution;
	int nombre_de_crabe_male;
	int nombre_de_crabe_femelle;
	int nombre_de_pecheur;
	int nombre_de_mareyeur;
	int nombre_de_collecteur;
	int nombre_d_exportateur;

	init {
		create Crabe number: nombre_de_crabe_male with: (age: 365 * 8);
		create Femelle number: nombre_de_crabe_femelle with: (age: 365 * 8);
		create Pecheur number: nombre_de_pecheur;
		create Mareyeur number: nombre_de_mareyeur;
		create Collecteur number: 4;
		create Exportateur number: 1;
	}

	reflex nombre_de_population {
		nombre_de_crabe_male_evolution <- length(Crabe);
		nombre_de_crabe_femelle_evolution <- length(Femelle);
	}

	reflex circulation_argent {
		achat_de_crabe_pecheur_evolution <- 0;
		ask Pecheur {
			myself.achat_de_crabe_pecheur_evolution <- myself.achat_de_crabe_pecheur_evolution + self.argent_gagne;
		}

	}

	reflex arreter_simulation {
		if (length(agents of_generic_species Crabe) = 0) {
			do pause;
		}

	} }
/* Insert your model definition here */
experiment 'Modélisation Coracrabe' type: gui {
	parameter "Mâle" var: nombre_de_crabe_male <- 1000 min: 1000 max: 2000 category: "Crabe";
	parameter "Femelle" var: nombre_de_crabe_femelle <- 1000 min: 1000 max: 2000 category: "Crabe";
	parameter "Pecheur" var: nombre_de_pecheur <- 10 min: 1 max: 50 category: "Population";
	parameter "Mareyeur" var: nombre_de_mareyeur <- 10 min: 1 max: 50 category: "Population";
	output {
		display 'Simulation vente de crabe' type: java2D {
			grid Plan border: #black;
			species Crabe aspect: icone;
			species Femelle aspect: icone;
			species Pecheur aspect: icone;
			species Mareyeur aspect: icone;
			species Collecteur aspect: icone;
			species Exportateur aspect: icone;
		}

		display 'Graphique Crabe' type: java2D {
			chart 'Evolution de la population de crabe' type: series {
				data 'Crabe Mâle' value: nombre_de_crabe_male_evolution color: #yellow;
				data 'Crabe Femelle' value: nombre_de_crabe_femelle_evolution color: #red;
			}

		}

		display 'Graphique Argent' {
			chart 'Gain d\'argent par le pêcheur' type: series {
				data 'Pecheur' value: achat_de_crabe_pecheur_evolution color: #green;
			}

		}

	}

}