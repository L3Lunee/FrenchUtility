<div align="center">

# FrenchUtility

**Un bot Discord tout-en-un, en français : économie, niveaux, casino, modération, journal.**

Python 3 · discord.py 2 · aucune base de données

[![version](https://img.shields.io/badge/v3.0-000000?style=flat-square)](https://github.com/L3Lunee/FrenchUtility)
[![python](https://img.shields.io/badge/Python%203.10%2B-000000?style=flat-square)](#installation)
[![license](https://img.shields.io/badge/MIT-000000?style=flat-square)](LICENSE)

</div>

## Ce que c'est

Un bot de communauté complet pour les serveurs francophones, dans l'esprit de
DraftBot (configuration et utilitaires), de Bob (économie RP) et de Quark Log
(journal) :

- une **économie** par serveur : banque avec intérêts, métiers, crime, pêche,
  box, boutique de rôles, enchères, vols et protections ;
- des **niveaux** alimentés par les messages **et** le vocal, avec rôles de récompense ;
- un **casino** et des jeux entre membres ;
- la **modération** : sanctions avec MP au membre, automod, anti-raid, tickets, captcha ;
- un **journal** détaillé, réglable événement par événement.

**79 commandes** (131 en comptant chaque sous-commande), sous la limite de 100 de Discord.
Chaque serveur a ses propres soldes, niveaux, réglages, objets de box et prix :
rien n'est mélangé entre deux serveurs.

## Économie

Gagner de l'argent passe par la présence : **1 coin et 5 XP par message**
(maximum une fois par minute), autant par minute de vocal. Le vocal ne compte
que si tu n'es pas en sourdine, pas dans le salon AFK, et qu'il y a **au moins
deux personnes** dans le salon. Tout est réglable par serveur.

| Commande | Rôle |
| --- | --- |
| `/profil` · `/solde` · `/niveau` | Cartes de profil : fortune, rang, niveau, badges, position |
| `/daily` · `/weekly` | Récompenses, le daily monte jusqu'à **×3** avec la série |
| `/travailler` · `/metiers` | 7 métiers débloqués par niveau |
| `/crime` | 55 % de réussite, gros gain, sinon amende de 20 % |
| `/peche` | Des prises à revendre, du vieux godillot au coffre englouti |
| `/deposer` · `/retirer` · `/pay` | La banque rapporte **0,5 % par jour** |
| `/box` · `/shop` · `/roles-boutique voir` · `/enchere liste` | Dépenser |
| `/inventaire` · `/vendre` · `/trade` | Objets, avec « Tout vendre » |
| `/rob` · `/antirob` | Vol à 50 % d'échec, protection achetable |
| `/classement` | Menu pour changer de classement, pages, « Ma position » |

Les montants acceptent `500`, `2k`, `1.5m`, `tout`, `moitié`, `25%` :
`/deposer tout`, `/casino slots moitié`, `/pay @ami 2k`.

### Les box sont un pari

| Palier | Chance | Tu récupères |
| --- | --- | --- |
| 💥 Flop | 50 % | 25–70 % du prix |
| 😐 Correct | 32 % | 85–125 % |
| 😃 Bonne pioche | 15 % | 140–220 % |
| 🎰 **JACKPOT** | 3 % | **350–600 %** |

Tu perds de l'argent **62 % du temps**, pour une espérance de −1,4 %. Un objet
tombe dans 20 % des box communes, 45 % des rares, 100 % des légendaires. Chaque
serveur peut changer le prix des box et leurs objets (`/box-config`).

## Casino et jeux

`/casino slots` (jusqu'à ×75), `/casino blackjack` (avec **Doubler**),
`/casino roulette` (×2 ou ×36), `/casino pile-face` (×1,95), `/casino des` (×5,5).
Entre membres : `/morpion`, `/puissance4`, `/chifoumi`, `/bet-coin`, `/bet-roll`,
avec mise optionnelle ; en solo : `/devine-nombre`.

## Modération et journal

`/warn`, `/timeout`, `/kick`, `/ban` et le panneau `/moderer` : le membre reçoit
un MP avec la raison, la sanction va dans son `/historique` et dans le journal,
et le bot refuse de sanctionner un rôle égal ou supérieur au tien.

L'**automod** gère l'anti-spam, les liens, les invitations, les MAJUSCULES, les
mots interdits et les mentions de masse, avec une exclusion automatique toutes
les N infractions.

`/antiraid verrouiller` ferme d'un coup tous les salons à @everyone et
`/antiraid deverrouiller` remet chaque salon **exactement** dans son état d'origine.

Le **journal** couvre les messages supprimés et modifiés, les suppressions en
masse, les arrivées (alerte sur les comptes récents), les départs, les pseudos,
les rôles ajoutés ou retirés, les sanctions, l'automod, les bans, le vocal, les
salons et les rôles du serveur, ainsi que les tickets fermés (avec leur
transcription). Chaque catégorie peut avoir son propre salon.

## Vie du serveur

Tickets (un par membre, prise en charge, transcription), captcha à bouton,
messages de bienvenue et de départ, rôle automatique, panneaux de rôles à
boutons (qui survivent aux redémarrages), sondages avec barres de progression,
giveaways, starboard, vocaux temporaires, confessions, anniversaires, rappels,
missions.

## Configuration

Tout se règle depuis Discord :

```
/configurer voir              toute la configuration en un écran
/configurer module            activer / couper un module
/configurer gains             argent et XP par message et en vocal
/configurer economie          daily, weekly, délais, casino, vol
/configurer logs              salon principal du journal
/configurer journal           activer / couper chaque événement
/configurer journal-salon     un salon à part pour une catégorie
/configurer bienvenue|depart  messages d'arrivée et de départ
/configurer verification      captcha à l'arrivée
/configurer annonces-niveau   annonces de niveau (salon dédié)
/configurer role-niveau       rôle offert à un palier
/automod regle                activer les protections
```

La modération automatique, le captcha et le journal sont **désactivés par
défaut** : rien ne change sur un serveur tant qu'on n'a rien configuré.

## Ce qui a changé depuis la v2

Plusieurs commandes ont été regroupées, pour la lisibilité et pour garder de la
place sous la limite de 100 :

| Avant | Maintenant |
| --- | --- |
| `/portefeuille` · `/stats` | `/solde` · `/profil` |
| `/customize-money` · `/customize-exp` | `/configurer gains` |
| `/set-autorole` · `/bienvenue` | `/configurer autorole` · `/configurer bienvenue` |
| `/confessions-setup` · `/anniversaire-setup` | `/configurer confessions` · `/configurer anniversaires` |
| `/setup` · `/captcha` · `/renvoyer-verification` | `/configurer verification` (bouton + formulaire) |
| `/auction` · `/bid` · `/endauction` | `/enchere lancer` · `/enchere encherir` · `/enchere terminer` |
| `/backup` · `/restaurer` | `/sauvegarde creer` · `/sauvegarde restaurer` |
| `/creer-antiraid` · `/ouvrir-antiraid` | `/antiraid salon-creer` · `/antiraid salon-ouvrir` |
| `/shop-ajouter-item` · `/shop-retirer-item` | `/shop-config ajouter` · `/shop-config retirer` |
| `/check` | `/userinfo` (état vocal inclus) |
| `/setup-video` | supprimée (aucune annonce de vidéo n'était jamais envoyée) |

Nouveautés : `/profil`, `/crime`, `/peche`, `/kick`, `/ban`,
`/casino pile-face`, `/casino des`, `/box-config prix`, `/enchere liste`,
`/antiraid verrouiller`, `/ticket fermer`, `/sauvegarde info`,
`/configurer economie`, `/configurer journal`, `/configurer journal-salon`.

Corrections notables :

- `/cooldowns` plantait à chaque utilisation.
- Le bouton « Sauvegarder » de `/panel` plantait (il importait un module inexistant).
- Les box achetées via `/shop` ignoraient la table de paliers.
- Au chifoumi contre le bot, la mise n'était jamais prélevée : on gagnait sans jamais risquer de perdre.
- `/box-config` modifiait les objets de **tous** les serveurs à la fois.
- Le captcha était global : sur tous les serveurs, chaque nouvel arrivant recevait un captcha, même là où personne ne l'avait activé.
- Clôturer une enchère à la main ne donnait jamais l'objet au gagnant.
- Les panneaux de rôles cessaient de fonctionner au premier redémarrage.
- `config.json` était relu depuis le disque plusieurs fois par message.

## Installation

```bash
pip install -r requirements.txt
cp .env.example .env      # puis colle ton token dedans
```

Dans le Developer Portal, onglet **Bot**, active les trois *Privileged Gateway
Intents* (Presence, Server Members, Message Content).

Lancement :

```bash
bash start.sh             # Linux / hébergeur
start.bat                 # Windows
```

`config.json` et le dossier `data/` sont créés automatiquement au premier
démarrage. Voir `config.example.json` pour tous les réglages globaux (valeurs
par défaut de tous les serveurs).

> **Python 3.13+** — `discord.py` 2.3 ne s'installe plus (le module `audioop` a
> quitté la bibliothèque standard). Le `requirements.txt` demande une version
> compatible.

## Structure

```
src/          le code, un fichier JSON par module
  _loader.json    chargeur : rend src/*.json importable
  bot.json        point d'entrée, événements, /help, modules, tâches planifiées
  core.json       stockage, configuration, réglages par serveur, économie de base
  ui.json         couleurs, embeds, barres de progression, formatage
  economy.json    profils, banque, box, crime, pêche, missions, giveaways, classements
  games.json      jeux entre joueurs et casino
  admin.json      enchères, argent, rôles, anti-raid, sauvegarde, captcha
  moderation.json sanctions, automod, journal
  community.json  /configurer, boutique de rôles, métiers, bienvenue, tickets…
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
séries, inventaires, anti-vol), `server.json` (configuration par serveur :
modules, journal, bienvenue, vérification…), `moderation.json`
(avertissements, historique, automod), `events.json` (enchères, giveaways,
missions, boutique). Les réglages chiffrés propres à chaque serveur (gains,
délais, prix des box) sont dans `config.json`, sous `guilds`.

Tout est **en cache mémoire** avec écriture différée de deux secondes. Les
écritures sont atomiques (fichier temporaire, `fsync`, puis remplacement) : une
coupure en plein milieu laisse l'ancien fichier intact. Un JSON illisible est
mis de côté en `.corrompu-<date>` au lieu d'être écrasé.

Sauvegarde automatique de tout le dossier `data/` deux fois par jour dans
`data/sauvegardes/`, les 14 dernières conservées.

## Licence

MIT — voir [LICENSE](LICENSE).
