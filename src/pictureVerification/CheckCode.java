package pictureVerification;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.imageio.ImageIO;

public class CheckCode {

	private int width;
	private int height;
	/**
	 * 驗證碼所使用的顏色
	 */
	private List<Color> codeColorList;
	/**
	 * 亂碼位數
	 */
	private int codeLength;
	private Random random = new Random();

	/**
	 * 驗證碼圖片
	 */
	private BufferedImage buffImg;

	/**
	 * 驗證碼字串
	 */
	private String checkCodeStr;

	public CheckCode() {
		setWidth(200);
		setHeight(50);
		setCodeLength(6);
		codeColorList = new ArrayList<Color>();
	}
	
	public CheckCode(int width, int height, int codeLength) {
		// TODO Auto-generated constructor stub
		setWidth(width);
		setHeight(height);
		setCodeLength(codeLength);
		codeColorList = new ArrayList<Color>();
		setCheckCodeStr(createRandomCode());
		setBuffImg(disturb());
	}
	
	public CheckCode createCheckCode() {
		CheckCode checkCode = new CheckCode();
		checkCode.setCheckCodeStr(createRandomCode());
		checkCode.setBuffImg(disturb());

		return checkCode;
	}

	private String createRandomCode() {

		StringBuffer randomCode = new StringBuffer();
		String strRand = null;
		int startX = width / (codeLength + 1);	// 計算初始位置使用
		int startY = height - 7;

		/**
		 * 亂數池，不包括0、O、1、I等難辨認的字元，共32個字元
		 */
		char[] codeSequence = {
			'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 
			'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 
			'2', '3', '4', '5', '6', '7', '8', '9'
		};

		Graphics2D graphics = graphicsInit();	// 驗證碼圖片初始化

		// 一個字一個字畫出來，每個字都亂數決定大小和顏色
		for (int i = 0; i < codeLength; i++) {
			strRand = String.valueOf(codeSequence[random.nextInt(codeSequence.length)]);
			randomCode.append(strRand);
			
			Color codeColor = createColor();
			this.codeColorList.add(codeColor);
			graphics.setColor(codeColor);	// 設定字的隨機顏色
			
			graphics.setFont(createFont());	// 設定字體
			// 把產生的亂碼印在圖片座標((i+1)*xx, codeY)的地方
			graphics.drawString(strRand, (i + 1) * startX, startY);
		}
		
		// 扭曲文字
		shear(graphics, width, height, Color.WHITE);
		// 增加最多300個噪音點
		createNoisePoint(graphics, 300);
		
		return randomCode.toString();
	}

	/**
	 * 從十種顏色中，隨機挑選一種
	 * 
	 * @return
	 */
	private Color createColor() {
		Color[] color = new Color[10];
		// 橘色
		color[0] = new Color(255, 176, 38);
		color[1] = new Color(255, 185, 62);
		color[2] = new Color(255, 116, 31);
		// 藍色
		color[3] = new Color(58, 156, 241);
		color[4] = new Color(32, 136, 244);
		color[5] = new Color(48, 148, 242);
		// 綠色
		color[6] = new Color(55, 208, 74);
		// 紫色
		color[7] = new Color(188, 41, 181);
		// 紅色
		color[8] = new Color(237, 27, 32);
		// 黃色
		color[9] = new Color(232, 226, 32);

		return color[random.nextInt(10)];
	}
	
	/**
	 * 獲得隨機的顏色
	 * @return
	 */
	public Color getRandomColor() {
		Random random = new Random();
		return new Color(random.nextInt(255), random.nextInt(255), random
				.nextInt(255));
	}
	
	/**
	 * 傳回某顏色的對比色
	 * @param c
	 * @return
	 */
	public Color getReverseColor(Color c) {
		return new Color(255 - c.getRed(), 255 - c.getGreen(), 255 - c
				.getBlue());
	}
	
	/**
	 * 十種字體亂數選擇一種
	 * 
	 * @return
	 */
	public Font createFont() {
		Font[] font = new Font[10];
		font[0] = new Font(Font.SANS_SERIF, Font.BOLD, getRandomFontSize(14, height - 2));
		font[1] = new Font(Font.SERIF, Font.BOLD, getRandomFontSize(14, height - 2));
		font[2] = new Font(Font.DIALOG_INPUT, Font.BOLD, getRandomFontSize(14, height - 2));
		font[3] = new Font(Font.MONOSPACED, Font.BOLD, getRandomFontSize(14, height - 2));
		font[4] = new Font(Font.SANS_SERIF, Font.ITALIC, getRandomFontSize(14, height - 2));
		font[5] = new Font(Font.SERIF, Font.ITALIC, getRandomFontSize(14, height - 2));
		font[6] = new Font(Font.DIALOG_INPUT, Font.ITALIC, getRandomFontSize(14, height - 2));
		font[7] = new Font(Font.MONOSPACED, Font.ITALIC, getRandomFontSize(14, height - 2));
		font[8] = new Font(Font.SANS_SERIF, Font.PLAIN, getRandomFontSize(14, height - 2));
		font[9] = new Font(Font.MONOSPACED, Font.PLAIN, getRandomFontSize(14, height - 2));
		
		return font[random.nextInt(10)];
	}

