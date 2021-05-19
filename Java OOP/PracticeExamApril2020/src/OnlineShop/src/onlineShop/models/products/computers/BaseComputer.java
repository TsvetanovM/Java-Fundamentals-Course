package OnlineShop.src.onlineShop.models.products.computers;

import OnlineShop.src.onlineShop.models.products.BaseProduct;
import OnlineShop.src.onlineShop.models.products.components.Component;
import OnlineShop.src.onlineShop.models.products.peripherals.Peripheral;

import java.util.List;

public abstract class BaseComputer extends BaseProduct implements Computer {

    private List<Component> components;
    private List<Peripheral> peripherals;

    public BaseComputer(int id, String manufacturer, String model, double price, double overallPerformance) {
        super(id, manufacturer, model, price, overallPerformance);
    }

    @Override
    public List<Component> getComponents() {
        return null;
    }

    @Override
    public List<Peripheral> getPeripherals() {
        return null;
    }

    @Override
    public void addComponent(Component component) {

    }

    @Override
    public Component removeComponent(String componentType) {
        return null;
    }

    @Override
    public void addPeripheral(Peripheral peripheral) {

    }

    @Override
    public Peripheral removePeripheral(String peripheralType) {
        return null;
    }

    @Override
    public String toString() {
        return "BaseComputer{" +
                "components=" + components +
                ", peripherals=" + peripherals +
                '}';
    }
}
