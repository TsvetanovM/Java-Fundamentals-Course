package softuni.fundamentals.java;

import java.util.Scanner;

public class Lab4 {
    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        int hour = Integer.parseInt(scan.nextLine());
        int minutes = Integer.parseInt(scan.nextLine());
        minutes+=30;
        if (minutes>59){
            hour++;
            minutes-=60;
        }
        if (hour>23){
            hour = 0;
        }
        System.out.printf("%d:%02d", hour, minutes);
    }
}
