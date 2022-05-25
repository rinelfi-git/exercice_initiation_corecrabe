/**
* Name: Crabe
* Based on the internal empty template. 
* Author: Rinelfi
* Tags: 
*/
model Crabe
import './Plan.gaml'
/* Insert your model definition here */
species Crabe {
	int age;
	int taille;
	string sexe;
	rgb couleur;
	agent environnement_crabe;

	init {
		environnement_crabe <- Plan[0, 0];
		sexe <- 'male';
		couleur <- rgb(255, 255, 255);
		location <- any_location_in(environnement_crabe);
	}
	
	reflex deplacer {
		location <- any_location_in(environnement_crabe);
	}

	reflex grandir {
		if (age > 365 * 20) {
			do die;
		} else {
			age <- age + 1;
		}
	}

	aspect {
		draw square(1) color: couleur border: #black;
	}

}

species Femelle parent: Crabe {
	bool ovee;
	float probabilite_de_ponte <- 0.1;
	float probailite_de_production <- 0.6;

	init {
		sexe <- 'femelle';
		ovee <- false;
	}

	action pondre {
		create Crabe number: rnd(10);
		create Femelle number: rnd(10);
	}
	
	reflex fecondable when: flip(probailite_de_production) and age >= 8 {
		ovee <- true;
	}

	reflex periode_de_ponte when: flip(probabilite_de_ponte) and ovee {
		do pondre;
		do die;
	}

	/*
	action recherche_crabe_male {
		ask Crabe where(each.sexe = 'male' and (location distance_to each.location) <= 20){
			self.couleur <- rgb(160, 160, 160);
		}
	}
	*/
	aspect {
		draw square(1) color: #pink border: #black;
	}

}