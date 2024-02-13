# Brief Description

En tant que développeur iOS, développer une application mobile qui utilise des compétences que vous n'avez pas pu travailler dans votre précédent poste.

Vous avez bientôt un entretien dans une entreprise qui travaille sur UIKit. Rien de mieux qu'une démonstration d'application pour marquer des points lors de l'entretien.

Mais en ce moment, vous avez tendance à vous éparpiller dans tous les sens dans votre vie professionnelle comme personnelle.
Ce dont vous avez besoin, c'est un peu plus d'organisation ! Alors pourquoi ne pas essayer une liste de tâches ?

Ce petit projet serait parfait pour montrer vos compétences et améliorer votre organisation.
Et quand je parle d'organisation, je parle aussi de code !
Car pour rappel, UIKit utilise le pattern d'architecture MVP et c'est clairement demandé dans la fiche de poste.

L'application sera composée de 3 écrans :

- Une liste des tâches
- Le détail d'une tâche
- L'ajout d'une nouvelle tâche.

Depuis l'application, vous devrez pouvoir:
- **Consulter** la liste des tâches,
- les **modifier**,
- les **supprimer**,
- **ajouter** de nouvelles.

Vous trouverez le lien vers la table airtable qui a déjà des entrées.
Vous devrez dupliquer la table dans votre workspace afin d'avoir tous les droits dessus.
Ensuite, vous irez créer votre token d'accès depuis : [create token](https://airtable.com/create/tokens).
C'est lui qui va vous permettre de vous authentifier lors de vos requêtes API.
Il vous suffira de choisir les droits d'accès pour votre scope (data.records.:write) et votre base.
Vous pourrez renseigner ce token en tant que Bearer token dans le header de votre requête.
Pour avoir la documentation de l'API, il vous faut aller en haut à droite, dans [Aide → Documentation de l'API](https://airtable.com/app7qbcqyeaM5CiIL/api/docs).
