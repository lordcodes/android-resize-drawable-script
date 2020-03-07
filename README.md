# Android Drawable Resizer

NOTE - No longer actively developed. The script is provided as-is and will no longer be worked on or supported. It was created out of a need to resize drawables quickly and easily. More recent versions of Android Studio and the move towards vector drawables for many assets, this script should no longer be needed.

---

`resize-drawable` is a shell script that can save you time by converting Android drawables into lower resolution versions.

## Requirements

- Mac or Linux
- Shell
- [ImageMagick](http://www.imagemagick.org/script/binary-releases.php)

## ImageMagick

The convert program is used to perform the image resizing. It can be downloaded from http://www.imagemagick.org/script/binary-releases.php and there are binary releases available for easy install.

- [Mac download and setup instructions](http://www.imagemagick.org/script/binary-releases.php#macosx)
- [Linux download and setup instructions](http://www.imagemagick.org/script/binary-releases.php#unix)

## Usage

`resize-drawable [options] <filename1,filename2,...> [options]`

E.g. `resize-drawable drawable-xxxhdpi/image.png`

`resize-drawable -do -f drawable-xxxhdpi/image.png -s`

You can also provide a list of images to resize.

E.g. `resize-drawable drawable-xxxhdpi/image.png,drawable-xxhdpi/another.png`

###### Note:
If the script cannot be executed you may need to run `chmod +x resize-drawable`.

### Options

| Flag | Alternate flag            | Argument                  | Description                                         |
| ---- | ------------------------- | ------------------------- | --------------------------------------------------- |
| -h   | --help                    |                           | Display this usage message                          |
| -c   | --config                  | \<file\>                  | Specify config file location                        |
| -s   | --silence                 |                           | Run with no output (except errors)                  |
| -f   | --file                    | \<file1,file2,...\>       | Specify file to convert, can be used multiple times |
| -do  | --disable-overwrite       |                           | Disable overwriting if image already exists         |
| -df  | --disable-folder-creation |                           | Disable creating folder if it doesn't exit          |
| -l   | --create-ldpi             |                           | Generate LDPI image                                 |
| -e   | --exclude                 | \<density1,density2,...\> | Exclude densities from being resized                |
|      | --xxhdpi                  | \<folder\>                | Change folder name to place XXHDPI image in         |
|      | --xhdpi                   | \<folder\>                | Change folder name to place XHDPI image in          |
|      | --hdpi                    | \<folder\>                | Change folder name to place HDPI image in           |
|      | --mdpi                    | \<folder\>                | Change folder name to place MDPI image in           |
|      | --ldpi                    | \<folder\>                | Change folder name to place LDPI image in           |

### File:
You can provide the filepath of a single image, or a comma-separated list of images to resize. Also, using the `-f` or `--file` option, you can provide the filepath of images to convert. If the file option is used multiple times, all of the images specified will be resized.

Each image specified must be stored within a folder containing a density specifier. The other resolutions will be placed into folders alongside it.

E.g. If `/home/project/drawable-xxxhdpi/image.png` was provided, images would be placed at:

- `/home/project/drawable-xxhdpi/image.png`
- `/home/project/drawable-xhdpi/image.png`
- `/home/project/drawable-hdpi/image.png`
- `/home/project/drawable-mdpi/image.png`

By default, an LDPI version is not generated. This can be enabled using the `-l` or `--create-ldpi` flag.

The script automatically detects if the provided file is stored within a `drawable` or `mipmap` folder and places the other images in folders of the same type.

###### Note:
If a file with the same name is already stored at the location, it will be overwritten. You can use the `-do` or `--disable-overwrite` flag to disable this functionality.

###### Note:
If a folder doesn't exist to place one of the image sizes in, it will be created. You can use the `-df` or `--disable-folder-creation` flag to instead skip that size.

###### Note:
Default locations are:
- `drawable-xxhdpi` or `mipmap-xxhdpi`
- `drawable-xhdpi` or `mipmap-xhdpi`
- `drawable-hdpi` or `mipmap-hdpi`
- `drawable-mdpi` or `mipmap-mdpi`
- `drawable-ldpi` or `mipmap-ldpi`

### Config

The various configuration options can also be provided through a config file. A default config file is included alongside the script.

If a command-line argument is provided for the same setting, then it will override the value in the config file. This allows you to specify your default configuration and alter settings whenever you need to through command-line arguments.

## Author

Andrew Lord [@lordcodes](https://twitter.com/@lordcodes)
