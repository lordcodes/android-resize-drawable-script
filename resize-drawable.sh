#!/bin/sh
##
## Script to take an Android drawable and scale it down to produce the lower density versions.
## Copyright (C) 2015 Andrew Lord - All Rights Reserved
## MIT License
##
## Usage: resize-drawable [options] FILENAME
##
## FILENAME:
##
##   Path to an Android image drawable. The other resolutions will be placed in folders alongisde it.
##
##   E.g. If /home/project/drawable-xxxhdpi/image.png was provided, images would be placed at
##
##     /home/project/drawable-xxhdpi/image.png
##     /home/project/drawable-xhdpi/image.png
##     /home/project/drawable-hdpi/image.png
##     /home/project/drawable-mdpi/image.png
##
##   If a file with the same name is already at that location, it will be overwritten.
##
##   The script automatically detects if the provided file is in a drawable or mipmap folder and places the other folders in the same.
##
## Options:
##
##   -h, --help              Display this usage message
##   -l, --create-ldpi       An image for LDPI will be generated as well. By default LDPI is skipped, as most tools no longer bother with LDPI anymore
##   --xxhdpi                Alter the folder to store a generated XXHDPI image at. Default is either drawable-xxhdpi or mipmap-xxhdpi
##   --xhdpi                 Alter the folder to store a generated XHDPI image at. Default is either drawable-xhdpi or mipmap-xhdpi
##   --hdpi                  Alter the folder to store a generated HDPI image at. Default is either drawable-hdpi or mipmap-hdpi
##   --mdpi                  Alter the folder to store a generated MDPI image at. Default is either drawable-mdpi or mipmap-mdpi
##   --ldpi                  Alter the folder to store a generated LDPI image at. Default is either drawable-ldpi or mipmap-ldpi
##

usage() {
  [ "$*" ] && echo "$0: $*"
  sed -n '/^##/,/^$/s/^## \{0,1\}//p' "$0"
  exit 2
} 2>/dev/null

set_xxhdpi_folder() {
  if [[ -z $XXHDPI_FOLDER ]]; then
    XXHDPI_FOLDER=$1
  fi
}

set_xhdpi_folder() {
  if [[ -z $XHDPI_FOLDER ]]; then
    XHDPI_FOLDER=$1
  fi
}

set_hdpi_folder() {
  if [[ -z $HDPI_FOLDER ]]; then
    HDPI_FOLDER=$1
  fi
}

set_mdpi_folder() {
  if [[ -z $MDPI_FOLDER ]]; then
    MDPI_FOLDER=$1
  fi
}

set_ldpi_folder() {
  if [[ -z $LDPI_FOLDER ]]; then
    LDPI_FOLDER=$1
  fi
}

handle_filename() {
  FILE=`basename $FILENAME`
  FILEPATH=`dirname $FILENAME`
  FOLDER=`basename $FILEPATH`

  if [[ $FOLDER == *"drawable"* ]]; then
    RESOURCE_TYPE="drawable"

    set_xxhdpi_folder "drawable-xxhdpi"
    set_xhdpi_folder "drawable-xhdpi"
    set_hdpi_folder "drawable-hdpi"
    set_mdpi_folder "drawable-mdpi"
    set_ldpi_folder "drawable-ldpi"

  elif [[ $FOLDER == *"mipmap"* ]]; then
    RESOURCE_TYPE="mipmap"

    set_xxhdpi_folder "mipmap-xxhdpi"
    set_xhdpi_folder "mipmap-xhdpi"
    set_hdpi_folder "mipmap-hdpi"
    set_mdpi_folder "mipmap-mdpi"
    set_ldpi_folder "mipmap-ldpi"

  fi

  PARENT=`dirname $FILEPATH`
}

handle_conversion_ratio() {
  XXXHDPI_RATIO=4
  XXHDPI_RATIO=3
  XHDPI_RATIO=2
  HDPI_RATIO=$((3 / 2))
  MDPI_RATIO=1
  LDPI_RATIO=$((1 / 2))

  if [[ $FOLDER == *"-xxxhdpi"* ]]; then
    BASE_RATIO=XXXHDPI_RATIO
  elif [[ $FOLDER == *"-xxhdpi"* ]]; then
    BASE_RATIO=XXHDPI_RATIO
  elif [[ $FOLDER == *"-xhdpi"* ]]; then
    BASE_RATIO=XHDPI_RATIO
  elif [[ $FOLDER == *"-hdpi"* ]]; then
    BASE_RATIO=HDPI_RATIO
  elif [[ $FOLDER == *"-mdpi"* ]]; then
    BASE_RATIO=MDPI_RATIO
  else
    echo "
  File in an invalid folder was specified.

  PLease provide a file that is inside a folder with one of the following specifiers:

  -xxxhdpi
  -xxhdpi
  -xhdpi
  -hdpi
  -mdpi

  Files can be provided from a drawable folder or a mipmap folder.

  E.g. drawable-xxhdpi
  "
    exit 1
  fi
}

