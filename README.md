<div align="center">

# FrenchUtility

**Un bot Discord tout-en-un, en français : économie, niveaux, jeux, casino, modération.**

Python 3 · discord.py 2 · zéro dépendance externe

[![version](https://img.shields.io/badge/v2.0-000000?style=flat-square)](https://github.com/L3Lunee/FrenchUtility)
[![python](https://img.shields.io/badge/Python%203.10%2B-000000?style=flat-square)](#installation)
[![license](https://img.shields.io/badge/MIT-000000?style=flat-square)](LICENSE)

</div>

## Ce que c'est

Un bot de communauté complet pour un serveur francophone : une économie par
serveur avec banque, box et objets, un système de niveaux alimenté par les
messages **et** le vocal, des jeux entre membres, un casino, et tout l'outillage
de modération — sanctions, automod, tickets, anti-raid, journal.

**91 commandes**, organisées en groupes pour tenir sous la limite de 100 de
Discord. Chaque serveur a ses propres soldes, niveaux et réglages : rien n'est
mélangé entre deux serveurs.

## Économie

Gagner de l'argent passe par la présence : **1 coin et 5 XP par message**
(maximum une fois par minute), autant par minute de vocal. Le vocal ne compte
que si tu n'es pas en sourdine, pas dans le salon AFK, et qu'il y a **au moins
deux personnes** dans le salon — sinon il suffirait de dormir connecté.

`/daily` monte jusqu'à **×3** si tu reviens tous les jours, `/travailler`
propose sept métiers débloqués par niveau, et l'argent laissé en banque
rapporte **0,5 % par jour**.

Pour le dépenser : les box, le casino, la boutique de rôles, les enchères.

### Les box sont un pari

Le contenu d'une box suit une table de paliers, pas un tirage uniforme :

| Palier | Chance | Tu récupères |
| --- | --- | --- |
| 💥 Flop | 50 % | 25–70 % du prix |
| 😐 Correct | 32 % | 85–125 % |
| 😃 Bonne pioche | 15 % | 140–220 % |
| 🎰 **JACKPOT** | 3 % | **350–600 %** |

Tu perds de l'argent **62 % du temps**, pour une espérance de −1,4 %. Un objet
tombe dans 20 % des box communes, 45 % des rares, 100 % des légendaires, et se
revend avec `/vendre`. Tout est réglable dans `config.json`.

`/rob` réussit une fois sur deux et coûte une amende de 15 % en cas d'échec.

## Casino

`/casino slots` — trois rouleaux, jusqu'à **×75** sur trois 7️⃣.
`/casino blackjack` — boutons Tirer/Rester, blackjack naturel payé ×2,5.
`/casino roulette` — rouge/noir/pair/impair en ×2, un numéro plein en ×36.

Retour joueur mesuré sur 100 000 parties : **93,9 %**. C'est un puits à argent
assumé, pas une source de revenus.

## Modération

Sanctions manuelles classiques (`/warn`, `/timeout`, `/moderer`, `/clear`…) et
un **automod** configurable : anti-spam, anti-liens, anti-invitations,
anti-MAJUSCULES, filtre de mots, anti-mentions massives. Timeout automatique
tous les cinq manquements, salons exemptables, administrateurs jamais filtrés.

Le journal enregistre les messages supprimés et modifiés, les arrivées (avec
alerte sur les comptes de moins d'une semaine), les départs avec leurs rôles,
les changements de pseudo et toutes les actions de l'automod.

## Vie du serveur

Boutique de rôles, salons vocaux temporaires (rejoins un salon, le bot t'en crée
un rien qu'à toi), starboard, sondages à boutons, tickets, anniversaires,
confessions anonymes, giveaways, missions.

## Installation

```bash
pip install -r requirements.txt
cp .env.example .env      # puis colle ton token dedans
```

Lancement :

```bash
bash start.sh             # Linux / hébergeur
start.bat                 # Windows
```

`config.json` et le dossier `data/` sont créés automatiquement au premier
démarrage. Voir `config.example.json` pour tous les réglages disponibles.

> **Python 3.13+** — `discord.py` 2.3 ne s'installe plus (le module `audioop` a
> quitté la bibliothèque standard). Le `requirements.txt` demande une version
> compatible.

## Structure

```
src/          le code, un fichier JSON par module
  _loader.json    chargeur : rend src/*.json importable
  bot.json        point d'entrée, événements, /help, tâches planifiées
  core.json       stockage, configuration, économie de base, niveaux
  economy.json    portefeuille, box, missions, giveaways, classements
  games.json      jeux entre joueurs et casino
  admin.json      enchères, argent, rôles, anti-raid, sauvegarde, captcha
  moderation.json sanctions, automod, journal
  community.json  boutique de rôles, métiers, vocal temporaire, tickets
data/         généré au runtime, jamais versionné
```

Le code Python vit **à l'intérieur** des fichiers JSON, sous la clé `source`
(un tableau, une ligne de code par case). Au démarrage, `_loader.json` branche
un finder sur le système d'import : `import core` lit `src/core.json`.

Pour modifier un module, édite les lignes du tableau `source` — l'indentation
compte, et les guillemets s'échappent en `\"`. Vérifier avant de relancer :

```bash
python3 -c "import json;s=json.load(open('src/core.json',encoding='utf-8'))['source'];compile(chr(10).join(s),'core','exec');print('OK')"
```

## Données

Quatre fichiers dans `data/` : `economy.json` (soldes, banques, stats, niveaux,
séries, inventaires, anti-vol), `server.json` (configuration par serveur),
`moderation.json` (avertissements, historique, automod), `events.json`
(enchères, giveaways, missions, boutique).

Tout est **en cache mémoire** avec écriture différée de deux secondes : un
message récompensé ne touche plus le disque. Les écritures sont atomiques
(fichier temporaire, `fsync`, puis remplacement) — une coupure en plein milieu
laisse l'ancien fichier intact. Un JSON illisible est mis de côté en
`.corrompu-<date>` au lieu d'être écrasé par un fichier vide.

Sauvegarde automatique de tout le dossier `data/` deux fois par jour dans
`data/sauvegardes/`, les 14 dernières conservées.

## Configuration

Après le premier démarrage, tout se fait depuis Discord :

```
/configurer voir              état complet de la configuration
/configurer logs #salon       journal de modération
/configurer starboard #salon  best-of automatique
/configurer vocal-temporaire  salons vocaux à la demande
/configurer role-niveau       rôle offert à un palier
/automod regle                activer les protections
/roles-boutique ajouter       mettre un rôle en vente
```

Tout est **désactivé par défaut** : rien ne change sur ton serveur tant que tu
n'as rien configuré.

## Licence

MIT — voir [LICENSE](LICENSE).
