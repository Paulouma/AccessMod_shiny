#![](https://raw.githubusercontent.com/fxi/accessModShiny/master/www/logo/icons/logo32x32.png) _AccessmMod 5_

Table of contents

* [Summary](#summary)
* [User manual](#user-manual)
* [Issues](#issues)

## Summary 

This is the main reposotory of `AccessMod 5`.

`AccessMod 5` is a tool to analyse geographical accessibility to or from given locations, using anisotropic movements and multimodal transport process (e.g. walk, bicycle, motorized vehicles). This package may help to analyse catchments of peoples who can reach a central point in a given time and transport model or determine where new public services should be scaled up in priority.

This product is developed by the Department of Health Systems Financing (WHO/HSS/HSF) in collaboration with the WHO Vulnerability and Risk Analysis & Mapping programme (VRAM).

In Fig. 1, we can see an exemple of the cumulative time map produced with the module 2 of `AccessMod 5`, displayed here in a compostion created with the map composer in QGIS.

<figure>
<img src="https://raw.githubusercontent.com/wiki/fxi/accessModShiny/img/anisoCumulativeCostSample.jpg" alt="Accessmod 5, module 2 : cumulative cost">
</a>
<figcaption>
Fig. 1<em> Example of cumulative time map computed with multimodal transportation scheme, anisotropic displacement for a sample region.</em>
<hr>
</figcaption>
</figure>

## Installation

`AccessMod 5` has multiple parts:

* `Accessmod_shiny` : the [core functionalties](https://github.com/fxi/AccessMod_shiny) of the project. Uses mainly [R](http://cran.r-project.org), [shiny](http://shiny.rstudio.com/), and [GRASS GIS](grass.osgeo.org/grass70).
* `Accessmod_r.walk`: a [modified version](https://github.com/fxi/AccessMod_r.walk)  of the module r.walk from [GRASS GIS](grass.osgeo.org/grass70). Compute anisotropic cost with multimodal transport process.
* `Accessmod_server` : a [virtual machine](https://github.com/fxi/AccessMod_server) to provide a portable environment for `AccessMod 5`

If you want to produce a full working environment for `AccessMod 5` without installing a virtual server, you can look the dependencies in the [provisioning file](https://raw.githubusercontent.com/fxi/accessmodServer/master/provision.sh).

## Issues

The bugs and new functionality should be reported here :
[`AccessMod 5` issues](https://github.com/fxi/accessModShiny/issues)
