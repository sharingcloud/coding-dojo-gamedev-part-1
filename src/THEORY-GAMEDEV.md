# Théorie - Game development

<p style="text-align: center">
  <img src="./assets/joystick.png" width="250" height="250" />
</p>

## C'est quoi le game development (gamedev) ?

Je vais volontairement vulgariser les choses et aller vite sur le sujet, vu que c'est un sujet hyper vaste.

Le gamedev c'est (en gros) le domaine où l'on **conçoit des jeux vidéos de A à Z**.

Le gamedev est une branche du développement très complexe et passionante, considérée parmi les branches les plus difficiles du monde du développement. Quand on réalise un jeu, surtout avec un point de vue et des compétences de développeur, on a finalement besoin de pas mal de sujets à explorer.

Entre autres, il faut s'occuper:

- De la partie **gameplay**: mettre en place une bonne mécanique de jeu
- De la partie **scénario**: il faut bien une histoire ou alors un environnement cohérent
- De la partie **graphique**: des sprites, des tilemaps, des backgrounds, n'importe quelle ressource graphique
- De la partie **son**: effets sonores et musiques, interaction des sons avec le gameplay
- De la partie **réseau**: pour le multijoueur c'est quand même mieux (après il est possible de faire du split-screen à l'ancienne)
- De la partie **physique**: collisions et réactions plus ou moins réalistes
- De la partie **moteur/engine**: le(s) système(s) sous-jacent(s) qui s'occupe(nt) de tout coordonner
- Et encore d'autres parties spécialisées comme par exemple le **scripting** pour dynamiquement exécuter du code lors du level design

Vous aurez compris, pour chacune de ces parties, on peut nécessiter une ou plusieurs personnes à temps plein (notamment la partie **engine** qui est la plus technique).

Seulement, dans le monde d'aujourd'hui, il est entièrement possible de créer un jeu *en solo* (ou *en équipe réduite*), il faut juste de la **patience**, de l'**investissement**, de la **réflexion**, et surtout beaucoup de **pratique**.

Il y a une règle que j'ai lu quelque part qui dit en gros que *"tes dix premiers jeux vidéos seront plutôt mauvais, et après ça ira mieux"*.
Donc il faut pratiquer.

## Comment on fait un jeu en pratique ?

Il y a en gros **trois** manières de faire un jeu vidéo.

### Sans rien

La première, c'est de **partir de zéro** en mode *warrior*, avec son langage préféré et son couteau. D'ailleurs le langage préféré est un peu biaisé ici, dans le monde du gamedev on utilise surtout C++.  

Autant vous dire que c'est la manière la plus difficile, qu'il y a juste énormément de choses à gérer pour faire tourner son jeu ne serait-ce que sur une seule plateforme, et que comme il faut tout faire à la main ça demande énormément de temps puisque tout va devoir se faire en code, sauf si vous prenez en plus le temps de faire des éditeurs.  
On ne va donc pas faire ça aujourd'hui, même si d'un point de vue éducationnel, ça peut être hyper enrichissant de faire son propre jeu (ou son propre framework, voire son propre moteur de jeu) depuis zéro (ou depuis un petit framework).  

Dans le monde professionnel, et surtout à l'époque, la plupart des jeux sont crées de cette manière là, avec un contrôle total où l'équipe chargée du développement du jeu s'occupe aussi de la réalisation de tout ce qu'il y a sous le jeu.

### Avec un game framework

La deuxième technique, c'est d'utiliser un **framework**. Tout comme dans le monde du développement web qu'on connaît désormais assez bien, il existe des **frameworks** qui exposent déjà la plupart des fonctionnalités complexes, il faut juste se servir et composer son jeu via les primitives. Voici des exemples connus de frameworks:

- Frameworks plutôt minimalistes:
  - [SDL (C)](https://www.libsdl.org/): Bonne base pour construire autour, gère la partie cross-platform et gestion de la fenêtre et des évènements. Plusieurs bindings dans d'autres langages.
  - [SFML (C++)](https://www.sfml-dev.org/): Equivalent plus haut niveau de la SDL, plus de fonctionnalités. Plusieurs bindings dans d'autres langages.
  
- Frameworks plus complets:
  - [LibGDX (JVM)](https://libgdx.badlogicgames.com/): Framework complet plutôt simple à utiliser.
  - [Phaser (JS)](https://phaser.io/): Contient une super documentation avec pas mal d'exemples, et tourne sur le navigateur.
  - [XNA/MonoGame (C#)](http://www.monogame.net/): Le bon vieux projet XNA réalisé par Microsoft pour faire des jeux cross-platform Windows/Xbox 360 a l'époque. Beaucoup de jeux indépendants connus ont été réalisés via XNA, dont *Super Meat Boy*, *Bastion*, *Fez* et bien d'autres.
    - XNA ayant été "tué" par Microsoft, le projet MonoGame à pris le relais, se basant sur le projet Mono pour apporter la cross-compatibilité sur la plupart des plateformes.

Mention spéciale pour le langage Haxe et les projets par dessus (comme [HaxeFlixel](http://haxeflixel.com/)), qui possède un concept super cool que je vous invite à regarder sur leur [site officiel](https://haxe.org/). Pour le teasing, *Dead Cells* a été réalisé en Haxe.

### Avec un game engine

Finalement, la troisième technique, c'est le **moteur de jeu (game engine)**, qui expose un maximum de fonctionnalités à travers une interface pour faire son jeu d'une façon beaucoup plus interactive. Dans le domaine du game engine, il y a en gros deux types: les moteurs spécialisés, et les moteurs plutôt génériques.

- Moteurs de jeu spécialisés:
  - [M.U.G.E.N](https://fr.wikipedia.org/wiki/MUGEN_(moteur_de_jeu)): Ce "moteur" sert à réaliser votre propre jeu de combat à la *Street Fighter*. Super fun à utiliser.
  - [RPG Maker](http://www.rpgmakerweb.com/): Celui-ci sert à réaliser son propre RPG, du classique *Final Fantasy* à *Zelda* en passant par *Pokémon* (si on plie bien le système).
  - [Adventure Game Studio](http://www.rpgmakerweb.com/): Pour faire ses propres jeux en point-and-click.
  
- Moteurs de jeu génériques:
  - [Game Maker](https://www.yoyogames.com/gamemaker): Un soft payant plutôt facile à prendre en main pour réaliser n'importe quel type de jeu (surtout dédié aux jeux 2D). Je conseille aussi [Construct](https://www.scirra.com/) dans le même genre.
  - [Godot Engine](https://godotengine.org/): Un super moteur open-source 2D et 3D pour réaliser n'importe quel type de jeu que je vais vous présenter aujourd'hui.
  - [Unity3D](https://unity.com/fr): Sûrement le moteur de jeu le plus connu aujourd'hui. Blindé de features, énormément de jeux réalisés avec, payant pour la version Pro (si on veut un thème sombre par exemple).
  - [CryEngine](https://www.cryengine.com/): Le moteur de jeu open-source made in Crytek, les créateurs de *Crysis*. Assez lourd et nécessite un PC plutôt performant.
  - [Unreal Engine](https://www.unrealengine.com/en-US/): Le monstrueux moteur de jeu open-source made in Epic Games, entre autres créateurs d'*Unreal Tournament*. Cette chose est massive, blindée de choses utiles, bouffe pas mal d'espace disque, de RAM, de CPU et de GPU. Fait souffrir les PCs portables non-adaptés pour le jeu. 
