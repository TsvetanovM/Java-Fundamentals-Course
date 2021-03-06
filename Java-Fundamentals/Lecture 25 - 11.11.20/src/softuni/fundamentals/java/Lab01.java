package softuni.fundamentals.java;

import java.text.DecimalFormat;
import java.util.Arrays;
import java.util.Map;
import java.util.Scanner;
import java.util.TreeMap;

public class Lab01 {
    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);

        double[] numbers = Arrays.stream(scan.nextLine().split(" ")).mapToDouble(Double::parseDouble).toArray();
        Map<Double, Integer> counts = new TreeMap<>();
        for (double number : numbers) {
            if (!counts.containsKey(number)){
                counts.put(number, 0);
            }
            counts.put(number, counts.get(number)+1);
        }
        for (Map.Entry<Double, Integer> Entry : counts.entrySet()) {
            DecimalFormat df = new DecimalFormat("#.########");
            System.out.printf("%s -> %d%n", df.format(Entry.getKey()), Entry.getValue());
        }
    }
}
