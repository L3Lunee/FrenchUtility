#!/bin/bash
# Lancement du bot. Tout le code vit dans src/*.json : cette ligne amorce
# le chargeur (src/_loader.json) qui rend ces fichiers importables,
# puis demarre src/bot.json.

# Se placer dans le dossier du bot, quel que soit l'endroit d'ou on lance le script
cd "$(dirname "$0")" || exit 1

# Charger les variables d'environnement depuis le fichier .env
set -a
source .env
set +a

python3 -c 'import json;exec("\n".join(json.load(open("src/_loader.json",encoding="utf-8"))["source"]))'
