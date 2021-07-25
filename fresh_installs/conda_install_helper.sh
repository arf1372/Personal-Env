#!/bin/bash
## In The Name of Allah

CONDA_INSTR_URL="https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh"
CONDA_INST_CHEK="2751ab3d678ff0277ae80f9e8a74f218cfc70fe9a9cdc7bb1c137d7e47e33d53"
CONDA_INST_FILE="${HOME}/conda.sh"
CONDA_INST_PATH="${HOME}/anaconda3"
CONDA_BASH_INST="${CONDA_INST_FILE} -bp ${CONDA_INST_PATH} "

error_in_inst () {
	if [ -n $1 ]
	then
		echo "$1"
	fi

	echo ""
	echo "=============================================="
	echo "| ERROR IN INSTALLING CONDA! PLEASE RESTART! |"
	echo "=============================================="
	echo ""

	exit 1
}


## Check if any prior version of anaconda is installed in `~/anaconda3`
if [ -d "$CONDA_INST_PATH" ]
then
	rm -rf "${CONDA_INST_PATH}"
fi

## Check if another version of `conda.sh` is present?
if [ -f "$CONDA_INST_FILE" ]
then
	rm -f "$CONDA_INST_FILE"
fi

## Download the most recent verseion of installer (as of Jul 9' 21)
wget -o "$CONDA_INST_FILE" "$CONDA_INSTR_URL"

## Check if the Download was successfull
if [ $? -ne 0 ]
then
	error_in_inst " Download ${CONDA_INST_FILE} from \"${CONDA_INSTR_URL}\" was not successful."
fi

sha256sum --status -c <(echo "$CONDA_CHECKSUM  $CONDA_INST_FILE") || error_in_inst " Downoaded file is corrupted! (${CONDA_INST_FILE})"


bash $CONDA_BASH_INST && rm $CONDA_INST_FILE || error_in_inst " Installation unsuccessful!"

echo "Congratulations\!\!"
echo "Successfully installed Anadonda in ${CONDA_INST_PATH}\!"
echo ""
