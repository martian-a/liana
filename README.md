# iXSpec Test Runner

Status: Version 1.1.0-alpha released (2025-09-05)

An (unofficial) extension to XSpec, for writing and running tests for Invisible XML (iXML).

## Table of contents
1. [Summary](#summary)
1. [How to use](#how-to-use)
1. [Create an iXSpec test file](#how-to-write)
1. [Set-up](#set-up)
1. [Dependencies](#dependencies)
1. [Etymology](#etymology)

## Summary

An (unofficial) extension to XSpec, for writing and running tests for Invisible XML (iXML).

## How to use <a id="how-to-use"></a>

Once all [set-up](#set-up) is complete, you can run an iXSpec test file from the command-line, for example:

_Morgana:_
```
java -cp path/to/MorganaXProc-IIIse.jar:path/to/MorganaXProc-IIIse_lib/*:path/to/saxon.jar:path/to/saxon/lib/*:path/to/coffeepot/lib/*:path/to/coffeepot.jar /
	com.xml_project.morganaxproc3.XProcEngine /
	-config=src/configs/morgana/default.xml /
	src/xproc/ixspec.xpl -cp / 
	-catalogs=catalog.xml /
	-input:source=test/ixml/dtd_declaration.ixspec / 
	-output:result=results/dtd_declaration.html
```

_Calabash:_
```
java -cp path/to/xmlcalabash-3/lib/*:path/to/xmlcalabash-3/xmlcalabash.jar /
	com.xmlcalabash.app.Main / 
	--configuration:src/configs/morgana/default.xml /
	--input:text/plain@source=test/ixml/dtd_declaration.ixspec / 
	--output:result=results/dtd_declaration.html /
	--catalog:catalog.xml /
	src/xproc/ixspec.xpl
	
```
If you use the example file (`test/ixml/dtd_declaration.ixspec`), it's expected that **two tests will FAIL** but all the others will pass. 

### Notes

If you're running the command on Microsoft Windows, you may need to replace the colons in the classpath with semi-colons, eg. `path/to/MorganaXProc-IIIse.jar;path/to/MorganaXProc-IIIse_lib/*;path/to/saxon.jar;path/to/saxon/lib/*;path/to/coffeepot/lib/*;path/to/coffeepot.jar`

If you're using Morgana:
* the second `-cp` in the command-line is an instruction to create any missing output directories, ie. `results`
* Saxon needs to be after Morgana in the classpath because of an XML resolver clash, see [https://sourceforge.net/p/morganaxproc-iiise/tickets/192/]()
* Saxon needs to be before any other tools or libraries on the classpath (other than Morgana itself) that also include a saxon jar as Morgana will use the first saxon jar it finds

## Create an iXSpec test file <a id="how-to-write"></a>

For an example of an iXSpec test file, see `test/ixml/dtd_declaration.ixspec`.

When writing your own, you need to be aware of 3 main differences to writing an XSpec for XSLT test file:
* use @ixml-grammar instead of @stylesheet
* the context for each test needs to be loaded from an external file
* the namespace is different

### How to specify which Invisible XML grammar to test

Populate this attribute with a path to the Invisible XML grammar you wish to test, eg. `ixml-grammar="path/to/my_grammar.ixml"`

### How to specify the string to be parsed

1. Save the string in a file
1. Specify the path to that file using x:scenario/x:context/@href

Example:
```
<x:scenario label="System">
	
	<x:context href="../data/input/text/xhtml_system_path.txt" />
	
	...		
	
</x:scenario>
```

### Why is the namespace different

* To make it harder to confuse an iXSpec file for a standard XSpec test file.
* Not all XSpec functionality is relevant to iXSpec

#### Can I still validate an iXSpec file?

Yes. The schema for iXSpec is in `src/schemas/ixspec.rnc`.

### How do I write the tests?

Other than the differences detailed above, an iXSpec test is written the same way as a standard XSpec for XSLT test file.  See [https://github.com/xspec/xspec/wiki/Writing-Scenarios]()

## Set-up <a id="set-up"></a>

1. Clone this repository and its submodules: `git clone --recurse-submodules -j8 <repo-url>`
1. Install any missing [dependencies](#dependencies)

## Dependencies <a id="dependencies"></a>

* XSpec (included in this repo as a git submodule)
* An XProc processor:
	* MorganaXProc III 
	* XML Calabash 3
* Saxon _(already included in XML Calabash 3)_
* CoffeePot _(already included in XML Calabash 3)_ 
* An XML Resolver _(already included in XML Calabash 3)_

It's likely that you have some of these installed already.

### XSpec

_Tested with the master branch as of 2025-09-05_

XSpec is included in this repository as a GIT submodule. See `<repository_root>/lib/xspec` 

* Download: https://github.com/xspec/xspec/releases
* Documentation: https://github.com/xspec/xspec/wiki

The XProc 3 implementation is new and hasn't yet been included in an official release.

### XProc Processor

#### MorganaXProc III

_Tested with Standard Edition (SE) v1.6.10_

* Download: https://sourceforge.net/projects/morganaxproc-iiise/
* Documentation: https://www.xml-project.com/morganaxproc-iiise.html

#### XML Calabash 3

_Tested with v3.0.10_

* Download: https://sourceforge.net/projects/morganaxproc-iiise/
* Documentation: https://www.xml-project.com/morganaxproc-iiise.html

### Saxon

_Tested with Home Edition v12.3_

You only need to install this separately if you're using Morgana because Saxon is already included in the library that ships with XML Calabash.

* Download: https://www.saxonica.com/download/java.xml
* Documentation: https://www.saxonica.com/documentation/documentation.xml

### CoffeePot

_Tested with v3.2.6_

You only need to install this separately if you're using Morgana because CoffeePot is already included in the library that ships with XML Calabash.

* Download: https://github.com/nineml/coffeepot/releases
* Documentation: https://docs.nineml.org/current/coffeepot/


### XML Resolver

_Tested with v6.0.17_

You only need to install this separately if you're using Morgana because XML Resolver is already included in the library that ships with XML Calabash.

* Download: https://github.com/xmlresolver/xmlresolver
* Documentation: https://xmlresolver.org/

You can use any XML catalog resolver, it doesn't need to be the one I've linked to.

## Etymology <a id="etymology"></a>

This project's "barn name" is Liana (_lee-ah-na_), after the woody vines that grow up around trees [https://en.wikipedia.org/wiki/Liana](https://en.wikipedia.org/wiki/Liana).  It belongs to a collection of repositories that have tree-themed names (they're not all public).  That liana's aren't themselves trees, but instead follow the form of the tree they grow up around, is a nod to how invisible XML is used to reveal the form of an XML tree.

However, "iXSpec Test Runner" better describes what this tool does.
