# Android Drawable Resizer

`resize-drawable` is a shell script that can save you time by converting Android drawables into lower resolution versions.


<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=VNDYLUZK5AYV4"><img src="https://www.paypalobjects.com/en_GB/i/btn/btn_donate_LG.gif"/></a>

## Requirements

- Mac or Linux (Windows coming soon)
- Shell
- [ImageMagick](http://www.imagemagick.org/script/binary-releases.php)

## ImageMagick

The convert program is used to perform the image resizing. It can be downloaded from http://www.imagemagick.org/script/binary-releases.php and there are binary releases available for easy install.

- [Mac download and setup instructions](http://www.imagemagick.org/script/binary-releases.php#macosx)
- [Linux download and setup instructions](http://www.imagemagick.org/script/binary-releases.php#unix)

## Usage

`resize-drawable [options] <filename> [options]`

E.g. `resize-drawable drawable-xxxhdpi/image.png`

###### Note:
If the file cannot be executed you may need to run `chmod +x resize.drawable`.

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

| Flag | Alternate flag            | Argument                  | Description                                 |
| ---- | ------------------------- | ------------------------- | ------------------------------------------- |
| -h   | --help                    |                           | Display this usage message                  |
| -c   | --config                  | \<file\>                  | Specify config file location                |
| -s   | --silence                 |                           | Run with no output (except errors)          |
| -do  | --disable-overwrite       |                           | Disable overwriting if image already exists |
| -df  | --disable-folder-creation |                           | Disable creating folder if it doesn't exit  |
| -l   | --create-ldpi             |                           | Generate LDPI image                         |
| -e   | --exclude                 | \<density1,density2,...\> | Exclude densities from being resized        |
|      | --xxhdpi                  | \<folder\>                | Change folder name to place XXHDPI image in |
|      | --xhdpi                   | \<folder\>                | Change folder name to place XHDPI image in  |
|      | --hdpi                    | \<folder\>                | Change folder name to place HDPI image in   |
|      | --mdpi                    | \<folder\>                | Change folder name to place MDPI image in   |
|      | --ldpi                    | \<folder\>                | Change folder name to place LDPI image in   |

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

## Feedback

If you notice any bugs or want to suggest any improvements, please create an issue. All feedback is welcome!

If you have found the script useful and it has saved you some time, please don't hesitate to donate and support development.

<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=VNDYLUZK5AYV4"><img src="https://www.paypalobjects.com/en_GB/i/btn/btn_donate_LG.gif"/></a>

