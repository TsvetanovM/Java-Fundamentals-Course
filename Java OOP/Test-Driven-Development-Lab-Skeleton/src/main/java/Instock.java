import jdk.jshell.spi.ExecutionControl;

import java.util.*;

public class Instock implements ProductStock {
    private Map<String, Product> products;

    public Instock() {
        this.products = new LinkedHashMap<>();
    }

    @Override
    public Integer getCount() {
        return products.size();
    }

    @Override
    public Boolean contains(Product product) {
        return this.products.containsKey(product.getLabel());
    }

    @Override
    public void add(Product product) {
        if (!contains(product)) {
            this.products.put(product.getLabel(), product);
        }
    }

    @Override
    public void changeQuantity(String label, int quantity) {
        checkIfProductExists(label);
        Product product = this.products.get(label);
        product.setQuantity(product.getQuantity() + quantity);
    }

    @Override
    public Product find(int index) {
        return new ArrayList<>(this.products.values()).get(index);
    }

    @Override
    public Product findByLabel(String label) {
        checkIfProductExists(label);
        return products.get(label);
    }

    private void checkIfProductExists(String label) {
        if (!this.products.containsKey(label)) {
            throw new IllegalArgumentException();
        }
    }

    @Override
    public Iterable<Product> findFirstByAlphabeticalOrder(int count) {
        return null;
    }

    @Override
    public Iterable<Product> findAllInRange(double lo, double hi) {
        return null;
    }

    @Override
    public Iterable<Product> findAllByPrice(double price) {
        return null;
    }

    @Override
    public Iterable<Product> findFirstMostExpensiveProducts(int count) {
        return null;
    }

    @Override
    public Iterable<Product> findAllByQuantity(int quantity) {
        return null;
    }

    @Override
    public Iterator<Product> iterator() {
        return null;
    }
}
