package softuni.fundamentals.java;

import java.util.Scanner;

public class E04ReverseString {
    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        String input = scan.nextLine();
        String output = "";
        for (int i = input.length()-1; i >= 0 ; i--) {
            output += input.charAt(i);
        }
        System.out.println(output);
    }
}
