# iXSpec Tests

## Table of contents
1. [Summary](#summary)
1. [How to run](#how-to-run)

## Summary

Tests for the iXSpec source code and how to run them.

## How to run <a id="how-to-run"></a>

Use iXSpec to run the `*.ixspec` files in `test/cases`.  For a guide on how to do this using Morgana or Calabash, see `How to run` in the `README` in the root of this project. 

If you've already set-up the iXSpec ANT wrapper utility then you can use that to run the tests:

```
ant -Dliana.ixspec=../test/cases/external_contexts.ixspec
```

NB. If you run the example test file (`test/cases/external_contexts.ixspec`), it's expected that **two tests will FAIL** but all the others will pass. 