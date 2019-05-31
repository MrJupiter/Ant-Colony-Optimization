/**
 * @author  Abdelmalik GHOUBIR <ghoubir.abdo@gmail.com>
 */

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.awt.image.WritableRaster;
import java.io.File;
import java.io.IOException;

public class Image2Bin extends ImageConvertor {

    public Image2Bin(String pathInputImage) {
        super(pathInputImage);
    }

    public void convert(String pathOutputImage) {
        readImage();
        try {
            File f = new File(pathOutputImage);
            ImageIO.write(criaImagemBinaria(), "jpg", f);
        } catch (IOException e) {
            System.out.println(e);
        }
    }

    private BufferedImage criaImagemCinza() {
        // Create a new buffer to BYTE_GRAY
        BufferedImage img = new BufferedImage(width, height, BufferedImage.TYPE_BYTE_GRAY);
        WritableRaster raster = img.getRaster();
        WritableRaster rasterJPEG = image.getRaster();
        // Foreach pixel we transform it to Gray Scale and put it on the same image
        for (int h = 0; h < height; h++) {
            for (int w = 0; w < width; w++) {
                int[] p = new int[4];
                rasterJPEG.getPixel(w, h, p);
                p[0] = (int)(0.3 * p[0]);
                p[1] = (int)(0.59 * p[1]);
                p[2] = (int)(0.11 * p[2]);
                int y = p[0] + p[1] + p[2];
                raster.setSample(w, h, 0, y);
            }
        }
        return img;
    }

    private BufferedImage criaImagemBinaria() {
        // Create a new Binary Buffer
        BufferedImage img = new BufferedImage(width, height, BufferedImage.TYPE_BYTE_BINARY);
        WritableRaster raster = img.getRaster();
        WritableRaster rasterPB = criaImagemCinza().getRaster();
        // Foreach pixel  check if the new one must be white or black
        int threshold = 127;
        for (int h = 0; h < height; h++) {
            for (int w = 0; w < width; w++) {
                int[] p = new int[1];
                rasterPB.getPixel(w, h, p);
                raster.setSample(w, h, 0, (p[0] > threshold) ? 1 : 0);
            }
        }
        return img;
    }
}
