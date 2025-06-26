# Logique de GameLogic.swift

La logique de `GameLogic.swift` est basée sur les principes du "Jeu de la vie" de John Conway. Voici comment le fichier est structuré et comment il fonctionne :

### 1. Classe Principale : `GameLogic`
- C'est un `ObservableObject`, ce qui signifie que l'interface utilisateur (dans `ContentView.swift`) peut observer ses changements et se mettre à jour automatiquement.
- La propriété `@Published var grid: [[Bool]]` est la grille du jeu. Le mot-clé `@Published` est ce qui permet à l'interface de réagir chaque fois que la grille est modifiée.

### 2. Initialisation (`init`)
- Quand un objet `GameLogic` est créé, il initialise une grille vide (remplie de `false`) avec les dimensions `rows` et `cols`.
- Il appelle immédiatement la fonction `reset()` pour définir l'état de départ de la grille.

### 3. La Boucle de Jeu (`start`, `stop`, `timer`)
- La fonction `start()` crée un `Timer`. C'est une horloge qui se déclenche à intervalle régulier (ici, toutes les 0.2 secondes).
- À chaque déclenchement, le `Timer` exécute la fonction `nextGeneration()`. C'est ce qui fait avancer la simulation étape par étape.
- La fonction `stop()` arrête le `Timer`, gelant ainsi la simulation.

### 4. Configuration de la Grille (`reset`)
- Cette fonction définit l'état initial de la simulation.
- D'abord, elle "nettoie" la grille en mettant toutes les cellules à `false` (mortes).
- Ensuite, elle place manuellement les cellules vivantes (`true`) pour créer les motifs de départ (dans notre cas, les trois "gliders").

### 5. Le Cœur de la Logique : `nextGeneration()`
- C'est ici que les règles du Jeu de la vie sont appliquées.
- Elle crée une copie temporaire de la grille (`newGrid`). C'est essentiel pour que les calculs de la nouvelle génération se basent tous sur l'état *actuel* de la grille, sans être influencés par les changements en cours.
- Elle parcourt chaque cellule de la grille (`for row in ... for col in ...`).
- Pour chaque cellule, elle :
    a. Compte ses voisins vivants avec la fonction `countNeighbors()`.
    b. Applique les règles du Jeu de la vie :
        - **Survie :** Une cellule vivante avec 2 ou 3 voisins vivants reste en vie.
        - **Mort :** Une cellule vivante avec moins de 2 voisins (solitude) ou plus de 3 voisins (surpopulation) meurt.
        - **Naissance :** Une cellule morte avec exactement 3 voisins vivants devient vivante.
    c. Met à jour la cellule correspondante dans `newGrid`.
- Une fois toutes les cellules calculées, la grille principale (`grid`) est remplacée par la `newGrid`. Comme `grid` est `@Published`, l'interface se met à jour pour afficher la nouvelle génération.

### 6. Comptage des Voisins (`countNeighbors`)
- Cette fonction regarde les 8 cellules qui entourent une cellule donnée.
- Elle utilise l'opérateur modulo (`%`) pour gérer les bords de la grille. Cela signifie que la grille "s'enroule" sur elle-même (un "tore") : si un planeur sort par la droite, il réapparaît par la gauche.

---
*En résumé, `GameLogic.swift` gère l'état de la simulation, la fait avancer à un rythme régulier via un `Timer`, et applique les règles fondamentales du Jeu de la vie pour calculer chaque nouvelle génération.*
