import java.util.Scanner;

public class Quadrado {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);

        int tamanho;
        do {
            System.out.print("Digite o tamanho do lado do quadrado (entre 1 e 20): ");
            tamanho = input.nextInt();
        } while (tamanho < 1 || tamanho > 20);

        for (int i = 1; i <= tamanho; i++) {
            for (int j = 1; j <= tamanho; j++) {
                if (i == 1 || i == tamanho || j == 1 || j == tamanho) {
                    System.out.print("*");
                } else {
                    System.out.print(" ");
                }
            }
            System.out.println();
        }

        input.close();
    }
}
