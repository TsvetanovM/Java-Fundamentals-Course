package Polymorphism.Shapes;

public class Rectangle extends Shape{
    private Double height;
    private Double width;

    public Rectangle(Double height, Double width) {
        this.height = height;
        this.width = width;
    }

    @Override
    public void calculatePerimeter() {
        this.perimeter = 2 * (height + width);
    }

    @Override
    public void calculateArea() {
        this.area = height * width;
    }

    public Double getHeight() {
        return height;
    }

    public Double getWidth() {
        return width;
    }
}
