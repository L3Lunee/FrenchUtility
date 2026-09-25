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

# discord.py 2.1 minimum : on installe ou met a jour les dependances seulement
# si elles manquent ou si la version est trop ancienne.
if ! python3 -c "import sys,re,discord,dotenv;v=tuple(int(x) for x in re.findall(r'\d+',discord.__version__)[:2]);sys.exit(0 if v>=(2,1) else 1)" 2>/dev/null; then
    echo "[..] Dependances manquantes ou discord.py trop ancien, mise a jour en cours..."
    python3 -m pip install --disable-pip-version-check -U -r requirements.txt
fi

python3 -c 'import json;exec("\n".join(json.load(open("src/_loader.json",encoding="utf-8"))["source"]))'
