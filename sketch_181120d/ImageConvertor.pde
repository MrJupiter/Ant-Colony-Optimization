/**
 * @author  Abdelmalik GHOUBIR <ghoubir.abdo@gmail.com>
 */

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public abstract class ImageConvertor {
    protected String pathInputImage;
    protected BufferedImage image = null;
    protected int width;
    protected int height;

    public ImageConvertor(String pathInputImage) {
        this.pathInputImage = pathInputImage;
    }

    public abstract void convert(String pathOutputImage);

    protected BufferedImage readImage() {
        try {
            File f = new File(pathInputImage);
            image = ImageIO.read(f);
            width = image.getWidth();
            height = image.getHeight();
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
        return image;
    }

    protected void writeImage(String pathOutputImage) {
        try {
            File f = new File(pathOutputImage);
            ImageIO.write(image, "jpg", f);
        } catch (IOException e) {
            System.out.println(e);
        }
    }

}