	private Graphics2D graphicsInit() {
		Graphics2D graphics = buffImgInit().createGraphics();
		graphics.setColor(Color.WHITE);	// 設定背景顏色
		graphics.fillRect(0, 0, width, height);	// 繪製背景
		graphics.setFont(new Font("Fixedsys", Font.BOLD, height - 2)); // 設定預設字體
		graphics.drawRect(0, 0, width - 1, height - 1);

		return graphics;
	}

	/**
	 * 
	 * @Description:BufferedImage初始化
	 * 
	 * @return BufferedImage
	 */

	private BufferedImage buffImgInit() {
		buffImg = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		return buffImg;
	}

	/**
	 * 畫雜訊
	 * 
	 * @return
	 */
	private BufferedImage disturb() {
		drawDisturbLine(buffImg.createGraphics());
		return buffImg;
	}

	/**
	 * 畫干擾線
	 * 
	 * @param graphics
	 */
	private void drawDisturbLine(Graphics2D graphics) {		
		int x = 0;
		int y = 0;
		int xl = 0;
		int yl = 0;

		// 	15條干擾線
		for (int i = 0; i < 5; i++) {
			x = 0;
			y = random.nextInt(height);
			xl = random.nextInt(300);
			yl = random.nextInt(300);
			graphics.setColor(createColor());
			graphics.drawLine(x, y, x + xl, y + yl);
		}
		
		for (int i = 0; i < 5; i++) {
			x = width;
			y = random.nextInt(height);
			xl = random.nextInt(300);
			yl = random.nextInt(300);
			graphics.setColor(createColor());
			graphics.drawLine(x, y, x + xl, y + yl);
		}
		
		for (int i = 0; i < 5; i++) {
			x = random.nextInt(width);
			y = height;
			xl = random.nextInt(300);
			yl = random.nextInt(300);
			graphics.setColor(createColor());
			graphics.drawLine(x, y, x + xl, y + yl);
		}
		
		for (int i = 0; i < 5; i++) {
			x = random.nextInt(width);
			y = 0;
			xl = random.nextInt(300);
			yl = random.nextInt(300);
			graphics.setColor(createColor());
			graphics.drawLine(x, y, x + xl, y + yl);
		}
	}
	
	/**
	 * 字體扭曲
	 * 
	 * @param graphic
	 * @param width
	 * @param height
	 * @param color
	 */
	private void shear(Graphics graphic, int width, int height, Color color) {

		shearX(graphic, width, height, color);
		shearY(graphic, width, height, color);
	}

	public void shearX(Graphics graphic, int width, int height, Color color) {

		int period = random.nextInt(2);

		boolean borderGap = true;
		int frames = 2;
		int phase = random.nextInt(2);

		for (int i = 0; i < height; i++) {
			double d = (double) (period >> 1)
					* Math.sin((double) i / (double) period
							+ (6.2831853071795862D * (double) phase)
							/ (double) frames);
			graphic.copyArea(0, i, width, 1, (int) d, 0);
			if (borderGap) {
				graphic.setColor(color);
				graphic.drawLine((int) d, i, 0, i);
				graphic.drawLine((int) d + width, i, width, i);
			}
		}
	}

	public void shearY(Graphics graphic, int width, int height, Color color) {
		int period = random.nextInt(10) + 10; // 20;

		boolean borderGap = true;
		int frames = 5;
		int phase = 2;
		for (int i = 0; i < width; i++) {
			double d = (double) (period >> 1) * Math.sin((double) i / (double) period
							+ (6.2831853071795862D * (double) phase) / (double) frames);
			graphic.copyArea(i, 0, 1, height, 0, (int) d);
			if (borderGap) {
				graphic.setColor(color);
				graphic.drawLine(i, (int) d, i, 0);
				graphic.drawLine(i, (int) d + height, i, height);
			}
		}
	}
	
	/**
	 * 畫出噪音點
	 * 
	 * @param graphic
	 */
	public void createNoisePoint(Graphics graphic, int pointNumber) {
		for (int i = 0, n = random.nextInt(pointNumber); i < n; i++) {	// 繪製最多pointNumber個噪音點
			graphic.drawRect(random.nextInt(width), random.nextInt(height), 1, 1);	// 隨機噪音點
		}
	}
	
	/**
	 * 將圖片輸出到文件
	 * 
	 * @param pathName
	 * @return
	 */
	public String createImgFile(String pathName) {
		File file = new File(pathName);
		if (file.isFile() && file.exists()) {
			file.delete();
		}
		try {
			ImageIO.write(buffImg, "jpeg", file);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return pathName;
	}
	
	/**
	 * 獲得隨機的字體大小，範圍在min到max之間
	 * @return
	 */
	public static int getRandomFontSize(int min, int max) {
		Random rand = new Random();
		return rand.nextInt((max - min) + 1) + min;
	}

	public BufferedImage getBuffImg() {
		return buffImg;
	}

	public void setBuffImg(BufferedImage buffImg) {
		this.buffImg = buffImg;
	}

	public String getCheckCodeStr() {
		return checkCodeStr;
	}

	public void setCheckCodeStr(String checkCodeStr) {
		this.checkCodeStr = checkCodeStr;
	}

	public int getWidth() {
		return width;
	}

	public void setWidth(int width) {
		this.width = width;
	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public int getCodeCount() {
		return codeLength;
	}

	public void setCodeLength(int codeCount) {
		this.codeLength = codeCount;
	}

}
