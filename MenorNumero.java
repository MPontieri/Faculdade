import java.util.Scanner;
public class MenorNumero {
	public static void main(String[] args) {
		Scanner input = new Scanner(System.in);
		System.out.print("Quantos números você deseja inserir? ");
		int quantidadeNumeros = input.nextInt();
		if (quantidadeNumeros <= 0) {
			System.out.println("A quantidade de números deve ser maior que zero.");
			exit();
		}
		System.out.print("Digite o número 1: ");
		int menor = input.nextInt();
		for (int i = 2; i <= quantidadeNumeros; i++) {
			System.out.print("Digite o número " + i + ": ");
			int numero = input.nextInt();
			if (numero < menor) {
				menor = numero;
			}
		}
		System.out.println("O menor número inserido foi: " + menor);
	}
}
