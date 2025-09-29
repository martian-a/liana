# iXSpec Test Runner Utilities

Potentially useful scripts, etc.

## Table of contents
1. [ANT wraper](#ant)
	1. [Summary](#summary)
	1. [How to use](#how-to-use)
	1. [Set-up](#set-up)
	1. [Dependencies](#dependencies)

## Summary

The only utility currently available is an ANT wrapper for running an iXSpec test file.

## ANT wrapper <a id="ant"></a>

### How to use <a id="how-to-use"></a>

Once everything is [set-up](#set-up), you can run an iXSpec test file from the command-line, for example:

```
ant -Dliana.ixspec=../test/cases/external_contexts.ixspec
```

NB. If you run the example test file (`test/cases/balisage_challenge_2025.ixspec`), it's expected that **two tests will FAIL** but all the others will pass. 

### Set-up <a id="set-up"></a>

Once the extra [dependencies](#dependencies) are in place, you will need to create a `local.properties` file.

1. Save a copy of `local.properties.example` as `local.properties` (in the same directory as `local.properties.example`)
1. Set `liana.xproc-processor` to either `morgana` or `calabash`, depending on which of those two supported XProc processors you intend to use
1. Change the values of the properties that are prefixed with `liana.lib.` so that the paths point to wherever you've installed these resources in your local environment.  You may also need to change some version numbers (in the properties file).
1. Optionally, you may also wish to change some of the following properties:
    * `liana.lib.catalogs.default` - _path to the project's default XML Catalog_
    * `liana.tmp-dir` - _path to the directory where temporary files will be created._ Default value: `ixspec-test-runner/utils/tmp`
    * `liana.tmp-dir.clean` - _set to `true` if you want `liana.tmp-dir` to be **deleted every time the ANT wrapper is run**_
    * `liana.output-dir` - _path to the directory where test result files will be saved._ Default value: `ixspec-test-runner/results`
    * `liana.output-dir.clean` - _set to `true` if you want `liana.output-dir` to be **deleted every time the ANT wrapper is run**_
    * `liana.debug` - _set to `true` if you would like the intermediary files to be stored in `liana.tmp-dir`_
    * `liana.xproc-processor` - _switch for controlling which of the supported XProc processors to use_ Valid values are: `calabash` or `morgana` (default)
 	* `liana.ixspec` - _path to the iXSpec test file to evaluate_


#### Optional extra configuration

Some additonal properties are set in the `project.properties` file:
* `liana.home` - _path to the root of this project_
* `liana.lib.xproc-processor.morgana.config` - _path to a Morgana configuration file_ 
* `liana.lib.xproc-processor.calabash.config` - _path to a Calabash configuration file_

If you want to change any of the above properties:
1. Copy the relevant line from `project.properties`
1. Paste it into `local.properties`
1. Change the value of that setting in `local.properties`

This will avoid your changes from being overwritten (or causing a conflict) the next time you update this repo to a newer version. 

##### XProc processor config files

This project includes very basic configuration files for Morgana and Calabash. If you want to use your own config file, add `liana.lib.xproc-processor.morgana.config` and/or `liana.lib.xproc-processor.calabash.config` to your `local.properties` file and change the path to point to your custom config file.

##### XML Catalog

Similarly, if you want to use your own XML Catalog, add `liana.lib.catalogs.default` to `local.properties` and change the path to point to your custom catalog. Your custom catalog should import this project's catalog, for example:
```
<?xml version="1.0" encoding="UTF-8"?>
<catalog xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog" prefer="system">
	
	...
	
	<nextCatalog catalog="path/to/ixspec-test-runner/catalog.xml" />
	
</catalog>
```

##### XSpec

You will need to create your own XML Catalog if you don't want to use the version of XSpec that is included in `lib/xspec`.  See `lib/catalog.xml`.

## Dependencies <a id="dependencies"></a>

**In addition** to the standard iXSpec dependencies, you will also need:

* Apache ANT
* ant-contrib

And you will need to create a `local.properties file`.

### Apache ANT

_Tested with v1.10.14_

* Download: https://ant.apache.org/bindownload.cgi
* Documentation: https://ant.apache.org/

### ant-contrib

_Tested with v1.0b3_

* Download: https://sourceforge.net/projects/ant-contrib/files/
* Documentation: https://ant-contrib.sourceforge.net/