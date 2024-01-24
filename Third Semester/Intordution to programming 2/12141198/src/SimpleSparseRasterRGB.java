import java.awt.*;

// This class represents a sparse 2D raster of RGB color entries. It has the same functionality
// as the class 'SimpleRasterRGB', but its implementation differs. It additionally has a
// flood-fill method.
//
// This class is efficient for representing images where only a small fraction of pixels is
// non-empty, meaning they have a color different from (0,0,0) corresponding to Color.BLACK.
// The class uses internally an object of 'SimplePointColorMap' to associate each non-empty
// pixel position (x,y) to the corresponding color. Only pixels with non-zero values are stored.
// Positions that are not in the set of keys of the map are considered to have value (0,0,0).
//
public class SimpleSparseRasterRGB {

    private int width;
    private int height;
    private SimplePointColorMap map;

    // Initialises this raster of the specified size as an empty
    // raster (all pixels being black, i.e. (R,G,B) = (0,0,0)).
    // Preconditions: height > 0, width > 0
    public SimpleSparseRasterRGB(int width, int height) {

        // TODO: implement constructor.
        if (width > 0 && height > 0) {
            this.height = height;
            this.width = width;
            this.map = new SimplePointColorMap(5);
        }
    }

    // Returns the color of the specified pixel.
    // Preconditions: (x,y) is a valid coordinate of the raster
    public Color getPixelColor(int x, int y) {

        // TODO: implement method.
        Point pickedPixel = new Point(x, y);
        if (map.get(pickedPixel) == null) {
            return Color.BLACK;
        }
        else {
            return map.get(pickedPixel);
        }
    }

    // Sets the color of the specified pixel. (If 'color' is 'Color.BLACK', the method
    // ensures that the pixel is not contained in the internal map.)
    // Preconditions: (x,y) is a valid coordinate of the raster, color != null
    public void setPixelColor(int x, int y, Color color) {

        // TODO: implement method.
        Point pickedPixel = new Point(x, y);
        Color pickedColor = color;

        map.put(pickedPixel, pickedColor);
    }

    // Returns the result of convolution of 'this' with the specified filter kernel. 'this' is not
    // changed by the method call.
    // The implementation of this method exploits the sparse structure of the raster by
    // calculating the convolution only at non-empty pixel positions.
    // Preconditions:
    // filterKernel != null && filterKernel.length > 0 &&
    // filterKernel.length % 2 == 1 &&
    // filterKernel.length == filterKernel[i].length (for valid i) &&
    // filterKernel.length < this.getWidth() &&
    // filterKernel.length < this.getHeight().
    public SimpleSparseRasterRGB convolve(double[][] filterKernel) {

        // TODO: implement method.
        SimpleSparseRasterRGB result = new SimpleSparseRasterRGB(this.width, this.height);
        SimplePointQueue queue = this.map.keys();

        // Map that keeps track of the pixels that have already been calculated.
        // This is used to avoid calculating the same pixel twice.
        SimplePointColorMap alreadyCalculated = new SimplePointColorMap(this.width * this.height);

        // Iterate through the queue and calculate the convolution for each pixel.
        while (queue.size() > 0) {
            Point p = queue.poll();
            if (alreadyCalculated.get(p) != null) {
                continue;
            }
            alreadyCalculated.put(p, Color.GREEN);

            double r = 0, g = 0, b = 0;
            for (int i = 0; i < filterKernel.length; i++) {
                for (int j = 0; j < filterKernel.length; j++) {
                    int x = p.getX() + i - filterKernel.length / 2;
                    int y = p.getY() + j - filterKernel.length / 2;

                    if (x >= 0 && x < this.width && y >= 0 && y < this.height) {
                        // If the pixel has not been calculated yet, add it to the queue.
                        // This allows to calculate the convolution for black pixels in the range of the filter kernel
                        // when applied to non-black pixels.
                        if (alreadyCalculated.get(new Point(x, y)) == null && (x != p.getX() || y != p.getY())) {
                            queue.add(new Point(x, y));
                        }
                        Color c = this.getPixelColor(x, y);
                        r += c.getRed() * filterKernel[i][j];
                        g += c.getGreen() * filterKernel[i][j];
                        b += c.getBlue() * filterKernel[i][j];
                    }
                }
            }
            result.setPixelColor(p.getX(), p.getY(), new Color((int) r, (int) g, (int) b));
        }
        return result;
    }

    // Returns the width of this raster.
    public int getWidth() {

        // TODO: implement method.
        return this.width;
    }

    // Returns the height of this raster.
    public int getHeight() {

        // TODO: implement method.
        return this.height;
    }

    // Sets the area of contiguous pixels of the same color to the specified color 'color', starting from
    // the initial pixel with position (x,y) and using 4-neighborhood. The method is not
    // recursive, instead it internally uses an object of 'SimplePointQueue' to which unprocessed
    // neighboring positions of the current position are added (the queue stores positions
    // that are still waiting to be processed).
    // 'floodFill' does nothing if the pixel at position (x,y) already has color 'color'.
    // Preconditions: (x,y) are valid coordinates of the raster, color != null.
    public void floodFill(int x, int y, Color color) {

        // TODO: implement method.
        SimplePointQueue queue = new SimplePointQueue(this.width * this.height);
        queue.add(new Point(x, y));
        Color initialColor = this.getPixelColor(x, y);

        while (queue.size() > 0) {
            Point p = queue.poll();
            if (this.getPixelColor(p.getX(), p.getY()).equals(initialColor)) {
                this.setPixelColor(p.getX(), p.getY(), color);
                if (p.getX() > 0) {
                    queue.add(new Point(p.getX() - 1, p.getY()));
                }
                if (p.getX() < this.width - 1) {
                    queue.add(new Point(p.getX() + 1, p.getY()));
                }
                if (p.getY() > 0) {
                    queue.add(new Point(p.getX(), p.getY() - 1));
                }
                if (p.getY() < this.height - 1) {
                    queue.add(new Point(p.getX(), p.getY() + 1));
                }
            }
        }
    }

    public void drawConnectedLines(SimplePointQueue pointQueue, Color color){
       if (pointQueue != null && color != null){
              while (pointQueue.size() > 1){
                Point p1 = pointQueue.poll();
                Point p2 = pointQueue.peek();
                this.drawLine(p1.getX(), p1.getY(), p2.getX(), p2.getY(), color);
              }
       }
    }

    // Draws a line from (x1,y1) to (x2,y2) in the raster using the Bresenham algorithm.
    // Preconditions:
    // (x1,y1) and (x2,y2) are valid coordinates of the raster, color != null.
    public void drawLine(int x1, int y1, int x2, int y2, Color color) {

        // TODO: implement method.
        int dx = Math.abs(x2 - x1);
        int dy = Math.abs(y2 - y1);
        int sx = x1 < x2 ? 1 : -1;
        int sy = y1 < y2 ? 1 : -1;
        int err = dx - dy;

        while (x1 != x2 || y1 != y2) {
            this.setPixelColor(x1, y1, color);

            int err2 = 2 * err;
            if (err2 > -dy) {
                err -= dy;
                x1 += sx;
            }
            if (err2 < dx) {
                err += dx;
                y1 += sy;
            }
        }
    }
}
