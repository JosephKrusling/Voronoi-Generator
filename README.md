# Voronoi Image Generator
This is a Haskell image-processing utility which produces [Voronoi diagrams](https://en.wikipedia.org/wiki/Voronoi_diagram) as output. The visual effect resembles an obscured glass texture.

## Description
The program first generates a collection of points (known as seeds) within the bounds of the input image. In the output image, each pixel is colored according to the color of the nearest seed point. This process produces the interesting visual pattern shown below, where the entire image is composed of numerous Voronoi cells of irregular shapes.

To help choose more appropriate colors, the color of each cell is set to the average color of several pixels around the seed point. This produces a more representative color and prevents cells from being colored with outliers.

## Examples
![](static/mona.png) ![](static/mona-out.png)

## Remarks
The style of the output image can be changed considerably based on the strategy for selecting seed points. This program uses a very simple strategy of picking completlely random points. To produce a more clear image, an effective strategy would be placing more seed points in areas with higher complexity (less similar colors) and fewer points in regions with lower complexity. It would also be wise to place seed points on boundaries between different colors, so that the sharpness of the boundary is preserved in the Voronoi diagram.

