# mosaic-image-reproduction
Project in the course TNM097, Linköping University, 2018.

Reproduction of arbitrary image using random 20x20 images in a database. The input image is divided into a 20x20 meshgrid, where each grid is compared to the database images. The database image with closest distance in CIELAB color space and structural similarity, given certain weights, replaces the grid image. Lastly some postprocessing is conducted, including e.g. laplace filtering.
