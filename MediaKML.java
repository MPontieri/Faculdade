import java.util.Scanner;

public class MediaKML {
    public static void main(String[]args){
        Scanner scanner = new Scanner(System.in);
        System.out.print("Digite quantos quilometros foram percorridos: ");
        double km = scanner.nextDouble();
        System.out.print("Digite quantos litros de combustivel foram gastos: ");
        double litro = scanner.nextDouble();

        double media;
        media = km/litro;

        System.out.printf("A media deste trecho realizado pelo motorista foi de: %.1f",media);

    }
}
