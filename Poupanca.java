public class Poupanca {
    public static void main(String[] args) {
        double p = 1000.0;
        double r = 0.05;
        
        System.out.printf("%-5s%20s%n", "Ano", "Valor em conta");

        for (int n = 1; n <= 10; n++) {
            double a = p * Math.pow(1 + r, n);
            System.out.printf("%-5d%20.2f%n", n, a);
        }
    }
}
