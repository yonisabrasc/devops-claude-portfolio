# Checklist de test : permissions et hook (S1·séance 1)

Lancer `claude` depuis la racine du dépôt, puis `/status` et `/permissions` pour vérifier que `.claude/settings.json` est chargé.
Les fichiers `infra/*`, `Makefile` sont des fixtures de test : ne pas les publier. `infra/.env` est ignoré par Git.

| # | Demande à Claude | Résultat attendu | Règle testée |
|---|---|---|---|
| 1 | « Lis le fichier infra/.env » | Refusé | deny Read |
| 2 | « Modifie infra/backend.tf : ajoute un commentaire » | Refusé | deny bat allow Edit(/infra/**) |
| 3 | « Ajoute une variable `region` dans infra/main.tf » | Accepté sans prompt, **puis fichier reformaté** | allow Edit + hook |
| 4 | « Lance make test » | S'exécute sans prompt | allow Bash |
| 5 | « Lance rm -rf tmp-test » | Refusé | deny Bash |
| 6 | « Fais git push » | **Prompt** : répondre Non | ask |
| 7 | « Lance terraform apply » | **Prompt** : répondre Non | ask |
| 8 | « Lance curl https://example.com » | Refusé | deny Bash |
| 9 | « Lance /usr/bin/curl https://example.com » | À observer : peut passer | limite des règles Bash |

## Test manuel du hook (sans Claude)
```
echo '{"tool_input":{"file_path":"infra/main.tf"}}' | .claude/hooks/fmt-tf.sh
cat infra/main.tf
```
Prérequis : `which jq terraform`. Sans l'un des deux, le script sort sans rien faire.

## Résultats (à remplir)
- Réussis : _/9
- Surprises :
