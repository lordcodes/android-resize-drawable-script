#!/bin/sh

CREATE_LDPI=0

USAGE="Usage: resize-drawable [filename] {-l | --create-ldpi}\n\n"
USAGE+="E.g.: resize-drawable /project/app/main/src/res/drawable-xxxhdpi/ic_launcher.png\n\n"
USAGE+="Flags:\n"
USAGE+="    -l | --create-ldpi = An image for LDPI will be generated. By default LDPI is skipped, as most tools don't bother with LDPI anymore.\n"

if [ "$1" = "-h" ]; then
  echo "
resize-drawable is a simple script that takes an Android drawable and scales it down to produce the lower density versions.
"
  echo $USAGE

  exit 1
elif [ "$1" == "-l" ] || [ "$1" == "--create-ldpi" ]; then
  CREATE_LDPI=1
elif [[ ! -z $1 ]]; then
  FILENAME=$1
fi

if [ "$2" == "-l" ] || [ "$2" == "--create-ldpi" ]; then
  CREATE_LDPI=1
elif [[ ! -z $2 ]]; then
  FILENAME=$2
fi

if [[ -z $FILENAME ]]; then
  echo "
No file to resize was provided.
"
  echo $USAGE

  exit 1
fi

FOLDER=`dirname $FILENAME`

if [[ $FOLDER == *"drawable"* ]]; then
  RESOURCE_TYPE="drawable"
elif [[ $FOLDER == *"mipmap"* ]]; then
  RESOURCE_TYPE="mipmap"
fi

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
  echo $USAGE

  exit 1
fi

PARENT=`dirname $FOLDER`

if [[ $BASE_RATIO -ge XXXHDPI_RATIO ]]; then
  RATIO=$((100 * 3 / BASE_RATIO))
  if [ $RATIO -ne 100 ] ; then
    echo "Convert $FILENAME to xxhdpi"
    # convert androidclient/src/${COMPANY}/res/drawable-${RESOLUTION}/${FILENAME} -sharpen 0x1 -colorspace RGB -resize ${RATIO}% -colorspace sRGB androidclient/src/${COMPANY}/res/drawable-xxhdpi/${FILENAME}
  fi
fi

if [[ $BASE_RATIO -ge XXHDPI_RATIO ]]; then
  RATIO=$((100 * 2 / BASE_RATIO))
  if [ $RATIO -ne 100 ] ; then
    echo "Convert $FILENAME to xhdpi"
    # convert androidclient/src/${COMPANY}/res/drawable-${RESOLUTION}/${FILENAME} -sharpen 0x1 -colorspace RGB -resize ${RATIO}% -colorspace sRGB androidclient/src/${COMPANY}/res/drawable-xhdpi/${FILENAME}
  fi
fi

if [[ $BASE_RATIO -ge XHDPI_RATIO ]]; then
  RATIO=$((100 * 3 / (2 * BASE_RATIO)))
  if [ $RATIO -ne 100 ] ; then
    echo "Convert $FILENAME to hdpi"
    # convert androidclient/src/${COMPANY}/res/drawable-${RESOLUTION}/${FILENAME} -sharpen 0x1 -colorspace RGB -resize ${RATIO}% -colorspace sRGB androidclient/src/${COMPANY}/res/drawable-hdpi/${FILENAME}
  fi
fi

if [[ $BASE_RATIO -ge HDPI_RATIO ]]; then
  RATIO=$((100 * 1 / BASE_RATIO))
  if [ $RATIO -ne 100 ] ; then
    echo "Convert $FILENAME to mdpi"
    # convert androidclient/src/${COMPANY}/res/drawable-${RESOLUTION}/${FILENAME} -sharpen 0x1 -colorspace RGB -resize ${RATIO}% -colorspace sRGB androidclient/src/${COMPANY}/res/drawable-mdpi/${FILENAME}
  fi
fi

if [[ $CREATE_LDPI -eq 1 ]] && [[ $BASE_RATIO -ge MDPI_RATIO ]]; then
  RATIO=$((100 * 1 / (2 * BASE_RATIO)))
  if [ $RATIO -ne 100 ] ; then
    echo "Convert $FILENAME to ldpi"
    # convert androidclient/src/${COMPANY}/res/drawable-${RESOLUTION}/${FILENAME} -sharpen 0x1 -colorspace RGB -resize ${RATIO}% -colorspace sRGB androidclient/src/${COMPANY}/res/drawable-ldpi/${FILENAME}
  fi
fi

exit 0
