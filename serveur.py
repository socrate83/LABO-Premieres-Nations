#!/usr/bin/env python3
"""Serveur local LABO — 127.0.0.1:8081 (fiable sur Windows + Chrome)."""
import os
import sys
import threading
import webbrowser
from http.server import HTTPServer, SimpleHTTPRequestHandler

PORT = 8081
HOST = "127.0.0.1"


def main():
    racine = os.path.dirname(os.path.abspath(__file__))
    os.chdir(racine)

    url = f"http://{HOST}:{PORT}/"

    print()
    print("=" * 44)
    print("  LABO Premières Nations")
    print(f"  {url}")
    print("=" * 44)
    print()
    print(f"  Dossier servi : {racine}")
    print()

    if not os.path.isfile("index.html"):
        print("  [ERREUR] index.html introuvable dans ce dossier.")
        print("  Fais git pull pour récupérer la dernière version du LABO.")
        input("\n  Appuie sur Entrée pour fermer...")
        sys.exit(1)

    print("  [OK] index.html trouvé")
    print()
    print("  >>> NE FERME PAS cette fenêtre <<<")
    print("  Arrêt : Ctrl+C")
    print()

    try:
        server = HTTPServer((HOST, PORT), SimpleHTTPRequestHandler)
    except OSError as exc:
        print(f"  [ERREUR] Impossible d'écouter sur {HOST}:{PORT}")
        print(f"           {exc}")
        if "10048" in str(exc) or "already in use" in str(exc).lower():
            print("  Le port 8081 est déjà pris. Ferme l'autre fenêtre serveur.")
        input("\n  Appuie sur Entrée pour fermer...")
        sys.exit(1)

    def ouvrir_navigateur():
        webbrowser.open(url)

    threading.Timer(1.0, ouvrir_navigateur).start()

    print(f"  [OK] Serveur actif — ouvre Chrome : {url}")
    print("  (Utilise bien http:// et NON https://)")
    print()

    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\n  Serveur arrêté.")
    finally:
        server.server_close()


if __name__ == "__main__":
    main()
