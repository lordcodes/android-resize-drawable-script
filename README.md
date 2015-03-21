# Android Drawable Resizer

`resize-drawable` is a shell script that can save you time by converting Android drawables into lower resolution versions.

## Requirements

- Mac or Linux (Windows coming soon)
- Shell
- [ImageMagick](http://www.imagemagick.org/script/binary-releases.php)

## ImageMagick

The convert program is used to perform the image resizing. It can be downloaded from http://www.imagemagick.org/script/binary-releases.php and there are binary releases available for easy install.

- [Mac download and setup instructions](http://www.imagemagick.org/script/binary-releases.php#macosx)
- [Linux download and setup instructions](http://www.imagemagick.org/script/binary-releases.php#unix)

## Usage

`resize-drawable [options] FILENAME`

E.g. `resize-drawable drawable-xxxhdpi/image.png`

### Filename:
Path to an image file, that is stored within a folder containing a density specifer. The other resolutions will be placed into folders alongside it.

E.g. If `/home/project/drawable-xxxhdpi/image.png` was provided, images would be placed at:

- `/home/project/drawable-xxhdpi/image.png`
- `/home/project/drawable-xhdpi/image.png`
- `/home/project/drawable-hdpi/image.png`
- `/home/project/drawable-mdpi/image.png`

By default, an LDPI version is not generated. This can be enabled using the `-l` or `--create-ldpi` flag.

The script automatically detects if the provided file is stored within a `drawable` or `mipmap` folder and places the other images in folders of the same type.

###### Note:
If a file with the same name is already stored at the location, it will be overwritten. A flag will be added in a future update, to give you the option of disabling this behaviour.

### Options

| Flag | Alternate version  | Description                                 |
| ---- | ------------------ | ------------------------------------------- |
| -h   | --help             | Display this usage message                  |
| -c   | --config           | Specify config file location                |
| -l   | --create-ldpi      | Generate LDPI image                         |
|      | --xxhdpi           | Change folder name to place XXHDPI image in |
|      | --xhdpi            | Change folder name to place XHDPI image in  |
|      | --hdpi             | Change folder name to place HDPI image in   |
|      | --mdpi             | Change folder name to place MDPI image in   |
|      | --ldpi             | Change folder name to place LDPI image in   |

###### Note:
Default locations are:
- `drawable-xxhdpi` or `mipmap-xxhdpi`
- `drawable-xhdpi` or `mipmap-xhdpi`
- `drawable-hdpi` or `mipmap-hdpi`
- `drawable-mdpi` or `mipmap-mdpi`
- `drawable-ldpi` or `mipmap-ldpi`

### Config

The various configuration options can also be provided through a config file. A default config file is included alongside the script.

```
CONFIG_CREATE_LDPI=0

# Set custom folder names below
# E.g. CONFIG_XXHDPI_FOLDER=xxhdpi_location

CONFIG_XXHDPI_FOLDER=
CONFIG_XHDPI_FOLDER=
CONFIG_HDPI_FOLDER=
CONFIG_MDPI_FOLDER=
CONFIG_LDPI_FOLDER=
```

If a command-line argument is provided for the same setting, then it will override the value in the config file. This allows you to specify your default configuration and alter settings whenever you need to through command-line arguments.