perform_conversion() {
  if [[ $BASE_RATIO -ge XXXHDPI_RATIO ]]; then
    RATIO=$((100 * 3 / BASE_RATIO))
    if [ $RATIO -ne 100 ] ; then
      echo "$FILE to xxhdpi in folder $XXHDPI_FOLDER ..."
      DEST_FOLDER=${PARENT}/${XXHDPI_FOLDER}
      mkdir -p ${DEST_FOLDER}
      convert ${FILENAME} -sharpen 0x1 -colorspace RGB -resize ${RATIO}% -colorspace sRGB ${DEST_FOLDER}/${FILE}
      echo "xxhdpi done"
    fi
  fi

  if [[ $BASE_RATIO -ge XXHDPI_RATIO ]]; then
    RATIO=$((100 * 2 / BASE_RATIO))
    if [ $RATIO -ne 100 ] ; then
      echo "$FILE to xhdpi in folder $XHDPI_FOLDER ..."
      DEST_FOLDER=${PARENT}/${XHDPI_FOLDER}
      mkdir -p ${DEST_FOLDER}
      convert ${FILENAME} -sharpen 0x1 -colorspace RGB -resize ${RATIO}% -colorspace sRGB ${DEST_FOLDER}/${FILE}
      echo "xhdpi done"
    fi
  fi

  if [[ $BASE_RATIO -ge XHDPI_RATIO ]]; then
    RATIO=$((100 * 3 / (2 * BASE_RATIO)))
    if [ $RATIO -ne 100 ] ; then
      echo "$FILE to hdpi in folder $HDPI_FOLDER ..."
      DEST_FOLDER=${PARENT}/${HDPI_FOLDER}
      mkdir -p ${DEST_FOLDER}
      convert ${FILENAME} -sharpen 0x1 -colorspace RGB -resize ${RATIO}% -colorspace sRGB ${DEST_FOLDER}/${FILE}
      echo "hdpi done"
    fi
  fi

  if [[ $BASE_RATIO -ge HDPI_RATIO ]]; then
    RATIO=$((100 * 1 / BASE_RATIO))
    if [ $RATIO -ne 100 ] ; then
      echo "$FILE to mdpi in folder $MDPI_FOLDER ..."
      DEST_FOLDER=${PARENT}/${MDPI_FOLDER}
      mkdir -p ${DEST_FOLDER}
      convert ${FILENAME} -sharpen 0x1 -colorspace RGB -resize ${RATIO}% -colorspace sRGB ${DEST_FOLDER}/${FILE}
      echo "mdpi done"
    fi
  fi

  if [[ $CREATE_LDPI -eq 1 ]] && [[ $BASE_RATIO -ge MDPI_RATIO ]]; then
    RATIO=$((100 * 1 / (2 * BASE_RATIO)))
    if [ $RATIO -ne 100 ] ; then
      echo "$FILE to ldpi in folder $LDPI_FOLDER ..."
      DEST_FOLDER=${PARENT}/${LDPI_FOLDER}
      mkdir -p ${DEST_FOLDER}
      convert ${FILENAME} -sharpen 0x1 -colorspace RGB -resize ${RATIO}% -colorspace sRGB ${DEST_FOLDER}/${FILE}
      echo "ldpi done"
    fi
  fi
}


# MAIN

CREATE_LDPI=0

while [ $# -gt 0 ]; do
  if [ "$1" = "-h" ] || [ "$1" == "--help" ]; then
    usage
    exit 1
  elif [ "$1" == "-l" ] || [ "$1" == "--create-ldpi" ]; then
    CREATE_LDPI=1
    shift
  elif [ "$1" == "--xxhdpi" ] && [[ ! -z $2 ]]; then
    XXHDPI_FOLDER=$2
    shift 2
  elif [ "$1" == "--xhdpi" ] && [[ ! -z $2 ]]; then
    XHDPI_FOLDER=$2
    shift 2
  elif [ "$1" == "--hdpi" ] && [[ ! -z $2 ]]; then
    HDPI_FOLDER=$2
    shift 2
  elif [ "$1" == "--mdpi" ] && [[ ! -z $2 ]]; then
    MDPI_FOLDER=$2
    shift 2
  elif [ "$1" == "--ldpi" ] && [[ ! -z $2 ]]; then
    LDPI_FOLDER=$2
    shift 2
  elif [[ ! -z $1 ]] && [[ -z $FILENAME ]]; then
    FILENAME=$1
    shift
  else
    shift
  fi
done

if [[ -z $FILENAME ]]; then
  echo "
No file to resize was provided.
"
  usage

  exit 1
fi

handle_filename
handle_conversion_ratio
perform_conversion

exit 0