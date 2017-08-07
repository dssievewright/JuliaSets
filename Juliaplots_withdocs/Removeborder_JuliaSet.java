import edu.duke.*;
import java.io.*;

// Problem: image() in R creates a white border around the actual picture.  
// I'll remove border and set it equal to outer most color of image I'm interested in.
// Used for Julia Sets where outer most color was #00008B, equivalent to rgb = (0,0,139), a.k.a. "darkblue".

public class Removeborder_JuliaSet{

	public static ImageResource recolorborder(ImageResource inImage){
		ImageResource outImage = new ImageResource(inImage.getWidth() - 90, inImage.getHeight() - 140);
		for(Pixel pixel : outImage.pixels()){
			Pixel inpixel = inImage.getPixel(pixel.getX() + 60,pixel.getY() + 60);
			pixel.setRed(inpixel.getRed());
			pixel.setGreen(inpixel.getGreen());
			pixel.setBlue(inpixel.getBlue());
		}
		return outImage;
	}


	public static void main(String[] args){
	DirectoryResource dr = new DirectoryResource();
		for (File f : dr.selectedFiles()) {
			ImageResource inImage = new ImageResource(f);
			String inname = inImage.getFileName();
			String newname = f.getParent() + "/borderless-" + inname;
			ImageResource rborder = recolorborder(inImage);
			rborder.setFileName(newname);
			rborder.draw();
			rborder.save();
		}
	}
}
