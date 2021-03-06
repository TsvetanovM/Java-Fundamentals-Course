package softuni.fundamentals.java;

import java.util.Scanner;

public class Lab7 {
    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        String typeOfDay = scan.nextLine();
        int age = Integer.parseInt(scan.nextLine());
        int price = 0;
        if (age>=0 && age<=18){
            switch (typeOfDay){
                case "Weekday":
                  price = 12;
                  break;
                case "Weekend":
                    price = 15;
                    break;
                case "Holiday":
                    price = 5;
                    break;
            }
        }
        else if(age>18 && age<=64){
            switch (typeOfDay){
                case "Weekday":
                    price = 18;
                    break;
                case "Weekend":
                    price = 20;
                    break;
                case "Holiday":
                    price = 12;
                    break;
            }
        }
        else if(age>64 && age <=122){
            switch (typeOfDay){
                case "Weekday":
                    price = 12;
                    break;
                case "Weekend":
                    price = 15;
                    break;
                case "Holiday":
                    price = 10;
                    break;
            }
        }
        else {
            System.out.println("Error!");
        }
        if (price!=0){
            System.out.println(price+"$");
        }
    }
}
