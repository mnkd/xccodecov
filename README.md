# xccodecov
xccodecov — Report code coverage with *.xcresult

## Installing
[MINT](https://github.com/yonaskolb/Mint)

```
$ mint install mnkd/xccodecov
```

## Build
```
$ make
```

If you want to use Xcode project, please run the following command.

```
$ swift package generate-xcodeproj
```

or

```
$ make xcodeproj
```

## Usage

```
USAGE: xccodecov <path> --project-name <project-name> [--config-path <config-path>] [--zero-coverage-files]

ARGUMENTS:
  <path>                  /path/to/*.xcresult

OPTIONS:
  -p, --project-name <project-name>
                          project name
  -c, --config-path <config-path>
                          path to configration file
  -z, --zero-coverage-files
                          show only files which is 0% coverage
  --version               Show the version.
  -h, --help              Show help information.
```

## Examples

```
$ ./xccodecov /path/to/*.xcresult -p AwesomeProject
```

You can report by specific folder. Input folders in the categories of the configuration file.
```
$ ./xccodecov /path/to/*.xcresult -p AwesomeProject -c /path/to/.xccodecov.yml
```

The configuration file has the following format.

```
categories:
  - "App"
  - "Data"
  - "Domain"
  - "Domain/Model"
  - "Domain/UseCase"
  - "UI"
```
