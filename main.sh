#!/bin/bash
source quit.sh

cmd() {
  cmd=$1
  argv=$*

  case "${cmd}" in
    quit | exit ) quit;;
  help )  echo "Commande disponible :" #permet d'afficher les commandes disponibles
            echo "ls  → Liste les fichiers et dossiers"
            echo "rm  → Supprime un fichier"
            echo "rmd / rmdir       → Supprime un dossier"
            echo "about → Description de votre programme"
            echo "version / --v / vers → Affiche la version du prompt"
            echo "age  → Demande votre âge"
            echo "quit  → Quitte le prompt"
            echo "profil  → Prénom, nom, âge et email"
            echo "passw  → Gestion du mot de passe"
            echo "cd  → Change de dossier"
            echo "pwd → Affiche le dossier actuel"
            echo "hour  → Affiche l'heure"
            echo "*  → Commande *"
            echo "httpget → Requête HTTP" 
            echo "smtp  → Gestion SMTP"
            echo "open   → Ouvre un fichier"
            ;;
  pwd ) pwd;; #permet d'afficher le dossier actuel
  ls ) ls;; #permet de lister les fichiers et dossiers
  rm ) echo "selectionner le fichier a suprimer"
                  read argv
                  echo "Voulez-vous vraiment supprimer le fichier $argv ? (y/n)"
                  read confirmation
                  if [ "$confirmation" = "y" ]; then
                      rm $argv
                      echo "Le fichier $argv a été supprimé."
                  else
                      echo "Suppression du fichier annulée."
                  fi ;;  #permet de supprimer un fichier
  rmd | rmdir )   echo "selectionner le dossier a supprimer"
                  read argv
                  echo "Voulez-vous vraiment supprimer le dossier $argv ? (y/n)"
                  read confirmation
                  if [ "$confirmation" = "y" ]; then
                      rmdir $argv
                      echo "Le dossier $argv a été supprimé."
                  else
                      echo "Suppression du dossier annulée."
                  fi;;      #permet de supprimer un dossier
  about ) echo "C est un programme qui permet de crée un terminal dans un terminal" ;; #permet d'afficher la description du programme
  version | --v | vers ) echo "Version 1.0.0";; #permet d'afficher la version du prompt
  age ) echo "Quel âge avez-vous ?" #permet de demander l'âge
            read age
            if [ $age -ge 18 ]; then
                    echo "Vous êtes majeur."
            else
                    echo "Vous êtes mineur."
            fi ;;

  profil ) echo "Quel est votre prénom ?" #permet de demander le prénom, nom, âge et email
           read prenom
           echo "Quel est votre nom ?"
           read nom
           echo "Quel est votre âge ?"
           read age
           echo "Quel est votre email ?"
           read email
           echo "Votre profil :"
           echo "Prénom : ${prenom}"
           echo "Nom : ${nom}"
           echo "Âge : ${age}"
           echo "Email : ${email}";;
  passw ) echo "Veuillez entrer votre mot de passe :" #permet de gérer le mot de passe
          read -s password
          echo "Veuillez confirmer votre mot de passe :"
          if read -s password_confirm && [ "$password" = "$password_confirm" ]; then
              echo "Mot de passe confirmé."
          else
              echo "Les mots de passe ne correspondent pas. Veuillez réessayer."
          fi
          echo "Mot de passe enregistré."
  
  
  
  ;; #permet de gérer le mot de passe
  cd ) echo "Dans quel dossier voulez-vous aller ?"
       read dossier
       cd "$dossier";; #permet de changer de dossier
  hour ) date +%H:%M:%S;; #permet de savoir l heure actuelle
  httpget ) echo "comment s'appelle votre fichier"
            read filename
            echo "Veuillez entrer l'URL à récupérer :"
            read url
            curl -o $filename.html $url ;; #permet de faire une requête HTTP
  smtp )
        echo "Destinataire : "
        read destinataire
        echo "Sujet : "
        read sujet
        echo  "Message : "
        read message 

        echo "$message" | mail -s "$sujet" "$destinataire"
       ;;
  open )
        echo -p "Quel fichier voulez-vous ouvrir ? "
        read fichier
        vim "$fichier"
                    ;; #permet d'ouvrir un fichier
  * ) echo "Commande non reconnue : ${cmd}";; #permet d'afficher un message d'erreur si la commande n'est pas reconnue
  rock ) echo "Choisissez votre coup (rock, paper, scissors) :"
                read user_choice
                choices=("rock" "paper" "scissors")
                computer_choice=${choices[$RANDOM % 3]}

                echo "Ordinateur a choisi : $computer_choice"

                if [ "$user_choice" = "$computer_choice" ]; then
                    echo "Égalité !"
                elif [ "$user_choice" = "rock" ] && [ "$computer_choice" = "scissors" ] || \
                     [ "$user_choice" = "paper" ] && [ "$computer_choice" = "rock" ] || \
                     [ "$user_choice" = "scissors" ] && [ "$computer_choice" = "paper" ]; then
                    echo "Vous gagnez !"
                else
                    echo "L'ordinateur gagne !"
                fi
                ;;
  esac
}

main() {
  lineCount=1

  while [ 1 ]; do
    date=$(date +%H:%M)
    echo -ne "${date} - [\033[31m${lineCount}\033[m] - \033[33mXzen\033[m ~ ☠️ ~ "
    read string

    cmd $string
    lineCount=$(($lineCount+1))
  done
}



verify() {
  echo "saissiser votre id"
  read id
  if [ "$id" != "Xzen" ]; then
    echo "id incorrect"
    exit 1
  fi
  echo "saissiser votre mot de passe"
  read -s password
  if [ "$password" != "12345" ]; then
    echo "mot de passe incorrect"
    exit 1
  fi
}

verify
main
